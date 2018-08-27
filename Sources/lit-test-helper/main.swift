import SwiftSyntax
import Foundation
import Utility
import Basic

/// Print the given message to stderr
func printerr(_ message: String, terminator: String = "\n") {
  FileHandle.standardError.write((message + terminator).data(using: .utf8)!)
}

extension SerializationFormat: ArgumentKind {
  public init(argument: String) throws {
    switch argument {
    case "json":
      self = .json
    case "byteTree":
      self = .byteTree
    default:
      throw ArgumentConversionError.unknown(value: argument)
    }
  }

  public static var completion: ShellCompletion {
    return .values([
      ("json", "Serialize the syntax tree as JSON"),
      ("byteTree", "Serialize the syntax tree as ByteTree")
      ])
  }
}

extension Foundation.URL: ArgumentKind {
  public init(argument: String) throws {
    self.init(fileURLWithPath: argument)
  }

  public static var completion: ShellCompletion {
    return .filename
  }
}

extension ArgumentParser.Result {
  func getOrThrow<T>(_ argument: OptionArgument<T>, name: String) throws -> T {
    if let value = self.get(argument) {
      return value
    } else {
      throw ArgumentParserError.expectedValue(option: name)
    }
  }
}

protocol Subcommand {
  var command: String { get }
  var overview: String { get }

  init(parser: ArgumentParser)
  func run(with: ArgumentParser.Result) throws
}

struct DeserializeCommand: Subcommand {
  var command = "deserialize"
  var overview = "Deserialize a full pre-edit syntax tree (-pre-edit-tree) " +
    "and write the source representation of the syntax tree to an out file " +
    "(-out)."

  let preEditTree: OptionArgument<Foundation.URL>
  let outFile: OptionArgument<Foundation.URL>
  let format: OptionArgument<SerializationFormat>

  init(parser: ArgumentParser) {
    let subparser = parser.add(subparser: command, overview: overview)

    preEditTree = subparser.add(option: "-pre-edit-tree", kind: URL.self,
                                usage: "The path to the serialized syntax " +
                                       "tree that shall be deserialized.")

    outFile = subparser.add(option: "-out", kind: URL.self, usage:
      "The file to which the source representation of the deserialized " +
      "syntax tree shall be written.")

    format = subparser.add(option: "-serialization-format",
                           kind: SerializationFormat.self,
                           usage: "The format that shall be used to " +
                                  "serialize/deserialize the syntax tree. " +
                                  "Defaults to json.")
  }

  func run(with args: ArgumentParser.Result) throws {
    let fileURL = try args.getOrThrow(preEditTree, name: "-pre-edit-tree")
    let outURL = try args.getOrThrow(outFile, name: "-out")
    let format = args.get(self.format) ?? .json

    let fileData = try Data(contentsOf: fileURL)

    let deserializer = SyntaxTreeDeserializer()
    let tree = try deserializer.deserialize(fileData,
                                            serializationFormat: format)

    let sourceRepresenation = tree.description
    try sourceRepresenation.write(to: outURL, atomically: false,
                                  encoding: .utf8)
  }
}

struct DeserializeIncrementalCommand: Subcommand {
  var command = "deserialize-incremental"
  var overview = "Deserialize a full pre-edit syntax tree (-pre-edit-tree), " +
    "parse an incrementally transferred post-edit syntax tree (-incr-tree) " +
    "and write the source representation of the post-edit syntax tree to an " +
    "out file (-out)."

  let preEditTree: OptionArgument<Foundation.URL>
  let incrTree: OptionArgument<Foundation.URL>
  let outFile: OptionArgument<Foundation.URL>
  let format: OptionArgument<SerializationFormat>

  init(parser: ArgumentParser) {
    let subparser = parser.add(subparser: command, overview: overview)

    preEditTree = subparser.add(option: "-pre-edit-tree", kind: URL.self,
                                usage: "The path to a serialized pre-edit" +
                                       "syntax tree.")

    incrTree = subparser.add(option: "-incr-tree", kind: URL.self,
                             usage: "The path to a serialized incrementally " +
                                    "transferred post-edit syntax tree")

    outFile = subparser.add(option: "-out", kind: URL.self, usage:
      "The file to which the source representation of the post-edit syntax " +
      "tree shall be written.")

    format = subparser.add(option: "-serialization-format",
                           kind: SerializationFormat.self,
                           usage: "The format that shall be used to " +
                                  "serialize/deserialize the syntax tree. " +
                                  "Defaults to json.")
  }

  func run(with args: ArgumentParser.Result) throws {
    let preEditTreeURL = try args.getOrThrow(preEditTree,
                                             name: "-pre-edit-tree")
    let incrTreeURL = try args.getOrThrow(incrTree, name: "-incr-tree")
    let outURL = try args.getOrThrow(outFile, name: "-out")
    let format = args.get(self.format) ?? .json

    let preEditTreeData = try Data(contentsOf: preEditTreeURL)
    let incrTreeData = try Data(contentsOf: incrTreeURL)

    let deserializer = SyntaxTreeDeserializer()
    _ = try deserializer.deserialize(preEditTreeData,
                                     serializationFormat: format)
    let tree = try deserializer.deserialize(incrTreeData,
                                            serializationFormat: format)
    let sourceRepresenation = tree.description
    try sourceRepresenation.write(to: outURL, atomically: false,
                                  encoding: .utf8)
  }
}

struct ClassifySyntaxCommand: Subcommand {
  var command = "classify-syntax"
  var overview = "Parse the given source file (-source-file) and output it " +
    "with tokens classified for syntax colouring."

  let sourceFile: OptionArgument<Foundation.URL>
  let outFile: OptionArgument<Foundation.URL>

  init(parser: ArgumentParser) {
    let subparser = parser.add(subparser: command, overview: overview)

    sourceFile = subparser.add(option: "-source-file", kind: URL.self, usage:
      "The path to a Swift source file to classify")

    outFile = subparser.add(option: "-out", kind: URL.self, usage:
      "The file to which the classified source file shall be written. If " +
      "omitted the classified source file will be written to stdout.")
  }

  func run(with args: ArgumentParser.Result) throws {
    let treeURL = try args.getOrThrow(sourceFile, name: "-source-file")

    let tree = try SyntaxTreeParser.parse(treeURL)
    let classifications = SyntaxClassifier.classifyTokensInTree(tree)
    let printer = ClassifiedSyntaxTreePrinter(classifications: classifications)
    let result = printer.print(tree: tree)

    if let outURL = args.get(outFile) {
      try result.write(to: outURL, atomically: false, encoding: .utf8)
    } else {
      print(result)
    }
  }
}

do {
  let parser = ArgumentParser(usage: "<command> <options>",overview:
    "Utility to test SwiftSyntax syntax tree deserialization.")

  let subcommands: [Subcommand] = [
    DeserializeCommand(parser: parser),
    DeserializeIncrementalCommand(parser: parser),
    ClassifySyntaxCommand(parser: parser)
  ]

  let result = try parser.parse(Array(CommandLine.arguments.dropFirst()))

  guard let subparser = result.subparser(parser),
    let command = subcommands.first(where: { $0.command == subparser }) else {
      parser.printUsage(on: stdoutStream)
      exit(1)
  }
  try command.run(with: result)
  exit(0)
} catch {
  printerr("\(error)")
  printerr("Run lit-test-helper --help for more help.")
  exit(1)
}
