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

import SwiftIfConfig
@_spi(ExperimentalLanguageFeatures) import SwiftSyntax

extension AttributeSyntax {
  var warningGroupControl: (DiagnosticGroupIdentifier, WarningGroupControl)? {
    // `@diagnose` attributes (also accepts the old `@warn` spelling)
    guard let attrName = attributeName.as(IdentifierTypeSyntax.self)?.name.text,
      attrName == "diagnose" || attrName == "warn"
    else {
      return nil
    }

    // First argument is the unquoted diagnostic group identifier
    guard
      let diagnosticGroupID = arguments?
        .as(LabeledExprListSyntax.self)?.first?.expression
        .as(DeclReferenceExprSyntax.self)?.baseName.text
    else {
      return nil
    }

    // Second argument is the `as: ` behavior control specifier
    guard
      let asParamExprSyntax = arguments?.as(LabeledExprListSyntax.self)?
        .dropFirst().first
    else {
      return nil
    }
    guard
      asParamExprSyntax.label?.text == "as",
      let controlText = asParamExprSyntax
        .expression.as(DeclReferenceExprSyntax.self)?
        .baseName.text,
      let control = WarningGroupControl(rawValue: controlText)
    else {
      return nil
    }

    return (DiagnosticGroupIdentifier(diagnosticGroupID), control)
  }
}

extension WithAttributesSyntax {
  /// Compute a dictionary of all `@diagnose` diagnostic group behavior controls
  /// specified on this warning control declaration scope.
  func allWarningGroupControls(
    in configuredRegions: ConfiguredRegions
  ) -> [(DiagnosticGroupIdentifier, WarningGroupControl)] {
    attributes.warningGroupControls(in: configuredRegions)
  }
}

extension AttributeListSyntax {
  fileprivate func warningGroupControls(
    in configuredRegions: ConfiguredRegions
  ) -> [(DiagnosticGroupIdentifier, WarningGroupControl)] {
    reduce(into: []) { result, element in
      switch element {
      case .attribute(let attr):
        if let control = attr.warningGroupControl {
          result.append(control)
        }
      case .ifConfigDecl(let ifConfig):
        guard let activeClause = configuredRegions.activeClause(for: ifConfig),
          case .attributes(let nested) = activeClause.elements
        else {
          return
        }
        result.append(contentsOf: nested.warningGroupControls(in: configuredRegions))
      }
    }
  }
}

extension UsingDeclSyntax {
  var warningControl: (DiagnosticGroupIdentifier, WarningGroupControl)? {
    guard case .attribute(let attributeSyntax) = self.specifier,
      let warningGroupControl = attributeSyntax.warningGroupControl
    else {
      return nil
    }
    return warningGroupControl
  }
}
