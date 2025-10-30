//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

extension WithAttributesSyntax {
  /// Compute a dictionary of all `@warn` diagnostic group behavior controls
  /// specified on this warning control declaration scope.
  var allWarningGroupControls: [DiagnosticGroupIdentifier: WarningGroupControl] {
    attributes.reduce(into: [DiagnosticGroupIdentifier: WarningGroupControl]()) { result, attr in
      // `@warn` attributes
      guard case .attribute(let attributeSyntax) = attr,
        attributeSyntax.attributeName.as(IdentifierTypeSyntax.self)?.name.text == "warn"
      else {
        return
      }

      // First argument is the unquoted diagnostic group identifier
      guard
        let diagnosticGroupID = attributeSyntax.arguments?
          .as(LabeledExprListSyntax.self)?.first?.expression
          .as(DeclReferenceExprSyntax.self)?.baseName.text
      else {
        return
      }

      // Second argument is the `as: ` behavior control specifier
      guard
        let asParamExprSyntax = attributeSyntax
          .arguments?.as(LabeledExprListSyntax.self)?
          .dropFirst().first
      else {
        return
      }
      guard
        asParamExprSyntax.label?.text == "as",
        let controlText = asParamExprSyntax
          .expression.as(DeclReferenceExprSyntax.self)?
          .baseName.text,
        let control = WarningGroupControl(rawValue: controlText)
      else {
        return
      }
      result[DiagnosticGroupIdentifier(diagnosticGroupID)] = control
    }
  }
}
