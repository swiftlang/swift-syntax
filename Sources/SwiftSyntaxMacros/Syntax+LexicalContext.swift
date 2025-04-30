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

#if compiler(>=6)
public import SwiftSyntax
import SwiftSyntaxBuilder
#else
import SwiftSyntax
import SwiftSyntaxBuilder
#endif

extension SyntaxProtocol {
  /// If this syntax node acts as a lexical context from the perspective
  /// of a macro, return a new syntax node based on this node that strips all
  /// information that isn't supposed to be exposed as a lexical context, such
  /// as function bodies or the members of types/extensions.
  ///
  /// Returns `nil` for any syntax node that isn't a lexical context.
  public func asMacroLexicalContext() -> Syntax? {
    switch Syntax(self).asProtocol(SyntaxProtocol.self) {
    // Functions have their body removed.
    case var function as WithOptionalCodeBlockSyntax & SyntaxProtocol:
      function = function.detached
      function.body = nil
      return Syntax(function) as Syntax

    // Closures have their body removed.
    case var closure as ClosureExprSyntax:
      closure = closure.detached
      closure.statements = CodeBlockItemListSyntax()
      return Syntax(closure)

    // Nominal types and extensions have their member list cleared out.
    case var typeOrExtension as HasTrailingMemberDeclBlock & SyntaxProtocol:
      typeOrExtension = typeOrExtension.detached
      typeOrExtension.memberBlock = MemberBlockSyntax(members: MemberBlockItemListSyntax())
      return Syntax(typeOrExtension) as Syntax

    // Subscripts have their accessors removed.
    case var subscriptDecl as SubscriptDeclSyntax:
      subscriptDecl = subscriptDecl.detached
      subscriptDecl.accessorBlock = nil
      return Syntax(subscriptDecl)

    // Enum cases are fine as-is.
    case is EnumCaseElementSyntax:
      return Syntax(self.detached)

    // Pattern bindings have their accessors and initializer removed.
    case var patternBinding as PatternBindingSyntax:
      patternBinding = patternBinding.detached
      patternBinding.accessorBlock = nil
      patternBinding.initializer = nil
      return Syntax(patternBinding)

    // Freestanding macros are fine as-is because if any arguments change
    // the whole macro would have to be re-evaluated.
    case let freestandingMacro as FreestandingMacroExpansionSyntax:
      return Syntax(freestandingMacro.detached) as Syntax

    // `try`, `await`, and `unsafe` are preserved: A freestanding expression
    // macro may need to know whether those keywords are present so it can
    // propagate them to any expressions in its expansion which were passed as
    // arguments to the macro. The sub-expression is replaced with a trivial
    // placeholder, though.
    case var tryExpr as TryExprSyntax:
      tryExpr = tryExpr.detached
      tryExpr.expression = ExprSyntax(TypeExprSyntax(type: IdentifierTypeSyntax(name: .wildcardToken())))
      return Syntax(tryExpr)
    case var awaitExpr as AwaitExprSyntax:
      awaitExpr = awaitExpr.detached
      awaitExpr.expression = ExprSyntax(TypeExprSyntax(type: IdentifierTypeSyntax(name: .wildcardToken())))
      return Syntax(awaitExpr)
    case var unsafeExpr as UnsafeExprSyntax:
      unsafeExpr = unsafeExpr.detached
      unsafeExpr.expression = ExprSyntax(TypeExprSyntax(type: IdentifierTypeSyntax(name: .wildcardToken())))
      return Syntax(unsafeExpr)

    default:
      return nil
    }
  }

  /// Return an array of enclosing lexical contexts for the purpose of macros,
  /// from the innermost enclosing lexical context (first in the array) to the
  /// outermost. If this syntax node itself is a lexical context, it will be
  /// the innermost lexical context.
  ///
  /// - Parameter enclosingSyntax: provides a parent node when the operation
  ///   has reached the outermost syntax node (i.e., it has no parent), allowing
  ///   the caller to provide a new syntax node that can continue the walk
  ///   to collect additional lexical contexts, e.g., from outer macro
  ///   expansions.
  /// - Returns: the array of enclosing lexical contexts.
  public func allMacroLexicalContexts(
    enclosingSyntax: (Syntax) -> Syntax? = { _ in nil }
  ) -> [Syntax] {
    var parentContexts: [Syntax] = []
    var currentNode = Syntax(self)
    while let parentNode = currentNode.parent ?? enclosingSyntax(currentNode) {
      if let parentContext = parentNode.asMacroLexicalContext() {
        parentContexts.append(parentContext)
      }
      // Unfolded sequence expressions require special handling - effect marker
      // nodes like `try`, `await`, and `unsafe` are treated as lexical contexts
      // for all the nodes on their right. Cases where they don't end up
      // covering nodes to their right in the folded tree are invalid and will
      // be diagnosed by the compiler. This matches the compiler's ASTScope
      // handling logic.
      if let sequence = parentNode.as(SequenceExprSyntax.self) {
        var sequenceExprContexts: [Syntax] = []
        for elt in sequence.elements {
          if elt.range.contains(self.position) {
            // `sequenceExprContexts` is built from the top-down, but we
            // build the rest of the contexts bottom-up. Reverse for
            // consistency.
            parentContexts += sequenceExprContexts.reversed()
            break
          }
          var elt = elt
          while true {
            if let tryElt = elt.as(TryExprSyntax.self) {
              sequenceExprContexts.append(tryElt.asMacroLexicalContext()!)
              elt = tryElt.expression
              continue
            }
            if let awaitElt = elt.as(AwaitExprSyntax.self) {
              sequenceExprContexts.append(awaitElt.asMacroLexicalContext()!)
              elt = awaitElt.expression
              continue
            }
            if let unsafeElt = elt.as(UnsafeExprSyntax.self) {
              sequenceExprContexts.append(unsafeElt.asMacroLexicalContext()!)
              elt = unsafeElt.expression
              continue
            }
            break
          }
        }
      }

      currentNode = parentNode
    }

    return parentContexts
  }
}
