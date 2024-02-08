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

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let triviaPiecesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try! EnumDeclSyntax(
    """
    /// A contiguous stretch of a single kind of trivia. The constituent part of
    /// a ``Trivia`` collection.
    ///
    /// For example, four spaces would be represented by
    /// `.spaces(4)`
    ///
    /// In general, you should deal with the actual Trivia collection instead
    /// of individual pieces whenever possible.
    public enum TriviaPiece: Sendable
    """
  ) {
    for trivia in TRIVIAS {
      if trivia.isCollection {
        DeclSyntax(
          """
          /// \(trivia.comment)
          case \(trivia.enumCaseName)(Int)
          """
        )

      } else {
        DeclSyntax(
          """
          /// \(trivia.comment)
          case \(trivia.enumCaseName)(String)
          """
        )
      }
    }
  }

  try! ExtensionDeclSyntax("extension TriviaPiece: TextOutputStreamable") {
    try FunctionDeclSyntax(
      """
      /// Prints the provided trivia as they would be written in a source file.
      ///
      /// - Parameter stream: The stream to which to print the trivia.
      public func write(to target: inout some TextOutputStream)
      """
    ) {
      DeclSyntax(
        """
        func printRepeated(_ character: String, count: Int) {
          for _ in 0..<count { target.write(character) }
        }
        """
      )

      try SwitchExprSyntax("switch self") {
        for trivia in TRIVIAS {
          if trivia.isCollection {
            let joined = trivia.characters.map { "\($0)" }.joined()
            SwitchCaseSyntax("case let .\(trivia.enumCaseName)(count):") {
              ExprSyntax("printRepeated(\(literal: joined), count: count)")
            }
          } else {
            SwitchCaseSyntax("case let .\(trivia.enumCaseName)(text):") {
              ExprSyntax("target.write(text)")
            }
          }
        }
      }
    }
  }

  try! ExtensionDeclSyntax("extension TriviaPiece: CustomDebugStringConvertible") {
    try VariableDeclSyntax(
      """
      /// Returns a description used by dump.
      public var debugDescription: String
      """
    ) {
      try SwitchExprSyntax("switch self") {
        for trivia in TRIVIAS {
          if trivia.isCollection {
            SwitchCaseSyntax("case .\(trivia.enumCaseName)(let data):") {
              StmtSyntax(#"return "\#(trivia.enumCaseName)(\(data))""#)
            }
          } else {
            SwitchCaseSyntax("case .\(trivia.enumCaseName)(let name):") {
              StmtSyntax(#"return "\#(trivia.enumCaseName)(\(name.debugDescription))""#)
            }
          }
        }
      }
    }
  }

  try! ExtensionDeclSyntax(
    """
    extension Trivia
    """
  ) {
    for trivia in TRIVIAS {
      if trivia.isCollection {
        let joined = trivia.characters.map { "\($0)" }.joined()
        DeclSyntax(
          """
          /// Returns a piece of trivia for some number of \(literal: joined) characters.
          public static func \(trivia.enumCaseName)(_ count: Int) -> Trivia {
            return [.\(trivia.enumCaseName)(count)]
          }
          """
        )

        DeclSyntax(
          """
          /// Gets a piece of trivia for \(literal: joined) characters.
          public static var \(trivia.lowerName): Trivia {
            return .\(trivia.enumCaseName)(1)
          }
          """
        )

      } else {
        DeclSyntax(
          """
          /// Returns a piece of trivia for \(trivia.name).
          public static func \(trivia.enumCaseName)(_ text: String) -> Trivia {
            return [.\(trivia.enumCaseName)(text)]
          }
          """
        )
      }
    }
  }

  DeclSyntax("extension TriviaPiece: Equatable {}")

  try! ExtensionDeclSyntax("extension TriviaPiece") {
    try VariableDeclSyntax("public var sourceLength: SourceLength") {
      try SwitchExprSyntax("switch self") {
        for trivia in TRIVIAS {
          if trivia.isCollection {
            SwitchCaseSyntax("case let .\(trivia.enumCaseName)(count):") {
              if trivia.charactersLen != 1 {
                StmtSyntax("return SourceLength(utf8Length: count * \(raw: trivia.charactersLen))")
              } else {
                StmtSyntax("return SourceLength(utf8Length: count)")
              }
            }
          } else {
            SwitchCaseSyntax("case let .\(trivia.enumCaseName)(text):") {
              StmtSyntax("return SourceLength(of: text)")
            }
          }
        }
      }
    }
  }

  try! EnumDeclSyntax(
    """
    /// Trivia piece for token RawSyntax.
    ///
    /// In contrast to ``TriviaPiece``, a ``RawTriviaPiece`` does not own the source
    /// text of the trivia.
    @_spi(RawSyntax)
    public enum RawTriviaPiece: Equatable, Sendable
    """
  ) {
    for trivia in TRIVIAS {
      if trivia.isCollection {
        DeclSyntax("case \(trivia.enumCaseName)(Int)")

      } else {
        DeclSyntax("case \(trivia.enumCaseName)(SyntaxText)")
      }
    }

    try FunctionDeclSyntax(
      """
      static func make(_ piece: TriviaPiece, arena: SyntaxArena) -> RawTriviaPiece
      """
    ) {
      try SwitchExprSyntax("switch piece") {
        for trivia in TRIVIAS {
          if trivia.isCollection {
            SwitchCaseSyntax("case let .\(trivia.enumCaseName)(count):") {
              StmtSyntax("return .\(trivia.enumCaseName)(count)")
            }
          } else {
            SwitchCaseSyntax("case let .\(trivia.enumCaseName)(text):") {
              StmtSyntax("return .\(trivia.enumCaseName)(arena.intern(text))")
            }
          }
        }
      }
    }
  }

  try! ExtensionDeclSyntax("extension TriviaPiece") {
    try InitializerDeclSyntax("@_spi(RawSyntax) public init(raw: RawTriviaPiece)") {
      try SwitchExprSyntax("switch raw") {
        for trivia in TRIVIAS {
          if trivia.isCollection {
            SwitchCaseSyntax("case let .\(trivia.enumCaseName)(count):") {
              ExprSyntax("self = .\(trivia.enumCaseName)(count)")
            }
          } else {
            SwitchCaseSyntax("case let .\(trivia.enumCaseName)(text):") {
              ExprSyntax("self = .\(trivia.enumCaseName)(String(syntaxText: text))")
            }
          }
        }
      }
    }
  }

  try! ExtensionDeclSyntax("extension RawTriviaPiece") {
    try VariableDeclSyntax("public var byteLength: Int") {
      try SwitchExprSyntax("switch self") {
        for trivia in TRIVIAS {
          if trivia.isCollection {
            SwitchCaseSyntax("case let .\(trivia.enumCaseName)(count):") {
              if trivia.charactersLen != 1 {
                StmtSyntax("return count * \(raw: trivia.charactersLen)")
              } else {
                StmtSyntax("return count")
              }
            }
          } else {
            SwitchCaseSyntax("case let .\(trivia.enumCaseName)(text):") {
              StmtSyntax("return text.count")
            }
          }
        }
      }
    }

    try VariableDeclSyntax("var storedText: SyntaxText?") {
      try SwitchExprSyntax("switch self") {
        for trivia in TRIVIAS {
          if trivia.isCollection {
            SwitchCaseSyntax("case .\(trivia.enumCaseName)(_):") {
              StmtSyntax("return nil")
            }
          } else {
            SwitchCaseSyntax("case .\(trivia.enumCaseName)(let text):") {
              StmtSyntax("return text")
            }
          }
        }
      }
    }
  }

  try! generateIsHelpers(for: "TriviaPiece")

  try! generateIsHelpers(for: "RawTriviaPiece")
}

fileprivate func generateIsHelpers(for pieceName: TokenSyntax) throws -> ExtensionDeclSyntax {
  return try ExtensionDeclSyntax("extension \(pieceName)") {
    DeclSyntax(
      """
      /// Returns `true` if this piece is a newline, space or tab.
      public var isWhitespace: Bool {
        return isSpaceOrTab || isNewline
      }
      """
    )

    try VariableDeclSyntax("public var isNewline: Bool") {
      try SwitchExprSyntax("switch self") {
        for trivia in TRIVIAS {
          if trivia.isNewLine {
            SwitchCaseSyntax("case .\(trivia.enumCaseName):") {
              StmtSyntax("return true")
            }
          }
        }
        SwitchCaseSyntax("default:") {
          StmtSyntax("return false")
        }
      }
    }

    DeclSyntax(
      """
      public var isSpaceOrTab: Bool {
        switch self {
        case .spaces:
          return true
        case .tabs:
          return true
        default:
          return false
        }
      }
      """
    )

    DeclSyntax(
      """
      /// Returns `true` if this piece is a comment.
      public var isComment: Bool {
        switch self {
        case .lineComment, .blockComment, .docLineComment, .docBlockComment:
          return true
        default:
          return false
        }
      }
      """
    )
  }
}
