//===------------ main.swift - Entry point for lit-test-help --------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//


import SwiftSyntax
import SwiftSyntaxParser
import Foundation

/// Print the given message to stderr
func printerr(_ message: String, terminator: String = "\n") {
  FileHandle.standardError.write((message + terminator).data(using: .utf8)!)
}

/// Print the help message
func printHelp() {
  print("""
    Utility to test SwiftSyntax syntax tree creation.

    Actions (must specify one):
      -classify-syntax
            Parse the given source file (-source-file) and output it with
            tokens classified for syntax colouring.
      -parse-incremental
            Parse a pre-edit source file (-old-source-file) and incrementally
            parse the post-edit source file (-source-file) that was the result
            of applying the given edits (-incremental-edit).
      -roundtrip
            Parse the given source file (-source-file) and print it out using
            its syntax tree.
      -verify-roundtrip
            Parse the given source file (-source-file) and exit with a non-zero
            exit code if printing the tree does not result in the original
            source file.
      -print-tree
            Parse the given source file (-source-file) and output its syntax
            tree.
      -help
            Print this help message

    Arguments:
      -source-file FILENAME
            The path to a Swift source file to parse
      -old-source-file FILENAME
            Path to the pre-edit source file to translate line:column edits into
            the file's byte offsets.
      -incremental-edit EDIT
            An edit that was applied to reach the input file from the source
            file that generated the old syntax tree in the format <start-line>:
            <start-column>-<end-line>:<end-column>=<replacement> where start and
            end are dfined in terms of the pre-edit file and <replacement> is
            the string that shall replace the selected range. Can be passed
            multiple times.
      -reparse-region REGION
            If specified, an error will be emitted if any part of the file
            ouside of the reparse region gets parsed again. Can be passed
            multiple times to specify multiple reparse regions. Reparse regions
            are specified in the form <start-column>-<end-line>:<end-column> in
            terms of the post-edit file.
      -incremental-reuse-log FILENAME
            Path to which a log should be written that describes all the nodes
            reused during incremental parsing.
      -out FILENAME
            The file to which the source representation of the post-edit syntax
            tree shall be written.
      -swift-version
            Interpret input according to a specific Swift language version
            number
      -enable-bare-slash-regex [0|1]
            Enable or disable the use of forward slash regular-expression
            literal syntax
    """)
}

extension CommandLineArguments {
  func getIncrementalEdits() throws -> [IncrementalEdit] {
    let regex = try NSRegularExpression(
      pattern: "([0-9]+):([0-9]+)-([0-9]+):([0-9]+)=(.*)")
    var parsedEdits = [IncrementalEdit]()
    let editArgs = try self.getValues("-incremental-edit")
    for edit in editArgs {
      guard let match =
          regex.firstMatch(in: edit,
                           range: NSRange(edit.startIndex..., in: edit)) else {
        throw CommandLineArguments.InvalidArgumentValueError(
          argName: "-incremental-edit",
          value: edit
        )
      }
      let region = getSourceRegion(match, text: edit)
      let replacement = match.match(at: 5, text: edit)
      parsedEdits.append(IncrementalEdit(
        region: region,
        replacement: replacement
      ))
    }
    return parsedEdits
  }

  func getReparseRegions() throws -> [SourceRegion] {
    let regex = try NSRegularExpression(
      pattern: "([0-9]+):([0-9]+)-([0-9]+):([0-9]+)")
    var reparseRegions = [SourceRegion]()
    let regionArgs = try self.getValues("-reparse-region")
    for regionStr in regionArgs {
      guard let match =
          regex.firstMatch(in: regionStr,
              range: NSRange(regionStr.startIndex..., in: regionStr)) else {
        throw CommandLineArguments.InvalidArgumentValueError(
          argName: "-reparse-region",
          value: regionStr
        )
      }
      let region = getSourceRegion(match, text: regionStr)
      reparseRegions.append(region)
    }
    return reparseRegions
  }

  private func getSourceRegion(_ match: NSTextCheckingResult,
                               text: String) -> SourceRegion {
    let matchAsInt = { (i: Int) -> Int in
      return Int(match.match(at: i, text: text))!
    }

    let startLine = matchAsInt(1)
    let startColumn = matchAsInt(2)
    let endLine = matchAsInt(3)
    let endColumn = matchAsInt(4)
    return SourceRegion(
      startLine: startLine,
      startColumn: startColumn,
      endLine: endLine,
      endColumn: endColumn
    )
  }
}

