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
  /// A check for a specific attribute via `hasAttribute(<name>)`.
  case hasAttribute

  /// A check for a specific named feature via `hasFeature(<name>)`.
  case hasFeature

  /// A check for the Swift language version via `swift(>=version).`
  case swift

  /// A check for the Swift compiler version via `compiler(>=version)`.
  case compiler

  /// A check to determine whether a given module can be imported via `canImport(<import path>)`.
  case canImport

  /// A check for the target Operating System kind (e.g., Linux, iOS) via `os(<name>)`
  case os

  /// A check for the target architecture (e.g., arm64, x86_64) via `arch(<name>)`.
  case arch

  /// A check for the target environment (e.g., simulator) via `targetEnvironment(<environment>)`.
  case targetEnvironment

  /// A check to determine whether the platform supports atomic operations
  /// with the given bitwidth, e.g., `_hasAtomicBitWidth(_64)`.
  case _hasAtomicBitWidth

  /// A historical check against a specific compiler build version via `_compiler_version("<version>")`.
  case _compiler_version

  /// A check for the target endianness (e.g., big or little) via `_endian(big|little)`.
  case _endian

  /// A check for the target bit width of a pointer (e.g., _64)
  case _pointerBitWidth

  /// A check for the target runtime paired with the Swift runtime (e.g., _ObjC)
  /// via `_runtime(<name>)`.
  case _runtime

  /// A check for the target's pointer authentication scheme (e.g., _arm64e)
  /// via `_ptrauth(<name>)`.
  case _ptrauth

  /// An unsupported function used by C preprocessor macros (e.g. `#if defined(FOO)`)
  case defined

  /// Whether uses of this function consitutes a check that guards new syntax.
  /// When such a check fails, the compiler should not diagnose syntax errors
  /// within the covered block.
  var syntaxErrorsAllowed: Bool {
    switch self {
    case .swift, .compiler, ._compiler_version:
      return true

    case .hasAttribute, .hasFeature, .canImport, .os, .arch, .targetEnvironment,
      ._hasAtomicBitWidth, ._endian, ._pointerBitWidth, ._runtime, ._ptrauth, .defined:
      return false
    }
  }
}
