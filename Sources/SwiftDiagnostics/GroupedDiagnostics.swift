//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

public struct GroupedDiagnostics {
  /// A unique identifier for a source file.
  public struct SourceFileID: Equatable, Hashable {
    var id: Int
  }

  /// A representation used for a given source file that contains diagnostics.
  struct SourceFile {
    /// The id for this source file.
    let id: SourceFileID

    /// The syntax tree for the source file.
    let tree: SourceFileSyntax

    /// The source location converter for this source file.
    let sourceLocationConverter: SourceLocationConverter

    /// The human-readable name to use to identify this source file.
    let displayName: String

    /// The position of this source file within another, parent source file.
    ///
    /// The first element identifies the parent source file, while the second
    /// provides an absolute position within that source file.
    let parent: (SourceFileID, AbsolutePosition)?

    /// The set of direct children of this source file, i.e., those whose
    /// parent refers to this source file ID.
    var children: [SourceFileID] = []

    /// The set of diagnostics that are emitted within this source file.
    var diagnostics: [Diagnostic] = []
  }

  /// The set of source files for which diagnostics will be emitted.
  var sourceFiles: [SourceFile] = []

  /// Mapping from the root source file syntax nodes to the corresponding
  /// source file IDs.
  var rootIndexes: [SourceFileSyntax: SourceFileID] = [:]

  public init() {}

  /// Add a new source file to the set of grouped diagnostics.
  ///
  /// - Parameters:
  ///   - tree: The source file syntax tree.
  ///   - displayName: The file name to be used when printing diagnostics.
  ///   - parent: The source file of the "parent" source file, which is
  ///     conceptually where this source file will be inserted, and the
  ///     absolute position within that parent source file.
  ///
  /// - Returns: The unique ID for this source file.
  @discardableResult
  public mutating func addSourceFile(
    tree: SourceFileSyntax,
    sourceLocationConverter: SourceLocationConverter? = nil,
    displayName: String,
    parent: (SourceFileID, AbsolutePosition)? = nil,
    diagnostics: [Diagnostic] = []
  ) -> SourceFileID {
    // Determine the ID this source file will have.
    let id = SourceFileID(id: sourceFiles.count)
    let slc =
      sourceLocationConverter
      ?? SourceLocationConverter(
        fileName: displayName,
        tree: tree
      )
    sourceFiles.append(
      SourceFile(
        id: id,
        tree: tree,
        sourceLocationConverter: slc,
        displayName: displayName,
        parent: parent,
        diagnostics: diagnostics
      )
    )

    rootIndexes[tree] = id

    // If there is a parent source file, register with it.
    if let parentID = parent?.0 {
      sourceFiles[parentID.id].children.append(id)
    }

    return id
  }

  /// Find the ID of the source file containing this syntax node.
  func findSourceFileContaining(_ node: Syntax) -> SourceFileID? {
    guard let rootSourceFile = node.root.as(SourceFileSyntax.self) else {
      return nil
    }

    return rootIndexes[rootSourceFile]
  }

  /// Add a diagnostic to the set of grouped diagnostics.
  ///
  /// - Parameters:
  ///   - diagnostic: the diagnostic to add
  ///   - knownSourceFileID: the source file into which this diagnostic goes,
  ///     if known.
  public mutating func addDiagnostic(
    _ diagnostic: Diagnostic,
    in knownSourceFileID: SourceFileID? = nil
  ) {
    guard let sourceFileID = knownSourceFileID ?? findSourceFileContaining(diagnostic.node) else {
      // Drop the diagnostic on the floor.
      return
    }

    // Add the diagnostic
    sourceFiles[sourceFileID.id].diagnostics.append(diagnostic)
  }
}

extension GroupedDiagnostics {
  /// Determine the set of "root" source files that have no parents. These
  /// are the source files where diagnostics will start being emitted.
  var rootSourceFiles: [SourceFileID] {
    sourceFiles.compactMap { sourceFile in
      if sourceFile.parent == nil {
        return sourceFile.id
      }

      return nil
    }
  }

  // Find the "primary" diagnostic that will be shown at the top of the diagnostic
  // message. This is typically the error, warning, or remark.
  private func findPrimaryDiagnostic(in sourceFile: SourceFile) -> (SourceFile, Diagnostic)? {
    // If there is a non-note diagnostic, it's the primary diagnostic.
    if let primaryDiag = sourceFile.diagnostics.first(where: { $0.diagMessage.severity != .note }) {
      return (sourceFile, primaryDiag)
    }

    // If one of our child source files has a primary diagnostic, return that.
    for childID in sourceFile.children {
      if let foundInChild = findPrimaryDiagnostic(in: sourceFiles[childID.id]) {
        return foundInChild
      }
    }

    // If this is a root note, take the first note.
    if sourceFile.parent == nil,
      let note = sourceFile.diagnostics.first
    {
      return (sourceFile, note)
    }

    // There is no primary diagnostic.
    return nil
  }

