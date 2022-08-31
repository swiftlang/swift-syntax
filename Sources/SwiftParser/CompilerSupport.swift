//===-------------------------- CompilerSupport.swift ---------------------===//
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

/// Entry point for the Swift compiler to use for consistency checking.
///
/// - Parameters:
///   - bufferPtr: Pointer to the input buffer.
///   - bufferLength: Length of the input buffer.
///   - filename: The name of the source file, which is used only for diagnostics
///   - flags: Flags that indicate what checks should be performed.
///       0x01: Perform round-trip checking.
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
    let sourceFile = parser.parseSourceFile()

    // Round-trip test.
    if flags & 0x01 != 0 {
      var bufferArray = [UInt8](buffer)
      bufferArray.append(0)
      if "\(sourceFile)" != String(cString: bufferArray) {
        print(
          "\(String(cString: filename)): error: file failed to round-trip")
        return 1
      }
    }

    return 0
  }
}
