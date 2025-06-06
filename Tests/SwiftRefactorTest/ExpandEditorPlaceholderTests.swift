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

import SwiftBasicFormat
import SwiftParser
@_spi(Testing) import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

fileprivate let closurePlaceholder = wrapInPlaceholder("T##closure##() -> Void")
fileprivate let closureWithArgPlaceholder = wrapInPlaceholder(
  "T##(Int) -> String##(Int) -> String##(_ someInt: Int) -> String"
)
fileprivate let closureCombinedTypeDisplayPlaceholder = wrapInPlaceholder(
  "T##(Int) -> String"
)
fileprivate let voidPlaceholder = wrapInPlaceholder("T##code##Void")
fileprivate let intPlaceholder = wrapInPlaceholder("T##Int##Int")
fileprivate let stringPlaceholder = wrapInPlaceholder("T##String##String")

final class ExpandEditorPlaceholderTests: XCTestCase {
  func testSimple() throws {
    try assertRefactorPlaceholder("displayOnly", expected: "displayOnly")
    try assertRefactorPlaceholder("T##typed", expected: "typed")
    try assertRefactorPlaceholder("T##displayAndType##Int", expected: "Int")
    try assertRefactorPlaceholder("T##bothTypes##Int##BetterInt", expected: "BetterInt")
    try assertRefactorPlaceholder("T##bothTypesFirstEmpty####BetterInt", expected: "BetterInt")
  }

  func testEmpty() throws {
    try assertRefactorPlaceholder("", expected: "")
    try assertRefactorPlaceholder("T##", expected: "")
    try assertRefactorPlaceholder("T##displayEmptyType##", expected: "displayEmptyType")
    try assertRefactorPlaceholder("T####EmptyDisplay", expected: "EmptyDisplay")
    try assertRefactorPlaceholder("T######EmptyTypeAndDisplay", expected: "EmptyTypeAndDisplay")
    try assertRefactorPlaceholder("T##bothTypesFirstNotEmpty##Int##", expected: "Int")
    try assertRefactorPlaceholder("T##bothTypesEmpty####", expected: "bothTypesEmpty")
  }

  func testVoidClosure() throws {
    let expected = """
      {
          \(voidPlaceholder)
      }
      """
    try assertRefactorPlaceholder("T##display##() -> Void", expected: expected)
  }

  func testTypedReturnClosure() throws {
    let expected = """
      {
          \(intPlaceholder)
      }
      """
    try assertRefactorPlaceholder("T##display##() -> Int", expected: expected)
  }

  func testClosureWithArg() throws {
    let expected = """
      { arg in
          \(intPlaceholder)
      }
      """
    try assertRefactorPlaceholder("T##display##(arg: String) -> Int", expected: expected)
    try assertRefactorPlaceholder("T##display##(_ arg: String) -> Int", expected: expected)
  }

  func testClosureWithMultipleArgs() throws {
    let expected = """
      { arg, arg2 in
          \(intPlaceholder)
      }
      """
    try assertRefactorPlaceholder("T##display##(arg: String, arg2: String) -> Int", expected: expected)
  }

  func testSimpleComments() throws {
    let placeholder = wrapInPlaceholder("simple")
    try assertRefactorPlaceholder("/*c1*/\(placeholder)/*c2*/", wrap: false, expected: "/*c1*/simple/*c2*/")
  }

  func testClosureComments() throws {
    let placeholder = wrapInPlaceholder("T##display##(arg: String) -> Int")
    let expected = """
      /*c1*/{ arg in
          \(intPlaceholder)
      }/*c2*/
      """
    try assertRefactorPlaceholder("/*c1*/\(placeholder)/*c2*/", wrap: false, expected: expected)
  }

  func testSingleClosureArg() throws {
    let baseline = "call(\(closurePlaceholder))"

    let expected: String = """
      call {
          \(voidPlaceholder)
      }
      """

    try assertRefactorPlaceholderCall(baseline, expected: expected)
  }

  func testSingleNonClosureArg() throws {
    try assertRefactorPlaceholderToken("call(\(intPlaceholder))", expected: "Int")
  }

  func testTypeForExpansionPreferred() throws {
    let placeholder = wrapInPlaceholder("T##closure##BadType##() -> Int")
    let baseline = "call(\(placeholder))"

    let expected: String = """
      call {
          \(intPlaceholder)
      }
      """

    try assertRefactorPlaceholderCall(baseline, expected: expected)
  }

  func testPlaceholderWithoutExplicitText() throws {
    let placeholder = wrapInPlaceholder("T##(Int) -> Void")
    let baseline = "call(\(placeholder))"

    let int = wrapInPlaceholder("Int")
    let expected: String = """
      call { \(int) in
          \(voidPlaceholder)
      }
      """

    try assertRefactorPlaceholderCall(baseline, expected: expected)
  }