extension NSTextCheckingResult {
  func match(at: Int, text: String) -> String {
    let range = self.range(at: at)
    let text = String(text[Range(range, in: text)!])
    return text
  }
}

struct ByteSourceRangeSet {
  var ranges = [ByteSourceRange]()

  mutating func addRange(_ range: ByteSourceRange) {
    ranges.append(range)
  }

  func inverted(totalLength: Int) -> ByteSourceRangeSet {
    var result = ByteSourceRangeSet()
    var currentOffset = 0
    for range in ranges {
      assert(currentOffset <= range.offset,
             "Ranges must be sorted in ascending order and not be overlapping")
      if currentOffset < range.offset {
        result.addRange(ByteSourceRange(offset: currentOffset,
                                        length: range.offset-currentOffset))
      }
      currentOffset = range.endOffset
    }
    if currentOffset < totalLength {
      result.addRange(ByteSourceRange(offset: currentOffset,
                                      length: totalLength-currentOffset))
    }

    return result
  }

  func intersected(_ other: ByteSourceRangeSet) -> ByteSourceRangeSet {
    var intersection = ByteSourceRangeSet()
    for A in self.ranges {
      for B in other.ranges {
        let partialIntersection = A.intersected(B)
        if !partialIntersection.isEmpty {
          intersection.addRange(partialIntersection)
        }
      }
    }
    return intersection
  }
}

struct SourceRegion {
  let startLine: Int
  let startColumn: Int
  let endLine: Int
  let endColumn: Int
}

struct IncrementalEdit {
  let region: SourceRegion
  let replacement: String
}

func getSwiftLanguageVersionInfo(args: CommandLineArguments) -> (languageVersion: String?, enableBareSlashRegexLiteral: Bool?) {
  return (
    args["-swift-version"],
    args["-enable-bare-slash-regex"].map({ $0 == "1" })
  )
}

/// Rewrites a parsed tree with all constructed nodes.
class TreeReconstructor : SyntaxRewriter {
  override func visit(_ token: TokenSyntax) -> Syntax {
    let token = TokenSyntax(
      token.tokenKind,
      leadingTrivia: token.leadingTrivia,
      trailingTrivia: token.trailingTrivia,
      presence: token.presence)
    return Syntax(token)
  }
}

func performClassifySyntax(args: CommandLineArguments) throws {
  let treeURL = URL(fileURLWithPath: try args.getRequired("-source-file"))
  let versionInfo = getSwiftLanguageVersionInfo(args: args)

  let tree = try SyntaxParser.parse(treeURL, languageVersion: versionInfo.languageVersion, enableBareSlashRegexLiteral: versionInfo.enableBareSlashRegexLiteral)
  let result = ClassifiedSyntaxTreePrinter.print(Syntax(tree))
  do {
    // Sanity check that we get the same result if the tree has constructed nodes.
    let ctorTree = TreeReconstructor().visit(tree)
    assert(ctorTree.is(SourceFileSyntax.self))
    let ctorResult = ClassifiedSyntaxTreePrinter.print(ctorTree)
    if ctorResult != result {
      throw TestingError.classificationVerificationFailed(result, ctorResult)
    }
  }

  if let outURL = args["-out"].map(URL.init(fileURLWithPath:)) {
    try result.write(to: outURL, atomically: false, encoding: .utf8)
  } else {
    print(result)
  }
}

/// Returns an array of UTF8 bytes offsets for each line.
func getLineTable(_ text: String) -> [Int] {
  return text.withCString { (p: UnsafePointer<Int8>) -> [Int] in
    var lineOffsets = [Int]()
    lineOffsets.append(0)
    var idx = 0
    while p[idx] != 0 {
      if p[idx] == Int8(UnicodeScalar("\n").value) {
        lineOffsets.append(idx+1)
      }
      idx += 1
    }
    return lineOffsets
  }
}

