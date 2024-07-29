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

import Foundation
@_spi(Experimental) import SwiftLexicalLookup
import SwiftSyntax
import XCTest

final class testNameLookup: XCTestCase {
  func testCodeBlockSimpleCase() {
    assertLexicalNameLookup(
      source: """
        for i in 1..<4 {
          let 1️⃣a = i
          let 2️⃣b = 3️⃣a

          for j in 1..<4 {
            let 4️⃣c = 5️⃣a
            let 6️⃣a = j

            let d = 7️⃣a + 8️⃣b + 9️⃣c
          }
        }
        """,
      references: [
        "3️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣"])],
        "5️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣"])],
        "7️⃣": [
          .fromScope(CodeBlockSyntax.self, expectedNames: ["6️⃣"]),
          .fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣"]),
        ],
        "8️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["2️⃣"])],
        "9️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["4️⃣"])],
      ],
      expectedResultTypes: .all(IdentifierPatternSyntax.self)
    )
  }

  func testLookupForComplexDeclarationsInCodeBlock() {
    assertLexicalNameLookup(
      source: """
        for i in 1..<4 {
          let (1️⃣a, 2️⃣b) = (1, 2)
          let 3️⃣c = 3, 4️⃣d = 9️⃣c

          5️⃣a
          6️⃣b
          7️⃣c
          8️⃣d
        }
        """,
      references: [
        "5️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣"])],
        "6️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["2️⃣"])],
        "7️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["3️⃣"])],
        "8️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["4️⃣"])],
        "9️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["3️⃣"])],
      ],
      expectedResultTypes: .all(IdentifierPatternSyntax.self)
    )
  }

  func testLookupForLoop() {
    assertLexicalNameLookup(
      source: """
        for 1️⃣i in 1..<4 {
          let (a, b) = (2️⃣i, 3️⃣j)
          for (4️⃣i, (5️⃣j, 8️⃣k)) in foo {
            let (c, d, e) = (6️⃣i, 7️⃣j, 9️⃣k)
          }
        }
        """,
      references: [
        "2️⃣": [.fromScope(ForStmtSyntax.self, expectedNames: ["1️⃣"])],
        "3️⃣": [],
        "6️⃣": [
          .fromScope(ForStmtSyntax.self, expectedNames: ["4️⃣"]),
          .fromScope(ForStmtSyntax.self, expectedNames: ["1️⃣"]),
        ],
        "7️⃣": [.fromScope(ForStmtSyntax.self, expectedNames: ["5️⃣"])],
        "9️⃣": [.fromScope(ForStmtSyntax.self, expectedNames: ["8️⃣"])],
      ],
      expectedResultTypes: .all(IdentifierPatternSyntax.self)
    )
  }

  func testLookupForCaseLetLoop() {
    assertLexicalNameLookup(
      source: """
        for case let 1️⃣a as T in arr {
          2️⃣a.foo()
        }
        """,
      references: ["2️⃣": [.fromScope(ForStmtSyntax.self, expectedNames: ["1️⃣"])]],
      expectedResultTypes: .all(IdentifierPatternSyntax.self)
    )
  }

  func testShorthandParameterLookupClosure() {
    assertLexicalNameLookup(
      source: """
        func foo() {
          let 1️⃣a = 1
          let 2️⃣b = 2
          let 3️⃣x: (Int, Int, Int) = { 4️⃣a, _, 5️⃣c in
            print(6️⃣a, 7️⃣b, 8️⃣c, 0️⃣$0)
          }
          9️⃣x()
        }
        """,
      references: [
        "6️⃣": [
          .fromScope(ClosureExprSyntax.self, expectedNames: ["4️⃣"]),
          .fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣"]),
        ],
        "7️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["2️⃣"])],
        "8️⃣": [.fromScope(ClosureExprSyntax.self, expectedNames: ["5️⃣"])],
        "9️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["3️⃣"])],
        "0️⃣": [],
      ],
      expectedResultTypes: .all(
        IdentifierPatternSyntax.self,
        except: [
          "4️⃣": ClosureShorthandParameterSyntax.self,
          "5️⃣": ClosureShorthandParameterSyntax.self,
        ]
      )
    )
  }

  func testClosureCaptureLookup() {
    assertLexicalNameLookup(
      source: """
        func foo() {
          let 1️⃣a = 1
          let x = { [3️⃣a, 4️⃣unowned b] in
            print(6️⃣a)
          }
          let b = 0
        }
        """,
      references: [
        "6️⃣": [
          .fromScope(ClosureExprSyntax.self, expectedNames: ["3️⃣"]),
          .fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣"]),
        ]
      ],
      expectedResultTypes: .all(
        ClosureCaptureSyntax.self,
        except: [
          "1️⃣": IdentifierPatternSyntax.self
        ]
      )
    )
  }

  func testParameterLookupClosure() {
    assertLexicalNameLookup(
      source: """
        func foo() {
          let 1️⃣a = 1
          let 2️⃣b = 2
          let 3️⃣x = { (4️⃣a b: Int, 5️⃣c: Int) in
              print(6️⃣a, 7️⃣b, 8️⃣c, 0️⃣$0)
          }
          9️⃣x()
        }
        """,
      references: [
        "6️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣"])],
        "7️⃣": [
          .fromScope(ClosureExprSyntax.self, expectedNames: ["4️⃣"]),
          .fromScope(CodeBlockSyntax.self, expectedNames: ["2️⃣"]),
        ],
        "8️⃣": [.fromScope(ClosureExprSyntax.self, expectedNames: ["5️⃣"])],
        "9️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["3️⃣"])],
        "0️⃣": [],
      ],
      expectedResultTypes: .all(
        IdentifierPatternSyntax.self,
        except: [
          "4️⃣": ClosureParameterSyntax.self,
          "5️⃣": ClosureParameterSyntax.self,
        ]
      )
    )
  }

  func testWhileOptionalBindingLookup() {
    assertLexicalNameLookup(
      source: """
        func foo() {
          let 1️⃣b = x
          while let 2️⃣a = 3️⃣b {
            let 4️⃣b = x
            print(5️⃣a, 6️⃣b)
          }
        }
        """,
      references: [
        "3️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣"])],
        "5️⃣": [.fromScope(WhileStmtSyntax.self, expectedNames: ["2️⃣"])],
        "6️⃣": [
          .fromScope(CodeBlockSyntax.self, expectedNames: ["4️⃣"]),
          .fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣"]),
        ],
      ],
      expectedResultTypes: .all(
        IdentifierPatternSyntax.self
      )
    )
  }

  func testIfLetOptionalBindingSimpleCaseWithPrecedence() {
    assertLexicalNameLookup(
      source: """
        if let 1️⃣a = 2️⃣b, let 3️⃣b = 4️⃣a {
          print(5️⃣a, 6️⃣b)
        } else {
          print(7️⃣a, 8️⃣b)
        }
        """,
      references: [
        "2️⃣": [],
        "4️⃣": [.fromScope(IfExprSyntax.self, expectedNames: ["1️⃣"])],
        "5️⃣": [.fromScope(IfExprSyntax.self, expectedNames: ["1️⃣"])],
        "6️⃣": [.fromScope(IfExprSyntax.self, expectedNames: ["3️⃣"])],
        "7️⃣": [],
        "8️⃣": [],
      ],
      expectedResultTypes: .all(
        IdentifierPatternSyntax.self
      )
    )
  }

  func testIfLetWithElseIfAndNesting() {
    assertLexicalNameLookup(
      source: """
        if let 1️⃣a = x {
          if let 2️⃣a = x {
            print(3️⃣a)
          } else if let 4️⃣a = x {
            print(5️⃣a)
          } else {
            print(6️⃣a)
          }
          print(7️⃣a)
        } else if let 8️⃣a = x {
          print(9️⃣a)
        } else {
          print(0️⃣a)
        }
        """,
      references: [
        "3️⃣": [
          .fromScope(IfExprSyntax.self, expectedNames: ["2️⃣"]),
          .fromScope(IfExprSyntax.self, expectedNames: ["1️⃣"]),
        ],
        "5️⃣": [
          .fromScope(IfExprSyntax.self, expectedNames: ["4️⃣"]),
          .fromScope(IfExprSyntax.self, expectedNames: ["1️⃣"]),
        ],
        "6️⃣": [.fromScope(IfExprSyntax.self, expectedNames: ["1️⃣"])],
        "7️⃣": [.fromScope(IfExprSyntax.self, expectedNames: ["1️⃣"])],
        "9️⃣": [.fromScope(IfExprSyntax.self, expectedNames: ["8️⃣"])],
        "0️⃣": [],
      ],
      expectedResultTypes: .all(
        IdentifierPatternSyntax.self
      )
    )
  }

  func testMemberBlockScope() {
    assertLexicalNameLookup(
      source: """
        class x {
          var 1️⃣a = 1

          2️⃣class b {}
          3️⃣struct b {}

          4️⃣func a {
            5️⃣a
            6️⃣b
            7️⃣c
            8️⃣d
          }

          9️⃣actor c {}
          0️⃣protocol d {}
        }
        """,
      references: [
        "5️⃣": [.fromScope(MemberBlockSyntax.self, expectedNames: ["1️⃣", "4️⃣"])],
        "6️⃣": [.fromScope(MemberBlockSyntax.self, expectedNames: ["2️⃣", "3️⃣"])],
        "7️⃣": [.fromScope(MemberBlockSyntax.self, expectedNames: ["9️⃣"])],
        "8️⃣": [.fromScope(MemberBlockSyntax.self, expectedNames: ["0️⃣"])],
      ],
      expectedResultTypes: .distinct([
        "1️⃣": IdentifierPatternSyntax.self,
        "2️⃣": ClassDeclSyntax.self,
        "3️⃣": StructDeclSyntax.self,
        "4️⃣": FunctionDeclSyntax.self,
        "9️⃣": ActorDeclSyntax.self,
        "0️⃣": ProtocolDeclSyntax.self,
      ])
    )
  }

  func testLookupInDeclaration() {
    assertLexicalNameLookup(
      source: """
        class foo {
          let 1️⃣a = 2️⃣a

          func foo() {
            let 3️⃣a = 4️⃣a
          
            if let 5️⃣a = 6️⃣a {
              let (a, b) = 8️⃣a
            }
          }

          let 9️⃣a = 0️⃣a
        }
        """,
      references: [
        "2️⃣": [.fromScope(MemberBlockSyntax.self, expectedNames: ["1️⃣", "9️⃣"])],
        "0️⃣": [.fromScope(MemberBlockSyntax.self, expectedNames: ["1️⃣", "9️⃣"])],
        "4️⃣": [.fromScope(MemberBlockSyntax.self, expectedNames: ["1️⃣", "9️⃣"])],
        "6️⃣": [
          .fromScope(CodeBlockSyntax.self, expectedNames: ["3️⃣"]),
          .fromScope(MemberBlockSyntax.self, expectedNames: ["1️⃣", "9️⃣"]),
        ],
        "8️⃣": [
          .fromScope(IfExprSyntax.self, expectedNames: ["5️⃣"]),
          .fromScope(CodeBlockSyntax.self, expectedNames: ["3️⃣"]),
          .fromScope(MemberBlockSyntax.self, expectedNames: ["1️⃣", "9️⃣"]),
        ],
      ],
      expectedResultTypes: .all(
        IdentifierPatternSyntax.self
      )
    )
  }

  func testIfCaseLookup() {
    assertLexicalNameLookup(
      source: """
        if case .x(let 1️⃣a, let 2️⃣b) = f {
          print(3️⃣a, 4️⃣b)
        } else if case .y(let 5️⃣a) = f {
          print(6️⃣a, 7️⃣b)
        } else if case .z = f {
          print(8️⃣a, 9️⃣b)
        }
        """,
      references: [
        "3️⃣": [.fromScope(IfExprSyntax.self, expectedNames: ["1️⃣"])],
        "4️⃣": [.fromScope(IfExprSyntax.self, expectedNames: ["2️⃣"])],
        "6️⃣": [.fromScope(IfExprSyntax.self, expectedNames: ["5️⃣"])],
        "7️⃣": [],
        "8️⃣": [],
        "9️⃣": [],
      ],
      expectedResultTypes: .all(
        IdentifierPatternSyntax.self
      )
    )
  }

  func testNameLookupForNilParameter() {
    assertLexicalNameLookup(
      source: """
        🔟class foo {
          let 1️⃣a = 0
          let 2️⃣b = 0

          3️⃣func foo() {
            let 4️⃣a = 0
            let 5️⃣c = 0
          
            if let 6️⃣a = 7️⃣x {
              let (8️⃣a, 9️⃣b) = (0, 0)
              
              0️⃣x
            }
          }
        }
        """,
      references: [
        "7️⃣": [
          .fromScope(CodeBlockSyntax.self, expectedNames: ["4️⃣", "5️⃣"]),
          .fromScope(MemberBlockSyntax.self, expectedNames: ["1️⃣", "2️⃣", "3️⃣"]),
          .fromFileScope(expectedNames: ["🔟"]),
        ],
        "0️⃣": [
          .fromScope(CodeBlockSyntax.self, expectedNames: ["8️⃣", "9️⃣"]),
          .fromScope(IfExprSyntax.self, expectedNames: ["6️⃣"]),
          .fromScope(CodeBlockSyntax.self, expectedNames: ["4️⃣", "5️⃣"]),
          .fromScope(MemberBlockSyntax.self, expectedNames: ["1️⃣", "2️⃣", "3️⃣"]),
          .fromFileScope(expectedNames: ["🔟"]),
        ],
      ],
      expectedResultTypes: .all(
        IdentifierPatternSyntax.self,
        except: [
          "3️⃣": FunctionDeclSyntax.self,
          "🔟": ClassDeclSyntax.self,
        ]
      ),
      useNilAsTheParameter: true
    )
  }

  func testGuardLookup() {
    assertLexicalNameLookup(
      source: """
        func foo() {
          let 1️⃣a = 0
          
          guard let 2️⃣a, let 3️⃣b = c else {
            print(4️⃣a, 5️⃣b)
            return
          }

          print(6️⃣a, 7️⃣b)
        }
        """,
      references: [
        "4️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣"])],
        "5️⃣": [],
        "6️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣", "2️⃣"])],
        "7️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["3️⃣"])],
      ],
      expectedResultTypes: .all(
        IdentifierPatternSyntax.self
      )
    )
  }

  func testGuardLookupInConditions() {
    assertLexicalNameLookup(
      source: """
        func foo() {
          let 1️⃣a = 0
          guard let 2️⃣a = 3️⃣a, let 4️⃣a = 5️⃣a, let a = 6️⃣a else { return }
        }
        """,
      references: [
        "3️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣"])],
        "5️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣", "2️⃣"])],
        "6️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣", "2️⃣", "4️⃣"])],
      ],
      expectedResultTypes: .all(
        IdentifierPatternSyntax.self
      )
    )
  }

  func testSimpleFileScope() {
    assertLexicalNameLookup(
      source: """
        1️⃣class a {}

        2️⃣class b {
          let x = 3️⃣a + 4️⃣b + 5️⃣c + 6️⃣d
        }
         
        let 8️⃣a = 0

        7️⃣class c {}

        if a == 0 {}

        9️⃣class d {}

        let 🔟a = 0️⃣d
        """,
      references: [
        "3️⃣": [.fromFileScope(expectedNames: ["1️⃣", "8️⃣"])],
        "4️⃣": [.fromFileScope(expectedNames: ["2️⃣"])],
        "5️⃣": [.fromFileScope(expectedNames: ["7️⃣"])],
        "6️⃣": [.fromFileScope(expectedNames: ["9️⃣"])],
        "0️⃣": [.fromFileScope(expectedNames: ["9️⃣"])],
      ],
      expectedResultTypes: .all(ClassDeclSyntax.self, except: ["8️⃣": IdentifierPatternSyntax.self])
    )
  }

  func testFileScopeAsMember() {
    assertLexicalNameLookup(
      source: """
        1️⃣class a {}

        2️⃣class b {
          let x = 3️⃣a + 4️⃣b + 5️⃣c + 6️⃣d
        }
         
        let 8️⃣a = 0

        7️⃣class c {}

        if a == 0 {}

        9️⃣class d {}

        let 🔟a = 0️⃣d
        """,
      references: [
        "3️⃣": [.fromFileScope(expectedNames: ["1️⃣", "8️⃣", "🔟"])],
        "4️⃣": [.fromFileScope(expectedNames: ["2️⃣"])],
        "5️⃣": [.fromFileScope(expectedNames: ["7️⃣"])],
        "6️⃣": [.fromFileScope(expectedNames: ["9️⃣"])],
        "0️⃣": [.fromFileScope(expectedNames: ["9️⃣"])],
      ],
      expectedResultTypes: .all(
        ClassDeclSyntax.self,
        except: [
          "8️⃣": IdentifierPatternSyntax.self,
          "🔟": IdentifierPatternSyntax.self,
        ]
      ),
      config: LookupConfig(fileScopeHandling: .memberBlock)
    )
  }

  func testDeclarationAvailabilityInCodeBlock() {
    assertLexicalNameLookup(
      source: """
        func x {
          1️⃣class A {}

          let a = 2️⃣A()

          3️⃣class A {}
        }
        """,
      references: [
        "2️⃣": [.fromScope(CodeBlockSyntax.self, expectedNames: ["1️⃣", "3️⃣"])]
      ],
      expectedResultTypes: .all(ClassDeclSyntax.self)
    )
  }
}
