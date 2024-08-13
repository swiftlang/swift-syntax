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

fileprivate struct StringifyMacro: ExpressionMacro {
  static func expansion(
    of macro: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    guard let argument = macro.arguments.first?.expression else {
      throw SwiftSyntaxMacros.MacroExpansionErrorMessage("missing argument")
    }

    return "(\(argument), \(StringLiteralExprSyntax(content: argument.description)))"
  }
}

private struct InfiniteRecursionMacro: ExpressionMacro {
  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    if let i = node.arguments.first?.expression.as(IntegerLiteralExprSyntax.self)?.representedLiteralValue {
      return "\(raw: i) + #infiniteRecursion(i: \(raw: i + 1))"
    } else {
      return "#nested1"
    }
  }
}

private struct Nested1RecursionMacro: ExpressionMacro {
  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    "(#nested2, #nested3, #infiniteRecursion(i: 1), #infiniteRecursion)"
  }
}

private struct Nested2RecursionMacro: ExpressionMacro {
  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    "(#nested3, #nested3)"
  }
}

private struct Nested3RecursionMacro: ExpressionMacro {
  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    "0"
  }
}

final class ExpressionMacroTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testContextIndependence() {
    /// Macro whose only purpose is to ensure that we cannot see "out" of the
    /// macro expansion syntax node we were given.
    struct CheckContextIndependenceMacro: ExpressionMacro {
      static func expansion(
        of macro: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) -> ExprSyntax {

        // Should not have a parent.
        XCTAssertNil(macro.parent)

        // Absolute starting position should be zero.
        XCTAssertEqual(macro.position.utf8Offset, 0)

        return "()"
      }
    }

    assertMacroExpansion(
      """
      let b = #checkContext
      """,
      expandedSource: """
        let b = ()
        """,
      macros: ["checkContext": CheckContextIndependenceMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testExpressionExpansion() {
    struct ColorLiteralMacro: ExpressionMacro {
      static func expansion(
        of macro: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) -> ExprSyntax {
        var argList = macro.arguments
        argList[argList.startIndex].label = .identifier("_colorLiteralRed")
        let initSyntax: ExprSyntax = ".init(\(argList))"
        return initSyntax
      }
    }

    assertMacroExpansion(
      """
      let b = #stringify(x + y)
      """,
      expandedSource: """
        let b = (x + y, "x + y")
        """,
      macros: ["stringify": StringifyMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      #colorLiteral(red: 0.5, green: 0.5, blue: 0.25, alpha: 1.0)
      """,
      expandedSource: """
        .init(_colorLiteralRed: 0.5, green: 0.5, blue: 0.25, alpha: 1.0)
        """,
      macros: ["colorLiteral": ColorLiteralMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testTriviaTransferOnExpressionMacro() {
    assertMacroExpansion(
      """
      // Ignore me
      \t
      // Capture me
      #stringify(x)
      """,
      expandedSource: """
        // Ignore me
        \t
        // Capture me
        (x, "x")
        """,
      macros: ["stringify": StringifyMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testCommentsOnExpressionMacro() {
    assertMacroExpansion(
      """
      let b =
      /*leading */ #stringify(x + y) /*trailing*/
      """,
      expandedSource: """
        let b =
        /*leading */ (x + y, "x + y") /*trailing*/
        """,
      macros: ["stringify": StringifyMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testStringifyExpression() {
    assertMacroExpansion(
      """
      _ = #stringify({ () -> Bool in
        print("hello")
        return true
      })
      """,
      expandedSource: """
        _ = ({ () -> Bool in
          print("hello")
          return true
          }, #"{ () -> Bool in\\#n  print("hello")\\#n  return true\\#n}"#)
        """,
      macros: ["stringify": StringifyMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testLocationExpansions() {
    struct ColumnMacro: ExpressionMacro {
      static func expansion(
        of macro: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> ExprSyntax {
        guard let sourceLoc: AbstractSourceLocation = context.location(of: macro) else {
          throw SwiftSyntaxMacros.MacroExpansionErrorMessage("can't find location for macro")
        }
        return sourceLoc.column
      }
    }

    struct FileIDMacro: ExpressionMacro {
      static func expansion(
        of macro: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> ExprSyntax {
        guard let sourceLoc: AbstractSourceLocation = context.location(of: macro) else {
          throw SwiftSyntaxMacros.MacroExpansionErrorMessage("can't find location for macro")
        }
        return sourceLoc.file
      }
    }

    assertMacroExpansion(
      """
      let b = #fileID
      let c = #column
      """,
      expandedSource: """
        let b = "MyModule/taylor.swift"
        let c = 9
        """,
      macros: ["fileID": FileIDMacro.self, "column": ColumnMacro.self],
      testModuleName: "MyModule",
      testFileName: "taylor.swift",
      indentationWidth: indentationWidth
    )
  }

  func testThrowErrorFromExpressionMacro() {
    struct MyError: Error, CustomStringConvertible {
      let description: String = "my error"
    }

    struct TestMacro: ExpressionMacro {
      public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> ExprSyntax {
        throw MyError()
      }
    }

    assertMacroExpansion(
      "#test",
      expandedSource: "#test",
      diagnostics: [
        DiagnosticSpec(message: "my error", line: 1, column: 1)
      ],
      macros: ["test": TestMacro.self]
    )

    assertMacroExpansion(
      "1 + #test",
      expandedSource: "1 + #test",
      diagnostics: [
        DiagnosticSpec(message: "my error", line: 1, column: 5)
      ],
      macros: ["test": TestMacro.self]
    )
  }

  func testFoldOperators() {
    struct ForceSubtractMacro: ExpressionMacro {
      static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
          fatalError("Must receive an argument")
        }
        guard var node = argument.as(InfixOperatorExprSyntax.self) else {
          return argument
        }
        node.operator = ExprSyntax(BinaryOperatorExprSyntax(text: "-"))
        return ExprSyntax(node)
      }
    }
    assertMacroExpansion(
      "#test(1 + 2)",
      expandedSource: "1 - 2",
      macros: ["test": ForceSubtractMacro.self]
    )
  }

  func testDiagnosticFromFoldedOperators() {
    struct MyError: Error {}

    struct DiagnoseFirstArgument: ExpressionMacro {
      static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
          fatalError("Must receive an argument")
        }
        context.addDiagnostics(from: MyError(), node: argument)
        return argument
      }
    }

    assertMacroExpansion(
      """
      /// Test
      func test() {
        #test(1 + 2)
      }
      """,
      expandedSource: """
        /// Test
        func test() {
          1 + 2
        }
        """,
      diagnostics: [
        DiagnosticSpec(message: "MyError()", line: 3, column: 9, severity: .error)
      ],
      macros: ["test": DiagnoseFirstArgument.self]
    )
  }

  func testDetectCircularExpansion() {
    assertMacroExpansion(
      "#nested1",
      expandedSource: "((0, 0), 0, 1 + #infiniteRecursion(i: 2), #nested1)",
      diagnostics: [
        DiagnosticSpec(
          message:
            "recursive expansion of macro 'InfiniteRecursionMacro'",
          line: 1,
          column: 5
        ),
        DiagnosticSpec(
          message:
            "recursive expansion of macro 'Nested1RecursionMacro'",
          line: 1,
          column: 1
        ),
      ],
      macros: [
        "nested1": Nested1RecursionMacro.self,
        "nested2": Nested2RecursionMacro.self,
        "nested3": Nested3RecursionMacro.self,
        "infiniteRecursion": InfiniteRecursionMacro.self,
      ]
    )
  }
}
