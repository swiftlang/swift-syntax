//===----- InternalSwiftSyntaxParser.swift - Parser Library Interface -----===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2021 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_implementationOnly import _CSwiftSyntax

/// Wrapper for lib_InternalSwiftSyntaxParser.
internal final class InternalSwiftSyntaxParser {
  /// The handle to the dylib.
  private let dylib: DLHandle

  /// libSwiftScan API functions.
  let api: swiftparse_functions_t;

  private init() throws {
    #if os(Windows)
    self.dylib = try dlopen("@rpath/lib_InternalSwiftSyntaxParser.dll", mode: [])
    #elseif os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    self.dylib = try dlopen("@rpath/lib_InternalSwiftSyntaxParser.dylib", mode: [.lazy, .local, .first])
    #else
    self.dylib = try dlopen("@rpath/lib_InternalSwiftSyntaxParser.so", mode: [.lazy, .local, .first])
    #endif
    self.api = try swiftparse_functions_t(self.dylib)
  }

  static let shared = Result(catching: { try InternalSwiftSyntaxParser() })

  deinit {
    // FIXME: is it safe to dlclose() the library? If so, do that here.
    // For now, let the handle leak.
    dylib.leak()
  }
}

private extension swiftparse_functions_t {
  init(_ swiftparse: DLHandle) throws {
    func loadRequired<T>(_ symbol: String) throws -> T {
      guard let sym: T = dlsym(swiftparse, symbol: symbol) else {
        throw ParserError.parserCompatibilityCheckFailed
      }
      return sym
    }
    self.init(swiftparse_parser_create: try loadRequired("swiftparse_parser_create"),
              swiftparse_parser_dispose: try loadRequired("swiftparse_parser_dispose"),
              swiftparse_parser_set_node_handler: try loadRequired("swiftparse_parser_set_node_handler"),
              swiftparse_parser_set_node_lookup: try loadRequired("swiftparse_parser_set_node_lookup"),
              swiftparse_parse_string: try loadRequired("swiftparse_parse_string"),
              swiftparse_syntax_structure_versioning_identifier: try loadRequired("swiftparse_syntax_structure_versioning_identifier"),
              swiftparse_parser_set_diagnostic_handler: try loadRequired("swiftparse_parser_set_diagnostic_handler"),
              swiftparse_diagnostic_get_message: try loadRequired("swiftparse_diagnostic_get_message"),
              swiftparse_diagnostic_get_source_loc: try loadRequired("swiftparse_diagnostic_get_source_loc"),
              swiftparse_diagnostic_get_fixit_count: try loadRequired("swiftparse_diagnostic_get_fixit_count"),
              swiftparse_diagnostic_get_fixit: try loadRequired("swiftparse_diagnostic_get_fixit"),
              swiftparse_diagnostic_get_range_count: try loadRequired("swiftparse_diagnostic_get_range_count"),
              swiftparse_diagnostic_get_range: try loadRequired("swiftparse_diagnostic_get_range"),
              swiftparse_diagnostic_get_severity: try loadRequired("swiftparse_diagnostic_get_severity"))
  }
}
