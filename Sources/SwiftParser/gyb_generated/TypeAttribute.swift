//// Automatically Generated From TypeAttribute.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
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

@_spi(RawSyntax) import SwiftSyntax

extension Parser {
  enum TypeAttribute: SyntaxText, ContextualKeywords {
    case autoclosure = "autoclosure"
    case convention = "convention"
    case noescape = "noescape"
    case escaping = "escaping"
    case differentiable = "differentiable"
    case noDerivative = "noDerivative"
    case async = "async"
    case Sendable = "Sendable"
    case unchecked = "unchecked"
    case _typeSequence = "_typeSequence"
    case _local = "_local"
    case _noMetadata = "_noMetadata"
    case _opaqueReturnTypeOf = "_opaqueReturnTypeOf"
  }
}