func getByteRange(_ region: SourceRegion, lineTable: [Int],
                  argName: String) throws -> ByteSourceRange {
  if region.startLine-1 >= lineTable.count {
      throw CommandLineArguments.InvalidArgumentValueError(
        argName: argName,
        value: "startLine: \(region.startLine)"
      )
  }
  if region.endLine-1 >= lineTable.count {
      throw CommandLineArguments.InvalidArgumentValueError(
        argName: argName,
        value: "endLine: \(region.endLine)"
      )
  }
  let startOffset = lineTable[region.startLine-1] + region.startColumn-1
  let endOffset = lineTable[region.endLine-1] + region.endColumn-1
  let length = endOffset-startOffset
  return ByteSourceRange(offset: startOffset, length: length)
}

func parseIncrementalEditArguments(
  args: CommandLineArguments
) throws -> [SourceEdit] {
  var edits = [SourceEdit]()
  let argEdits = try args.getIncrementalEdits()
  let preEditURL =
    URL(fileURLWithPath: try args.getRequired("-old-source-file"))
  let text = try String(contentsOf: preEditURL)
  let lineTable = getLineTable(text)
  for argEdit in argEdits {
    let range = try getByteRange(argEdit.region, lineTable: lineTable,
                                 argName: "-incremental-edit")
    let replacementLength = argEdit.replacement.utf8.count
    edits.append(SourceEdit(range: range, replacementLength: replacementLength))
  }
  return edits
}

func performParseIncremental(args: CommandLineArguments) throws {
  let preEditURL =
    URL(fileURLWithPath: try args.getRequired("-old-source-file"))
  let postEditURL = URL(fileURLWithPath: try args.getRequired("-source-file"))
  let expectedReparseRegions = try args.getReparseRegions()
  let versionInfo = getSwiftLanguageVersionInfo(args: args)

  let preEditTree = try SyntaxParser.parse(preEditURL, languageVersion: versionInfo.languageVersion, enableBareSlashRegexLiteral: versionInfo.enableBareSlashRegexLiteral)
  let edits = try parseIncrementalEditArguments(args: args)
  let regionCollector = IncrementalParseReusedNodeCollector()
  let editTransition = IncrementalParseTransition(
    previousTree: preEditTree,
    edits: try ConcurrentEdits(concurrent: edits),
    reusedNodeDelegate: regionCollector
  )

  let postEditText = try String(contentsOf: postEditURL)
  let postEditTree =
    try SyntaxParser.parse(source: postEditText, parseTransition: editTransition)

  let postTreeDump = postEditTree.description

  if let outURL = args["-out"].map(URL.init(fileURLWithPath:)) {
    try postTreeDump.write(to: outURL, atomically: false, encoding: .utf8)
  } else {
    print(postTreeDump)
  }

  let regions = regionCollector.rangeAndNodes.map { $0.0 }
  if let reuseLogURL =
    args["-incremental-reuse-log"].map(URL.init(fileURLWithPath:)) {
    var log = ""
    for region in regions {
      log += "Reused \(region.offset) to \(region.endOffset)\n"
    }
    try log.write(to: reuseLogURL, atomically: false, encoding: .utf8)
  }

  if !expectedReparseRegions.isEmpty {
    try verifyReusedRegions(expectedReparseRegions: expectedReparseRegions,
      reusedRegions: regions,
      source: postEditText)
  }
}

enum TestingError: Error, CustomStringConvertible {
  case reparsedRegionsVerificationFailed(ByteSourceRange)
  case classificationVerificationFailed(String, String)
  case readingSourceFileFailed(URL)
  case roundTripFailed

  public var description: String {
    switch self {
    case .reparsedRegionsVerificationFailed(let range):
      return "unexpectedly reparsed following region: (offset: \(range.offset),"
        + " length:\(range.length))"
    case .classificationVerificationFailed(let parsed, let constructed):
      return """
      parsed vs constructed tree resulted in different classification output
      --- PARSED:
      \(parsed)
      --- CONSTRUCTED:
      \(constructed)
      """
    case .readingSourceFileFailed(let url):
      return "Reading the source file at \(url) failed"
    case .roundTripFailed:
      return "Round-tripping the source file failed"
    }
  }
}

