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

//==========================================================================//
// IMPORTANT: The macros defined in this file are intended to test the      //
// behavior of MacroSystem. Many of them do not serve as good examples of   //
// how macros should be written. In particular, they often lack error       //
// handling because it is not needed in the few test cases in which these   //
// macros are invoked.                                                      //
//==========================================================================//

import SwiftSyntax
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

extension PatternBindingSyntax {
  /// When the variable is declaring a single binding, produce the name of
  /// that binding.
  fileprivate var singleBindingName: String? {
    if let identifierPattern = pattern.as(IdentifierPatternSyntax.self) {
      return identifierPattern.identifier.trimmedDescription
    }

    return nil
  }
}

private extension TokenSyntax {
  var asIdentifierToken: TokenSyntax? {
    switch tokenKind {
    case .identifier, .dollarIdentifier: return self.trimmed
    default: return nil
    }
  }
}

extension FunctionParameterSyntax {
  var argumentName: TokenSyntax? {
    // If we have two names, the first one is the argument label
    if secondName != nil {
      return firstName.asIdentifierToken
    }

    // If we have only one name, it might be an argument label.
    if let superparent = parent?.parent?.parent, superparent.is(SubscriptDeclSyntax.self) {
      return nil
    }

    return firstName.asIdentifierToken
  }
}

extension SyntaxProtocol {
  /// Form a function name.
  private func formFunctionName(
    _ baseName: String,
    _ parameters: FunctionParameterClauseSyntax?
  ) -> String {
    let argumentNames: [String] =
      parameters?.parameters.map { param in
        let argumentLabelText = param.argumentName?.text ?? "_"
        return argumentLabelText + ":"
      } ?? []

    return "\(baseName)(\(argumentNames.joined(separator: "")))"
  }

  /// Form the #function name for the given node.
  fileprivate func functionName<Context: MacroExpansionContext>(
    in context: Context
  ) -> String? {
    // Declarations with parameters.
    // FIXME: Can we abstract over these?
    if let function = self.as(FunctionDeclSyntax.self) {
      return formFunctionName(
        function.name.trimmedDescription,
        function.signature.parameterClause
      )
    }

    if let initializer = self.as(InitializerDeclSyntax.self) {
      return formFunctionName("init", initializer.signature.parameterClause)
    }

    if let subscriptDecl = self.as(SubscriptDeclSyntax.self) {
      return formFunctionName(
        "subscript",
        subscriptDecl.parameterClause
      )
    }

    if let enumCase = self.as(EnumCaseElementSyntax.self) {
      guard let associatedValue = enumCase.parameterClause else {
        return enumCase.name.text
      }

      let argumentNames = associatedValue.parameters.map { param in
        guard let firstName = param.firstName else {
          return "_:"
        }

        return firstName.text + ":"
      }.joined()

      return "\(enumCase.name.text)(\(argumentNames))"
    }

    // Accessors use their enclosing context, i.e., a subscript or pattern
    // binding.
    if self.is(AccessorDeclSyntax.self) {
      guard let lexicalContext = context.lexicalContext.dropFirst().first else {
        return nil
      }

      return lexicalContext.functionName(in: context)
    }

    // All declarations with identifiers.
    if let identified = self.asProtocol(NamedDeclSyntax.self) {
      return identified.name.trimmedDescription
    }

    // Extensions
    if let extensionDecl = self.as(ExtensionDeclSyntax.self) {
      // FIXME: It would be nice to be able to switch on type syntax...
      let extendedType = extensionDecl.extendedType
      if let simple = extendedType.as(IdentifierTypeSyntax.self) {
        return simple.name.trimmedDescription
      }

      if let member = extendedType.as(MemberTypeSyntax.self) {
        return member.name.trimmedDescription
      }
    }

    // Pattern bindings.
    if let patternBinding = self.as(PatternBindingSyntax.self),
      let singleVarName = patternBinding.singleBindingName
    {
      return singleVarName
    }

    return nil
  }
}

public struct FunctionMacro: ExpressionMacro {
  public static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of node: Node,
    in context: Context
  ) -> ExprSyntax {
    guard let lexicalContext = context.lexicalContext.first,
      let name = lexicalContext.functionName(in: context)
    else {
      return #""<unknown>""#
    }

    return ExprSyntax("\(literal: name)")
  }
}

public struct AllLexicalContextsMacro: DeclarationMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    context.lexicalContext.compactMap { $0.as(DeclSyntax.self)?.trimmed }
  }
}

final class LexicalContextTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testPoundFunction() {
    assertMacroExpansion(
      """
      func f(a: Int, _: Double, c: Int) {
        print(#function)
      }
      """,
      expandedSource: """
        func f(a: Int, _: Double, c: Int) {
          print(  "f(a:_:c:)")
        }
        """,
      macros: ["function": FunctionMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      struct X {
        init(from: String) {
          #function
        }

        subscript(a: Int) -> String {
          #function
        }

        subscript(a a: Int) -> String {
          #function
        }
      }
      """,
      expandedSource: """
        struct X {
          init(from: String) {
            "init(from:)"
          }

          subscript(a: Int) -> String {
            "subscript(_:)"
          }

          subscript(a a: Int) -> String {
            "subscript(a:)"
          }
        }
        """,
      macros: ["function": FunctionMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      var computed: String {
        get {
          #function
        }
      }
      """,
      expandedSource: """
        var computed: String {
          get {
            "computed"
          }
        }
        """,
      macros: ["function": FunctionMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      extension A {
        static var staticProp: String = #function
      }
      """,
      expandedSource: """
        extension A {
          static var staticProp: String =   "staticProp"
        }
        """,
      macros: ["function": FunctionMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testAllLexicalContexts() {
    assertMacroExpansion(
      """
      extension A {
        struct B {
          func f(a: Int, b: Int) {
            class C {
              @A subscript(i: Int) -> String {
                func g() {
                  #allLexicalContexts
                }
              }
            }
          }
        }
      }
      """,
      expandedSource: """
        extension A {
          struct B {
            func f(a: Int, b: Int) {
              class C {
                @A subscript(i: Int) -> String {
                  func g() {
                    func g()
                    @A subscript(i: Int) -> String
                    class C {
                    }
                    func f(a: Int, b: Int)
                    struct B {
                    }
                    extension A {
                    }
                  }
                }
              }
            }
          }
        }
        """,
      macros: ["allLexicalContexts": AllLexicalContextsMacro.self]
    )

    // Test closures separately, because they don't fit as declaration macros.
    let closure: ExprSyntax = "{ (a, b) in print(a + b) }"
    XCTAssertEqual(closure.asMacroLexicalContext()!.description, "{ (a, b) in }")
  }
}
