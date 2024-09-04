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

/// Instances of a conforming type should provide necessary information for generating code of a node choice.
public protocol NodeChoiceConvertible: IdentifierConvertible {
  /// A docc comment describing the syntax node convertible, including the trivia provided when
  /// initializing the syntax node convertible, and the list of possible token choices inferred automatically.
  var documentation: SwiftSyntax.Trivia { get }

  /// The experimental feature the syntax node convertible represents, or `nil` if this isn't
  /// for an experimental feature.
  var experimentalFeature: ExperimentalFeature? { get }

  /// The attributes that should be printed on any API for the syntax node convertible.
  ///
  /// This is typically used to mark APIs as SPI when the keyword is part of
  /// an experimental language feature.
  var apiAttributes: AttributeListSyntax { get }

  /// The kind of the syntax node convertible.
  var syntaxNodeKind: SyntaxNodeKind { get }
}

public extension NodeChoiceConvertible {
  /// The documentation note to print for an experimental feature.
  var experimentalDocNote: SwiftSyntax.Trivia {
    guard let experimentalFeature else {
      return []
    }
    return .docCommentTrivia(from: "- Note: Requires experimental feature `\(experimentalFeature.token)`.")
  }

  /// If `true`, this is for an experimental language feature, and any public
  /// API generated should be SPI.
  var isExperimental: Bool {
    self.experimentalFeature != nil
  }
}