  func testMultipleClosureArgs() throws {
    let baseline = "call(arg1: \(closurePlaceholder), arg2: \(closurePlaceholder))"

    let expected: String = """
      call {
          \(voidPlaceholder)
      } arg2: {
          \(voidPlaceholder)
      }
      """

    try assertRefactorPlaceholderCall(baseline, expected: expected)
    try assertRefactorPlaceholderCall(baseline, placeholder: 1, expected: expected)
  }

  func testNonClosureAfterClosure() throws {
    let baseline = "call(arg1: \(closurePlaceholder), arg2: \(intPlaceholder))"

    let expected: String = """
      {
          \(voidPlaceholder)
      }
      """

    try assertRefactorPlaceholderToken(baseline, expected: expected)
  }

  func testComments() throws {
    let baseline = """
      /*c1*/foo/*c2*/(/*c3*/arg/*c4*/: /*c5*/\(closurePlaceholder)/*c6*/,/*c7*/
          /*c8*/\(closurePlaceholder)/*c9*/)/*c10*/
      """

    // TODO: Should we remove whitespace from the merged trivia? The space
    // between c2 and c3 is the one added for the `{`. The space between c4
    // and c5 is the space between the `:` and c5 (added by merging the
    // colon's trivia since it was removed).
    let expected: String = """
      /*c1*/foo/*c2*/ /*c3*//*c4*/ /*c5*/{
          \(voidPlaceholder)
      }/*c6*//*c7*/ _:
          /*c8*/{
          \(voidPlaceholder)
      }/*c9*//*c10*/
      """

    try assertRefactorPlaceholderCall(baseline, placeholder: 1, expected: expected)
  }

