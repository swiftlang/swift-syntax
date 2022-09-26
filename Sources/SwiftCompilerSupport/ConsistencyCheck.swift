//===-------------------------- ConsistencyCheck.swift --------------------===//
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

import SwiftOperators
@_spi(Testing) @_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax

extension Syntax {
  /// Whether this syntax node is or is enclosed within a #if.
  fileprivate var isInIfConfig: Bool {
    if self.is(IfConfigDeclSyntax.self) {
      return true
    }

    return parent?.isInIfConfig ?? false
  }
}

/// Entry point for the Swift compiler to use for consistency checking.
///
/// - Parameters:
///   - bufferPtr: Pointer to the input buffer.
///   - bufferLength: Length of the input buffer.
///   - filename: The name of the source file, which is used only for diagnostics
///   - flags: Flags that indicate what checks should be performed.
///       0x01: Perform round-trip checking.
///       0x02: Check for parser diagnostics.
/// - Returns: 0 if all requested consistency checks passed, nonzero otherwise.
@_cdecl("swift_parser_consistencyCheck")
@_spi(SwiftCompiler)
public func _parserConsistencyCheck(
  bufferPtr: UnsafePointer<UInt8>, bufferLength: Int,
  filename: UnsafePointer<UInt8>, flags: CUnsignedInt
) -> CInt {
  let buffer = UnsafeBufferPointer<UInt8>(
    start: bufferPtr, count: bufferLength)
  var parser = Parser(buffer)
  return withExtendedLifetime(parser) { () -> CInt in
    // Parse the source file
    let rawSourceFile = parser.parseSourceFile()

    // Round-trip test.
    if flags & 0x01 != 0 {
      if rawSourceFile.raw.syntaxTextBytes != [UInt8](buffer) {
        print(
          "\(String(cString: filename)): error: file failed to round-trip")
        return 1
      }
    }

    // Diagnostics test.
    if flags & 0x02 != 0 {
      var anyDiags = false

      let sourceFile = Syntax(raw: rawSourceFile.raw).as(SourceFileSyntax.self)!

      let diags = ParseDiagnosticsGenerator.diagnostics(
        for: sourceFile)
      for diag in diags {
        // Skip over diagnostics within #if, because we don't know whether
        // we are in an active region or not.
        // FIXME: This heuristic could be improved.
        if diag.node.isInIfConfig {
          continue
        }

        print("\(String(cString: filename)): error: \(diag.debugDescription)")
        anyDiags = true
      }

      if anyDiags {
        return 1
      }
    }

    return 0
  }
}
