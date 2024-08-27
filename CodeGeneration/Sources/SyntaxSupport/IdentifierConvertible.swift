//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// Instances of a conforming type should provide an identifier to be used in code generation.
public protocol IdentifierConvertible {
  /// The name of the instance as an identifer.
  var identifier: TokenSyntax {
    get
  }
}

public extension IdentifierConvertible {
  /// ``identifier`` escaped as a base name suitable for call sites.
  var baseCallName: TokenSyntax {
    identifier.declNameOrVarCallName
  }

  /// ``identifier`` escaped as an enum case name suitable for call sites.
  var enumCaseCallName: TokenSyntax {
    memberCallName
  }

  /// ``identifier`` escaped as a member name suitable for call sites.
  var memberCallName: TokenSyntax {
    identifier.nonVarCallNameOrLabelDeclName
  }

  /// ``identifier`` escaped as an enum case name suitable for declaration sites.
  var enumCaseDeclName: TokenSyntax {
    identifier.declNameOrVarCallName
  }

  /// ``identifier`` escaped as a function name suitable for declaration sites.
  var funcDeclName: TokenSyntax {
    identifier.declNameOrVarCallName
  }

  /// ``identifier`` escaped as an argument label name suitable for declaration sites.
  var labelDeclName: TokenSyntax {
    identifier.nonVarCallNameOrLabelDeclName
  }

  /// ``identifier`` escaped as a variable name suitable for declaration sites.
  var varDeclName: TokenSyntax {
    identifier.declNameOrVarCallName
  }
}