func verifyReusedRegions(expectedReparseRegions: [SourceRegion],
      reusedRegions: [ByteSourceRange],
      source text: String) throws {
  let fileLength = text.utf8.count

  // Compute the repared regions by inverting the reused regions
  let reusedRanges = ByteSourceRangeSet(ranges: reusedRegions)
  let reparsedRegions = reusedRanges.inverted(totalLength: fileLength)

  // Same for expected reuse regions
  let lineTable = getLineTable(text)
  var expectedReparseRanges = ByteSourceRangeSet()
  for region in expectedReparseRegions {
    let range =
      try getByteRange(region, lineTable: lineTable, argName: "-reparse-region")
    expectedReparseRanges.addRange(range)
  }
  let expectedReuseRegions =
    expectedReparseRanges.inverted(totalLength: fileLength)

  // Intersect the reparsed regions with the expected reuse regions to get
  // regions that should not have been reparsed
  let unexpectedReparseRegions =
      reparsedRegions.intersected(expectedReuseRegions)

  for reparseRange in unexpectedReparseRegions.ranges {
    // To improve the ergonomics when writing tests we do not want to complain
    // about reparsed whitespaces.
    let utf8 = text.utf8
    let begin = utf8.index(utf8.startIndex, offsetBy: reparseRange.offset)
    let end = utf8.index(begin, offsetBy: reparseRange.length)
    let rangeStr = String(utf8[begin..<end])!
    let whitespaceOnlyRegex = try NSRegularExpression(pattern: "^[ \t\r\n]*$")
    let match = whitespaceOnlyRegex.firstMatch(in: rangeStr,
                          range: NSRange(rangeStr.startIndex..., in: rangeStr))
    if match != nil {
      continue
    }
    throw TestingError.reparsedRegionsVerificationFailed(reparseRange)
  }
}

func performRoundtrip(args: CommandLineArguments) throws {
  let sourceURL = URL(fileURLWithPath: try args.getRequired("-source-file"))
  let versionInfo = getSwiftLanguageVersionInfo(args: args)
  let tree = try SyntaxParser.parse(sourceURL, languageVersion: versionInfo.languageVersion, enableBareSlashRegexLiteral: versionInfo.enableBareSlashRegexLiteral)
  let treeText = tree.description

  if let outURL = args["-out"].map(URL.init(fileURLWithPath:)) {
    try treeText.write(to: outURL, atomically: false, encoding: .utf8)
  } else {
    print(treeText)
  }
}

func performVerifyRoundtrip(args: CommandLineArguments) throws {
  let sourceURL = URL(fileURLWithPath: try args.getRequired("-source-file"))
  guard let source = try String(data: Data(contentsOf: sourceURL), encoding: .utf8) else {
    throw TestingError.readingSourceFileFailed(sourceURL)
  }
  let versionInfo = getSwiftLanguageVersionInfo(args: args)
  
  let tree = try SyntaxParser.parse(source: source, languageVersion: versionInfo.languageVersion, enableBareSlashRegexLiteral: versionInfo.enableBareSlashRegexLiteral)
  if tree.description != source {
    throw TestingError.roundTripFailed
  }
}

class NodePrinter: SyntaxAnyVisitor {
  init() {
    super.init(viewMode: .sourceAccurate)
  }

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    assert(!node.isUnknown)
    print("<\(type(of: node.asProtocol(SyntaxProtocol.self)))>", terminator: "")
    return .visitChildren
  }
  override func visitAnyPost(_ node: Syntax) {
    print("</\(type(of: node.asProtocol(SyntaxProtocol.self)))>", terminator: "")
  }
  override func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    print("<\(type(of: token))>", terminator: "")
    print(token, terminator:"")
    return .visitChildren
  }
}

func printSyntaxTree(args: CommandLineArguments) throws {
  let treeURL = URL(fileURLWithPath: try args.getRequired("-source-file"))
  let versionInfo = getSwiftLanguageVersionInfo(args: args)
  let tree = try SyntaxParser.parse(treeURL, languageVersion: versionInfo.languageVersion, enableBareSlashRegexLiteral: versionInfo.enableBareSlashRegexLiteral)
  let printer = NodePrinter()
  printer.walk(tree)
}

