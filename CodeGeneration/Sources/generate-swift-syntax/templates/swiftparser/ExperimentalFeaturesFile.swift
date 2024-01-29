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

let experimentalFeaturesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax(
    """
    extension Parser {
      @_spi(ExperimentalLanguageFeatures)
      public struct ExperimentalFeatures: OptionSet, Sendable {
        public let rawValue: UInt
        public init(rawValue: UInt) {
          self.rawValue = rawValue
        }
      }
    }
    """
  )

  try! ExtensionDeclSyntax("extension Parser.ExperimentalFeatures") {
    for (i, feature) in ExperimentalFeature.allCases.enumerated() {
      DeclSyntax(
        """
        /// Whether to enable the parsing of \(raw: feature.featureName).
        public static let \(feature.token) = Self(rawValue: 1 << \(raw: i))
        """
      )
    }
  }
}
