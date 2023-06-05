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
  case hasAttribute
  case hasFeature
  case _compiler_version
  case swift
  case compiler
  case canImport
  case os
  case arch
  case _endian
  case _pointerBitWidth
  case _runtime
  case targetEnvironment
  case _ptrauth
}