func printParserDiags(args: CommandLineArguments) throws {
  let treeURL = URL(fileURLWithPath: try args.getRequired("-source-file"))
  let versionInfo = getSwiftLanguageVersionInfo(args: args)

  var diagCounter : (error: Int, warning: Int, note: Int) = (0, 0, 0)

  func handleDiagnostic(diagnostic: Diagnostic) {
    switch diagnostic.message.severity {
    case .error:
      diagCounter.error += 1
      diagCounter.note += diagnostic.notes.count
    case .warning:
      diagCounter.warning += 1
      diagCounter.note += diagnostic.notes.count
    case .note:
      diagCounter.note += 1
    }
    print(diagnostic.debugDescription)
  }

  _ = try SyntaxParser.parse(treeURL, languageVersion: versionInfo.languageVersion, enableBareSlashRegexLiteral: versionInfo.enableBareSlashRegexLiteral, diagnosticHandler: handleDiagnostic)

  print("\(diagCounter.error) error(s) \(diagCounter.warning) warnings(s) \(diagCounter.note) note(s)")
}

/// Write the given string to stderr **without** appending a newline character.
func writeToStderr(_ msg: String) {
  FileHandle.standardError.write(msg.data(using: .utf8)!)
}

func diagnose(args: CommandLineArguments) throws {
  func printDiagnostic(diagnostic: Diagnostic) {
    if let loc = diagnostic.location {
      writeToStderr("\(loc.file!):\(loc.line!):\(loc.column!): ")
    } else {
      writeToStderr("<unknown>:0:0: ")
    }
    switch diagnostic.message.severity {
    case .note: writeToStderr("note: ")
    case .warning: writeToStderr("warning: ")
    case .error: writeToStderr("error: ")
    }
    writeToStderr(diagnostic.message.text)
    writeToStderr("\n")

    for note in diagnostic.notes {
      printDiagnostic(diagnostic: note.asDiagnostic())
    }
  }

  let treeURL = URL(fileURLWithPath: try args.getRequired("-source-file"))
  let versionInfo = getSwiftLanguageVersionInfo(args: args)

  let tree = try SyntaxParser.parse(treeURL, languageVersion: versionInfo.languageVersion, enableBareSlashRegexLiteral: versionInfo.enableBareSlashRegexLiteral, diagnosticHandler: printDiagnostic)

  class DiagnoseUnknown: SyntaxAnyVisitor {
    let diagnosticHandler: ((Diagnostic) -> Void)
    let converter: SourceLocationConverter
    init(diagnosticHandler: @escaping ((Diagnostic) -> Void), _ converter: SourceLocationConverter) {
      self.diagnosticHandler = diagnosticHandler
      self.converter = converter
      super.init(viewMode: .all)
    }
    override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
      if node.isUnknown {
        diagnosticHandler(Diagnostic(
          message: Diagnostic.Message(.warning, "unknown syntax exists"),
          location: node.startLocation(converter: converter, afterLeadingTrivia: true),
          actions: nil
        ))
      }
      return .visitChildren
    }
  }
  let visitor = DiagnoseUnknown(
    diagnosticHandler: printDiagnostic,
    SourceLocationConverter(file: treeURL.path, tree: tree)
  )
  visitor.walk(tree)
}

do {
  let args = try CommandLineArguments.parse(CommandLine.arguments.dropFirst())

  if args.has("-classify-syntax") {
    try performClassifySyntax(args: args)
  } else if args.has("-parse-incremental") {
    try performParseIncremental(args: args)
  } else if args.has("-roundtrip") {
    try performRoundtrip(args: args)
  } else if args.has("-verify-roundtrip") {
    try performVerifyRoundtrip(args: args)
  } else if args.has("-print-tree") {
    try printSyntaxTree(args: args)
  } else if args.has("-dump-diags") {
    try printParserDiags(args: args)
  } else if args.has("-diagnose") {
    try diagnose(args: args)
  } else if args.has("-help") {
    printHelp()
  } else {
    printerr("""
      No action specified.
      See -help for information about available actions
      """)
    exit(1)
  }
  exit(0)
} catch let error as TestingError {
  printerr("\(error)")
  exit(1)
} catch {
  printerr("\(error)")
  printerr("Run lit-test-helper -help for more help.")
  exit(1)
}
