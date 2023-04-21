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
    /// a `Trivia` collection.
    ///
    /// For example, four spaces would be represented by
    /// `.spaces(4)`
    ///
    /// In general, you should deal with the actual Trivia collection instead
    /// of individual pieces whenever possible.
    public enum TriviaPiece
    """
  ) {
    for trivia in TRIVIAS {
      if trivia.isCollection {
        DeclSyntax(
          """
          /// \(raw: trivia.comment)
          case \(raw: trivia.enumCaseName)(Int)
          """
        )

      } else {
        DeclSyntax(
          """
          /// \(raw: trivia.comment)
          case \(raw: trivia.enumCaseName)(String)
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
      public func write<Target>(to target: inout Target) where Target: TextOutputStream
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
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(count):") {
              ExprSyntax("printRepeated(\(literal: joined), count: count)")
            }
          } else {
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(text):") {
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
            SwitchCaseSyntax("case .\(raw: trivia.enumCaseName)(let data):") {
              StmtSyntax(#"return "\#(raw: trivia.enumCaseName)(\(data))""#)
            }
          } else {
            SwitchCaseSyntax("case .\(raw: trivia.enumCaseName)(let name):") {
              StmtSyntax(#"return "\#(raw: trivia.enumCaseName)(\(name.debugDescription))""#)
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
          public static func \(raw: trivia.enumCaseName)(_ count: Int) -> Trivia {
            return [.\(raw: trivia.enumCaseName)(count)]
          }
          """
        )

        DeclSyntax(
          """
          /// Gets a piece of trivia for \(literal: joined) characters.
          public static var \(raw: trivia.lowerName): Trivia {
            return .\(raw: trivia.enumCaseName)(1)
          }
          """
        )

      } else {
        DeclSyntax(
          """
          /// Returns a piece of trivia for \(raw: trivia.name).
          public static func \(raw: trivia.enumCaseName)(_ text: String) -> Trivia {
            return [.\(raw: trivia.enumCaseName)(text)]
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
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(count):") {
              if trivia.charactersLen != 1 {
                StmtSyntax("return SourceLength(utf8Length: count * \(raw: trivia.charactersLen))")
              } else {
                StmtSyntax("return SourceLength(utf8Length: count)")
              }
            }
          } else {
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(text):") {
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
    /// In contrast to `TriviaPiece`, a `RawTriviaPiece` does not own the source
    /// text of a the trivia.
    @_spi(RawSyntax)
    public enum RawTriviaPiece: Equatable
    """
  ) {
    for trivia in TRIVIAS {
      if trivia.isCollection {
        DeclSyntax("case \(raw: trivia.enumCaseName)(Int)")

      } else {
        DeclSyntax("case \(raw: trivia.enumCaseName)(SyntaxText)")
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
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(count):") {
              StmtSyntax("return .\(raw: trivia.enumCaseName)(count)")
            }
          } else {
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(text):") {
              StmtSyntax("return .\(raw: trivia.enumCaseName)(arena.intern(text))")
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
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(count):") {
              ExprSyntax("self = .\(raw: trivia.enumCaseName)(count)")
            }
          } else {
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(text):") {
              ExprSyntax("self = .\(raw: trivia.enumCaseName)(String(syntaxText: text))")
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
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(count):") {
              if trivia.charactersLen != 1 {
                StmtSyntax("return count * \(raw: trivia.charactersLen)")
              } else {
                StmtSyntax("return count")
              }
            }
          } else {
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(text):") {
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
            SwitchCaseSyntax("case .\(raw: trivia.enumCaseName)(_):") {
              StmtSyntax("return nil")
            }
          } else {
            SwitchCaseSyntax("case .\(raw: trivia.enumCaseName)(let text):") {
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

fileprivate func generateIsHelpers(for pieceName: String) throws -> ExtensionDeclSyntax {
  return try ExtensionDeclSyntax("extension \(raw: pieceName)") {
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
            SwitchCaseSyntax("case .\(raw: trivia.enumCaseName):") {
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
  }
}