  /// Annotate the source for a given source file ID, embedding its child
  /// source files.
  func annotateSource(
    _ sourceFileID: GroupedDiagnostics.SourceFileID,
    formatter: DiagnosticsFormatter,
    indentString: String
  ) -> String {
    let sourceFile = sourceFiles[sourceFileID.id]
    let slc = sourceFile.sourceLocationConverter
    let diagnosticDecorator = formatter.diagnosticDecorator

    let childPadding = String(slc.sourceLines.count + 1).count + 1;

    // Collect the child sources.
    var childSources: [AbsolutePosition: String] = [:]
    for childBufferID in sourceFiles[sourceFileID.id].children {
      let childSource = annotateSource(
        childBufferID,
        formatter: formatter,
        indentString: indentString + String(repeating: " ", count: childPadding) + "│"
      )

      childSources[sourceFiles[childBufferID.id].parent!.1, default: ""].append(childSource)
    }

    // If this is a nested source file, draw a box around it.
    let isRoot = sourceFile.parent == nil
    var prefixString: String
    let suffixString: String

    if isRoot {
      // If there's a primary diagnostic, print it first.
      if let (primaryDiagSourceFile, primaryDiag) = findPrimaryDiagnostic(in: sourceFile) {
        let primaryDiagSLC = primaryDiagSourceFile.sourceLocationConverter
        let location = primaryDiag.location(converter: primaryDiagSLC)

        // Display file/line/column and diagnostic text for the primary diagnostic.
        prefixString =
          "\(location.presumedFile):\(location.presumedLine):\(location.column): \(diagnosticDecorator.decorateDiagnosticMessage(primaryDiag.diagMessage))\n"

        // If the primary diagnostic source file is not the same as the root source file, we're pointing into a generated buffer.
        // Provide a link back to the original source file where this generated buffer occurred, so it's easy to find if
        // (for example) the generated buffer is no longer available.
        if sourceFile.id != primaryDiagSourceFile.id,
          var (rootSourceID, rootPosition) = primaryDiagSourceFile.parent
        {
          // Go all the way up to the root to find the absolute position of the outermost generated buffer within the
          // root source file.
          while let parent = sourceFiles[rootSourceID.id].parent {
            (rootSourceID, rootPosition) = parent
          }

          if rootSourceID == sourceFileID {
            let bufferLoc = slc.location(for: rootPosition)
            let decoratedMessage = diagnosticDecorator.decorateMessage("expanded code originates here", basedOnSeverity: .note)
            prefixString += "╰─ \(bufferLoc.file):\(bufferLoc.line):\(bufferLoc.column): \(decoratedMessage)\n"
          }
        }
      } else {
        let firstLine = sourceFile.diagnostics.first.map { $0.location(converter: slc).line } ?? 0
        prefixString = "\(sourceFile.displayName): \(firstLine):"
      }

      suffixString = ""
    } else {
      let padding = indentString.dropLast(1)

      // Should we make this depend on the width of the snippet itself?
      let targetLineLength = 72
      let extraLengthNeeded = targetLineLength - padding.count - sourceFile.displayName.count - 6
      let boxSuffix: String
      if extraLengthNeeded > 0 {
        boxSuffix = diagnosticDecorator.decorateBufferOutline(String(repeating: "─", count: extraLengthNeeded))
      } else {
        boxSuffix = ""
      }

      prefixString = diagnosticDecorator.decorateBufferOutline(padding + "╭─── ") + sourceFile.displayName + " " + boxSuffix + "\n"
      suffixString =
        diagnosticDecorator.decorateBufferOutline(padding + "╰───" + String(repeating: "─", count: sourceFile.displayName.count + 2)) + boxSuffix + "\n"
    }

    // Render the buffer.
    return prefixString
      + formatter.annotatedSource(
        tree: sourceFile.tree,
        diags: sourceFile.diagnostics,
        indentString: diagnosticDecorator.decorateBufferOutline(indentString),
        suffixTexts: childSources,
        sourceLocationConverter: slc
      ) + suffixString
  }
}

extension DiagnosticsFormatter {
  /// Annotate all of the source files in the given set of grouped diagnostics.
  public func annotateSources(in group: GroupedDiagnostics) -> String {
    return group.rootSourceFiles.map { rootSourceFileID in
      group.annotateSource(rootSourceFileID, formatter: self, indentString: "")
    }.joined(separator: "\n")
  }

  public static func annotateSources(
    in group: GroupedDiagnostics,
    contextSize: Int = 2,
    colorize: Bool = false
  ) -> String {
    let formatter = DiagnosticsFormatter(contextSize: contextSize, colorize: colorize)
    return formatter.annotateSources(in: group)
  }
}
