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

/// Enum capturing all of the functions that can be used in an `#if` condition.
enum IfConfigFunctions: String {
  /// A check for a specific attribute.
  case hasAttribute

  /// A check for a specific named feature.
  case hasFeature

  /// A check for the Swift language version.
  case swift

  /// A check for the Swift compiler version.
  case compiler

  /// A check to determine whether a given module can be imported.
  case canImport

  /// A check for the target Operating System kind (e.g., Linux, iOS).
  case os

  /// A check for the target architecture (e.g., arm64, x86_64).
  case arch

  /// A check for the target environment (e.g., simulator).
  case targetEnvironment

  /// A historical check against a specific compiler build version.
  case _compiler_version

  /// A check for the target endianness (e.g., big or little)
  case _endian

  /// A check for the target bit width of a pointer (e.g., _64)
  case _pointerBitWidth

  /// A check for the target runtime paired with the Swift runtime (e.g., _ObjC).
  case _runtime

  /// A check for the target's pointer authentication scheme (e.g., _arm64e).
  case _ptrauth
}
