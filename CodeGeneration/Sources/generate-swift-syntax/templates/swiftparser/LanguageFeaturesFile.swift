//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let languageFeaturesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax(
    """
    extension Parser {
      /// The type is public so it can appear in the (non-SPI) parser API, but
      /// the individual features are `@_spi(ExperimentalLanguageFeatures)` since
      /// they are unstable. Clients that don't enable experimental features only
      /// ever use the empty set.
      public struct LanguageFeatures: OptionSet, Hashable, Sendable {
        public let rawValue: UInt
        public init(rawValue: UInt) {
          self.rawValue = rawValue
        }
      }
    }
    """
  )

  try! ExtensionDeclSyntax("extension Parser.LanguageFeatures") {
    for (i, feature) in ExperimentalFeature.allCases.enumerated() {
      DeclSyntax(
        """
        /// Whether to enable the parsing of \(raw: feature.documentationDescription).
        @_spi(ExperimentalLanguageFeatures)
        public static let \(feature.token) = Self(rawValue: 1 << \(raw: i))
        """
      )
    }

    for (i, feature) in CompilerOnlyLanguageFeature.allCases.enumerated() {
      DeclSyntax(
        """
        /// Whether to disable the parsing of \(raw: feature.documentationDescription).
        @_spi(Compiler)
        public static let \(feature.token) = Self(rawValue: 1 << \(raw: ExperimentalFeature.allCases.count + i))
        """
      )
    }

    try! InitializerDeclSyntax(
      """
      /// Creates a new value representing the feature with the given name, or
      /// returns nil if the name is not recognized.
      @_spi(ExperimentalLanguageFeatures)
      public init?(name: String)
      """
    ) {
      try! SwitchExprSyntax("switch name") {
        SwitchCaseListSyntax {
          for feature in ExperimentalFeature.allCases {
            SwitchCaseSyntax(#"case "\#(raw: feature.featureName)":"#) {
              ExprSyntax("self = .\(feature.token)")
            }
          }
          SwitchCaseSyntax("default:") {
            StmtSyntax("return nil")
          }
        }
      }
    }
  }
}