  func testExpandEditorPlaceholdersToSingleTrailingClosures() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(arg: \(intPlaceholder), closure: \(closureWithArgPlaceholder))
      """,
      expected: """
        foo(arg: \(intPlaceholder)) { someInt in
            \(stringPlaceholder)
        }
        """
    )
  }

  func testExpandEditorPlaceholdersToMultipleTrailingClosures() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(arg: \(intPlaceholder), firstClosure: \(closureWithArgPlaceholder), secondClosure: \(closureWithArgPlaceholder))
      """,
      expected: """
        foo(arg: \(intPlaceholder)) { someInt in
            \(stringPlaceholder)
        } secondClosure: { someInt in
            \(stringPlaceholder)
        }
        """
    )
  }

  func testExpandEditorPlaceholdersDoesntExpandClosureBeforeNormalArgs() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(pre: \(closurePlaceholder), arg: \(intPlaceholder), closure: \(closureWithArgPlaceholder))
      """,
      expected: """
        foo(pre: \(closurePlaceholder), arg: \(intPlaceholder)) { someInt in
            \(stringPlaceholder)
        }
        """
    )
  }

  func testCallHasInitialIndentation() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
          foo(arg: 1, closure: \(closureWithArgPlaceholder))
      """,
      expected: """
            foo(arg: 1) { someInt in
                \(stringPlaceholder)
            }
        """
    )
  }

  func testCustomIndentationWidth() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(arg: 1, closure: \(closureWithArgPlaceholder))
      """,
      expected: """
        foo(arg: 1) { someInt in
          \(stringPlaceholder)
        }
        """,
      format: .trailing(indentationWidth: .spaces(2))
    )
  }

  func testCustomIndentationWidthWithInitialIndentation() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
        foo(arg: 1, closure: \(closureWithArgPlaceholder))
      """,
      expected: """
          foo(arg: 1) { someInt in
            \(stringPlaceholder)
          }
        """,
      format: .trailing(indentationWidth: .spaces(2))
    )
  }

  func testMultilineCall() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(
          arg: 1,
          closure: \(closureWithArgPlaceholder)
      )
      """,
      expected: """
        foo(
            arg: 1
        ) { someInt in
            \(stringPlaceholder)
        }
        """
    )
  }

  func testMultilineIndentedCall() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
          foo(
              arg: 1,
              closure: \(closureWithArgPlaceholder)
          )
      """,
      expected: """
            foo(
                arg: 1
            ) { someInt in
                \(stringPlaceholder)
            }
        """
    )
  }

  func testMultilineCallWithNoAdditionalArguments() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(
          closure: \(closureWithArgPlaceholder)
      )
      """,
      expected: """
        foo { someInt in
            \(stringPlaceholder)
        }
        """
    )
  }

  // MARK:- Custom closure format

  func testSingleClosuresWithCustomFormat() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(arg: \(intPlaceholder), closure: \(closureWithArgPlaceholder))
      """,
      expected: """
        foo(arg: \(intPlaceholder), closure: <#{ someInt in \(stringPlaceholder) }#>)
        """,
      format: .testCustom()
    )
  }

  func testWithCustomFormatClosurePlaceholderCombinedTypeAndDisplayString() async throws {
    let intPlaceholder = wrapInPlaceholder("Int")
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(closure: \(closureCombinedTypeDisplayPlaceholder))
      """,
      expected: """
        foo(closure: <#{ \(intPlaceholder) in \(stringPlaceholder) }#>)
        """,
      format: .testCustom()
    )
  }

  func testWithCustomFormatToMultipleClosuresWithCustomFormat() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(arg: \(intPlaceholder), firstClosure: \(closureWithArgPlaceholder), secondClosure: \(closureWithArgPlaceholder))
      """,
      expected: """
        foo(arg: \(intPlaceholder), firstClosure: <#{ someInt in \(stringPlaceholder) }#>, secondClosure: <#{ someInt in \(stringPlaceholder) }#>)
        """,
      format: .testCustom()
    )
  }

  func testWithCustomFormatDoesntExpandClosureBeforeNormalArgs() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(pre: \(closurePlaceholder), arg: \(intPlaceholder), closure: \(closureWithArgPlaceholder))
      """,
      expected: """
        foo(pre: \(closurePlaceholder), arg: \(intPlaceholder), closure: <#{ someInt in \(stringPlaceholder) }#>)
        """,
      format: .testCustom()
    )
  }

  func testWithCustomFormatCallHasInitialIndentation() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
          foo(arg: 1, closure: \(closureWithArgPlaceholder))
      """,
      expected: """
            foo(arg: 1, closure: <#{ someInt in \(stringPlaceholder) }#>)
        """,
      format: .testCustom()
    )
  }

  func testCustomFormatAndCustomIndentationWidthWithInitialIndentation() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
        foo(arg: 1, closure: \(closureWithArgPlaceholder))
      """,
      expected: """
          foo(arg: 1, closure: <#{ someInt in \(stringPlaceholder) }#>)
        """,
      format: .testCustom(indentationWidth: .spaces(2))
    )
  }

  func testCustomFormatMultilineCall() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(
          arg: 1,
          closure: \(closureWithArgPlaceholder)
      )
      """,
      expected: """
        foo(
            arg: 1,
            closure: <#{ someInt in \(stringPlaceholder) }#>
        )
        """,
      format: .testCustom()
    )
  }

  func testCustomFormatMultilineIndentedCall() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
          foo(
              arg: 1,
              closure: \(closureWithArgPlaceholder)
          )
      """,
      expected: """
            foo(
                arg: 1,
                closure: <#{ someInt in \(stringPlaceholder) }#>
            )
        """,
      format: .testCustom()
    )
  }

  func testCustomFormatMultilineCallWithNoAdditionalArguments() throws {
    try assertExpandEditorPlaceholdersToClosures(
      """
      foo(
          closure: \(closureWithArgPlaceholder)
      )
      """,
      expected: """
        foo(
            closure: <#{ someInt in \(stringPlaceholder) }#>
        )
        """,
      format: .testCustom()
    )
  }

  func testMacroTrailingClosureExpansion1() throws {
    try assertRefactorPlaceholderToken(
      "#foo(\(closurePlaceholder), \(intPlaceholder))",
      expected: """
        {
            \(voidPlaceholder)
        }
        """
    )
  }

  func testMacroTrailingClosureExpansion2() throws {
    let call = "#foo(fn: \(closureWithArgPlaceholder))"
    let expanded = """
      #foo { someInt in
          \(stringPlaceholder)
      }
      """

    try assertRefactorPlaceholderCall(call, expected: expanded)
    try assertExpandEditorPlaceholdersToClosures(call, expected: expanded)
  }

  func testMacroTrailingClosureExpansion3() throws {
    let call = "#foo(fn1: \(closurePlaceholder), fn2: \(closureWithArgPlaceholder))"
    let expanded = """
      #foo {
          \(voidPlaceholder)
      } fn2: { someInt in
          \(stringPlaceholder)
      }
      """

    try assertRefactorPlaceholderCall(call, expected: expanded)
    try assertExpandEditorPlaceholdersToClosures(call, expected: expanded)
  }

  func testMacroTrailingClosureExpansion4() throws {
    try assertExpandEditorPlaceholdersToClosures(
      decl: """
        #foo(fn1: \(closurePlaceholder), fn2: \(closurePlaceholder))
        """,
      expected: """
        #foo {
            \(voidPlaceholder)
        } fn2: {
            \(voidPlaceholder)
        }
        """
    )
  }
}

fileprivate func assertRefactorPlaceholder(
  _ placeholder: String,
  wrap: Bool = true,
  expected: String,
  indentationWidth: Trivia? = nil,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  let token: TokenSyntax
  if wrap {
    token = "\(raw: wrapInPlaceholder(placeholder))"
  } else {
    var parser = Parser(placeholder)
    let expr = ExprSyntax.parse(from: &parser)
    token = try XCTUnwrap(expr.as(DeclReferenceExprSyntax.self)?.baseName, file: file, line: line)
  }

  try assertRefactor(
    token,
    context: ExpandEditorPlaceholder.Context(indentationWidth: indentationWidth),
    provider: ExpandEditorPlaceholder.self,
    expected: [SourceEdit.replace(token, with: expected)],
    file: file,
    line: line
  )
}

fileprivate func assertRefactorPlaceholderCall(
  _ expr: String,
  placeholder: Int = 0,
  expected: String,
  indentationWidth: Trivia? = nil,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  var parser = Parser(expr)
  let call = try XCTUnwrap(ExprSyntax.parse(from: &parser).asProtocol(CallLikeSyntax.self), file: file, line: line)
  let arg = call.arguments[call.arguments.index(at: placeholder)]
  let token: TokenSyntax = try XCTUnwrap(arg.expression.as(DeclReferenceExprSyntax.self), file: file, line: line)
    .baseName

  try assertRefactor(
    token,
    context: ExpandEditorPlaceholder.Context(indentationWidth: indentationWidth),
    provider: ExpandEditorPlaceholder.self,
    expected: [SourceEdit.replace(call, with: expected)],
    file: file,
    line: line
  )
}

fileprivate func assertRefactorPlaceholderToken(
  _ expr: String,
  placeholder: Int = 0,
  expected: String,
  indentationWidth: Trivia? = nil,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  var parser = Parser(expr)
  let call = try XCTUnwrap(ExprSyntax.parse(from: &parser).asProtocol(CallLikeSyntax.self), file: file, line: line)
  let arg = call.arguments[call.arguments.index(at: placeholder)]
  let token: TokenSyntax = try XCTUnwrap(arg.expression.as(DeclReferenceExprSyntax.self), file: file, line: line)
    .baseName

  try assertRefactor(
    token,
    context: ExpandEditorPlaceholder.Context(indentationWidth: indentationWidth),
    provider: ExpandEditorPlaceholder.self,
    expected: [SourceEdit.replace(token, with: expected)],
    file: file,
    line: line
  )
}

fileprivate func assertExpandEditorPlaceholdersToClosures(
  _ call: some CallLikeSyntax,
  expected: String,
  format: ExpandEditorPlaceholdersToLiteralClosures.Context.Format = .trailing(indentationWidth: nil),
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  try assertRefactor(
    call,
    context: ExpandEditorPlaceholdersToLiteralClosures.Context(format: format),
    provider: ExpandEditorPlaceholdersToLiteralClosures.self,
    expected: [SourceEdit.replace(call, with: expected)],
    file: file,
    line: line
  )
}

fileprivate func assertExpandEditorPlaceholdersToClosures(
  _ expr: String,
  expected: String,
  format: ExpandEditorPlaceholdersToLiteralClosures.Context.Format = .trailing(indentationWidth: nil),
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  var parser = Parser(expr)
  let call = try XCTUnwrap(ExprSyntax.parse(from: &parser).asProtocol(CallLikeSyntax.self), file: file, line: line)
  try assertExpandEditorPlaceholdersToClosures(
    call,
    expected: expected,
    format: format,
    file: file,
    line: line
  )
}

fileprivate func assertExpandEditorPlaceholdersToClosures(
  decl: String,
  expected: String,
  format: ExpandEditorPlaceholdersToLiteralClosures.Context.Format = .trailing(indentationWidth: nil),
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  var parser = Parser(decl)
  let call = try XCTUnwrap(DeclSyntax.parse(from: &parser).asProtocol(CallLikeSyntax.self), file: file, line: line)
  try assertExpandEditorPlaceholdersToClosures(
    call,
    expected: expected,
    format: format,
    file: file,
    line: line
  )
}

fileprivate extension ExpandEditorPlaceholdersToLiteralClosures.Context.Format {
  static func testCustom(indentationWidth: Trivia? = nil) -> Self {
    .custom(CustomClosureFormat(indentationWidth: indentationWidth), allowNestedPlaceholders: true)
  }
}

fileprivate class CustomClosureFormat: BasicFormat {
  override func requiresNewline(between _: TokenSyntax?, and _: TokenSyntax?) -> Bool {
    return false
  }
}
