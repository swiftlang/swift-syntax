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

public extension Child {
  /// The raw representation of ``Child``.
  struct Raw: SyntaxNodeConvertible, NodeChoiceConvertible, ParameterConvertible {
    var child: Child

    public var isOptional: Bool {
      self.child.isOptional
    }

    public var isNode: Bool {
      self.child.isNode
    }

    public var syntaxType: TypeSyntax {
      switch self.child.kind {
      case .node(let kind), .collection(let kind, _, _, _):
        return kind.raw.syntaxType
      case .nodeChoices:
        return self.child.syntaxChoicesType
      case .token:
        return "RawTokenSyntax"
      }
    }

    public var syntaxNodeKind: SyntaxNodeKind.Raw {
      self.child.syntaxNodeKind.raw
    }

    public var documentation: SwiftSyntax.Trivia {
      self.child.documentation
    }

    public var experimentalFeature: ExperimentalFeature? {
      self.child.experimentalFeature
    }

    public var apiAttributes: AttributeListSyntax {
      self.child.apiAttributes
    }

    public var identifier: TokenSyntax {
      self.child.identifier
    }

    public var parameterAnyType: TypeSyntax {
      self.child.parameterType(specifier: "any", protocolType: self.protocolType, syntaxType: self.syntaxType)
    }

    public var parameterSomeType: TypeSyntax {
      if self.child.isBaseNode && !self.child.isOptional {
        // we restrict the use of generic type to non-optional parameter types, otherwise call sites would no longer be
        // able to just pass `nil` to this parameter without specializing `(some Raw<Kind>SyntaxNodeProtocol)?`
        //
        // we've opted out of providing a default value to the parameter (e.g. `RawExprSyntax?.none`) as a workaround,
        // as passing an explicit `nil` would prompt developers to think clearly whether this parameter should be parsed
        return "some \(self.protocolType)"
      } else {
        return self.actualType
      }
    }

    public var defaultValue: ExprSyntax? {
      self.child.defaultValue(syntaxType: self.syntaxType)
    }
  }

  /// The raw representation of this child.
  var raw: Raw {
    Raw(child: self)
  }
}
