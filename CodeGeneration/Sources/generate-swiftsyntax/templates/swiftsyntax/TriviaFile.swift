//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
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

let triviaFile = SourceFileSyntax(leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntax"))) {
  EnumDeclSyntax("""
    public enum TriviaPosition {
      case leading
      case trailing
    }
    """)

  EnumDeclSyntax("""
    /// A contiguous stretch of a single kind of trivia. The constituent part of
    /// a `Trivia` collection.
    ///
    /// For example, four spaces would be represented by
    /// `.spaces(4)`
    ///
    /// In general, you should deal with the actual Trivia collection instead
    /// of individual pieces whenever possible.
    public enum TriviaPiece
    """) {
    for trivia in TRIVIAS {
      if trivia.isCollection {
        EnumCaseDeclSyntax("""
          /// \(raw: trivia.comment)
          case \(raw: trivia.enumCaseName)(Int)
          """)

      } else {
        EnumCaseDeclSyntax("""
          /// \(raw: trivia.comment)
          case \(raw: trivia.enumCaseName)(String)
          """)
      }
    }
  }

  ExtensionDeclSyntax("extension TriviaPiece: TextOutputStreamable") {
    FunctionDeclSyntax("""
      /// Prints the provided trivia as they would be written in a source file.
      ///
      /// - Parameter stream: The stream to which to print the trivia.
      public func write<Target>(to target: inout Target) where Target: TextOutputStream
      """) {
      FunctionDeclSyntax("""
        func printRepeated(_ character: String, count: Int) {
          for _ in 0..<count { target.write(character) }
        }
        """)

      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        for trivia in TRIVIAS {
          if trivia.isCollection {
            let joined = trivia.characters.map { "\($0)" }.joined()
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(count):") {
              FunctionCallExprSyntax("printRepeated(\(literal: joined), count: count)")
            }
          } else {
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(text):") {
              FunctionCallExprSyntax("target.write(text)")
            }
          }
        }
      }
    }
  }

  ExtensionDeclSyntax("extension TriviaPiece: CustomDebugStringConvertible") {
    VariableDeclSyntax(
      leadingTrivia: .docLineComment("/// Returns a description used by dump.") + .newline,
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("debugDescription"),
      type: TypeAnnotationSyntax(type: TypeSyntax("String"))) {
        SwitchStmtSyntax(expression: ExprSyntax("self")) {
          for trivia in TRIVIAS {
            if trivia.isCollection {
              SwitchCaseSyntax("case .\(raw: trivia.enumCaseName)(let data):") {
                ReturnStmtSyntax(#"return "\#(raw: trivia.enumCaseName)(\(data))""#)
              }
            } else {
              SwitchCaseSyntax("case .\(raw: trivia.enumCaseName)(let name):") {
                ReturnStmtSyntax(#"return "\#(raw: trivia.enumCaseName)(\(name.debugDescription))""#)
              }
            }
          }
        }
      }
  }

  ExtensionDeclSyntax("""
    extension TriviaPiece {
      /// Returns true if the trivia is `.newlines`, `.carriageReturns` or `.carriageReturnLineFeeds`
      public var isNewline: Bool {
        switch self {
        case .newlines,
            .carriageReturns,
            .carriageReturnLineFeeds:
          return true
        default:
          return false
        }
      }
    }
    """)

  StructDeclSyntax("""
    /// A collection of leading or trailing trivia. This is the main data structure
    /// for thinking about trivia.
    public struct Trivia
    """) {
    VariableDeclSyntax("public let pieces: [TriviaPiece]")

    InitializerDeclSyntax("""
      /// Creates Trivia with the provided underlying pieces.
      public init<S: Sequence>(pieces: S) where S.Element == TriviaPiece {
        self.pieces = Array(pieces)
      }
      """)

    VariableDeclSyntax("""
      /// Creates Trivia with no pieces.
      public static var zero: Trivia {
        return Trivia(pieces: [])
      }
      """)

    VariableDeclSyntax("""
      /// Whether the Trivia contains no pieces.
      public var isEmpty: Bool {
        pieces.isEmpty
      }
      """)

    FunctionDeclSyntax("""
      /// Creates a new `Trivia` by appending the provided `TriviaPiece` to the end.
      public func appending(_ piece: TriviaPiece) -> Trivia {
        var copy = pieces
        copy.append(piece)
        return Trivia(pieces: copy)
      }
      """)

    VariableDeclSyntax("""
      public var sourceLength: SourceLength {
        return pieces.map({ $0.sourceLength }).reduce(.zero, +)
      }
      """)

    VariableDeclSyntax("""
      /// Get the byteSize of this trivia
      public var byteSize: Int {
        return sourceLength.utf8Length
      }
      """)

    for trivia in TRIVIAS {
      if trivia.isCollection {
        let joined = trivia.characters.map { "\($0)" }.joined()
        FunctionDeclSyntax("""
        /// Returns a piece of trivia for some number of \(literal: joined) characters.
        public static func \(raw: trivia.enumCaseName)(_ count: Int) -> Trivia {
          return [.\(raw: trivia.enumCaseName)(count)]
        }
        """)

        VariableDeclSyntax("""
        /// Gets a piece of trivia for \(literal: joined) characters.
        public static var \(raw: trivia.lowerName): Trivia {
          return .\(raw: trivia.enumCaseName)(1)
        }
        """)


      } else {
        FunctionDeclSyntax("""
        /// Returns a piece of trivia for \(raw: trivia.name).
        public static func \(raw: trivia.enumCaseName)(_ text: String) -> Trivia {
          return [.\(raw: trivia.enumCaseName)(text)]
        }
        """)
      }
    }
  }

  ExtensionDeclSyntax(#"""
    extension Trivia: CustomDebugStringConvertible {
      public var debugDescription: String {
        if count == 1, let first = first {
          return first.debugDescription
        }
        return "[" + map(\.debugDescription).joined(separator: ", ") + "]"
      }
    }
    """#)

  ExtensionDeclSyntax("extension Trivia: Equatable {}")

  ExtensionDeclSyntax("""
    /// Conformance for Trivia to the Collection protocol.
    extension Trivia: Collection {
      public var startIndex: Int {
        return pieces.startIndex
      }

      public var endIndex: Int {
        return pieces.endIndex
      }

      public func index(after i: Int) -> Int {
        return pieces.index(after: i)
      }

      public subscript(_ index: Int) -> TriviaPiece {
        return pieces[index]
      }
    }
    """)

  ExtensionDeclSyntax("""
    extension Trivia: ExpressibleByArrayLiteral {
      /// Creates Trivia from the provided pieces.
      public init(arrayLiteral elements: TriviaPiece...) {
        self.pieces = elements
      }
    }
    """)

  ExtensionDeclSyntax("""
    extension Trivia: TextOutputStreamable {
      /// Prints the provided trivia as they would be written in a source file.
      ///
      /// - Parameter stream: The stream to which to print the trivia.
      public func write<Target>(to target: inout Target)
      where Target: TextOutputStream {
        for piece in pieces {
          piece.write(to: &target)
        }
      }
    }
    """)

  ExtensionDeclSyntax("""
    extension Trivia: CustomStringConvertible {
      public var description: String {
        var description = ""
        self.write(to: &description)
        return description
      }
    }
    """)

  ExtensionDeclSyntax("""
    extension Trivia {
      /// Concatenates two collections of `Trivia` into one collection.
      public static func +(lhs: Trivia, rhs: Trivia) -> Trivia {
        return Trivia(pieces: lhs.pieces + rhs.pieces)
      }

      /// Concatenates two collections of `Trivia` into the left-hand side.
      public static func +=(lhs: inout Trivia, rhs: Trivia) {
        lhs = lhs + rhs
      }
    }
    """)

  ExtensionDeclSyntax("extension TriviaPiece: Equatable {}")

  ExtensionDeclSyntax("extension TriviaPiece") {
    VariableDeclSyntax(
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("sourceLength"),
      type: TypeAnnotationSyntax(type: TypeSyntax("SourceLength"))) {
        SwitchStmtSyntax(expression: ExprSyntax("self")) {
          for trivia in TRIVIAS {
            if trivia.isCollection {
              SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(count):") {
                if trivia.charactersLen != 1 {
                  ReturnStmtSyntax("return SourceLength(utf8Length: count * \(raw: trivia.charactersLen))")
                } else {
                  ReturnStmtSyntax("return SourceLength(utf8Length: count)")
                }
              }
            } else {
              SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(text):") {
                ReturnStmtSyntax("return SourceLength(of: text)")
              }
            }
          }
        }
      }
  }

  EnumDeclSyntax("""
    /// Trivia piece for token RawSyntax.
    ///
    /// In contrast to `TriviaPiece`, a `RawTriviaPiece` does not own the source
    /// text of a the trivia.
    @_spi(RawSyntax)
    public enum RawTriviaPiece: Equatable
    """) {
    for trivia in TRIVIAS {
      if trivia.isCollection {
        EnumCaseDeclSyntax(" case \(raw: trivia.enumCaseName)(Int)")

      } else {
        EnumCaseDeclSyntax("case \(raw: trivia.enumCaseName)(SyntaxText)")
      }
    }

    FunctionDeclSyntax("""
      static func make(_ piece: TriviaPiece, arena: SyntaxArena) -> RawTriviaPiece
      """) {
      SwitchStmtSyntax(expression: ExprSyntax("piece")) {
        for trivia in TRIVIAS {
          if trivia.isCollection {
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(count):") {
              ReturnStmtSyntax("return .\(raw: trivia.enumCaseName)(count)")
            }
          } else {
            SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(text):") {
              ReturnStmtSyntax("return .\(raw: trivia.enumCaseName)(arena.intern(text))")
            }
          }
        }
      }
    }
  }

  ExtensionDeclSyntax("""
    extension RawTriviaPiece: TextOutputStreamable {
      public func write<Target: TextOutputStream>(to target: inout Target) {
        TriviaPiece(raw: self).write(to: &target)
      }
    }
    """)

  ExtensionDeclSyntax("""
    extension RawTriviaPiece: CustomDebugStringConvertible {
      public var debugDescription: String {
        TriviaPiece(raw: self).debugDescription
      }
    }
    """)

  ExtensionDeclSyntax("extension TriviaPiece") {
    InitializerDeclSyntax("@_spi(RawSyntax) public init(raw: RawTriviaPiece)") {
      SwitchStmtSyntax(expression: ExprSyntax("raw")) {
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

  ExtensionDeclSyntax("extension RawTriviaPiece") {
    VariableDeclSyntax(
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("byteLength"),
      type: TypeAnnotationSyntax(type: TypeSyntax("Int"))) {
        SwitchStmtSyntax(expression: ExprSyntax("self")) {
          for trivia in TRIVIAS {
            if trivia.isCollection {
              SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(count):") {
                if trivia.charactersLen != 1 {
                  ReturnStmtSyntax("return count * \(raw: trivia.charactersLen)")
                } else {
                  ReturnStmtSyntax("return count")
                }
              }
            } else {
              SwitchCaseSyntax("case let .\(raw: trivia.enumCaseName)(text):") {
                ReturnStmtSyntax("return text.count")
              }
            }
          }
        }
      }

    VariableDeclSyntax(
      name: IdentifierPatternSyntax("storedText"),
      type: TypeAnnotationSyntax(type: OptionalTypeSyntax("SyntaxText?"))) {
        SwitchStmtSyntax(expression: ExprSyntax("self")) {
          for trivia in TRIVIAS {
            if trivia.isCollection {
              SwitchCaseSyntax("case .\(raw: trivia.enumCaseName)(_):") {
                ReturnStmtSyntax("return nil")
              }
            } else {
              SwitchCaseSyntax("case .\(raw: trivia.enumCaseName)(let text):") {
                ReturnStmtSyntax("return text")
              }
            }
          }
        }
      }
  }

  ExtensionDeclSyntax("""
    extension RawTriviaPiece {
      /// Returns true if the trivia is `.newlines`, `.carriageReturns` or `.carriageReturnLineFeeds`
      public var isNewline: Bool {
        switch self {
        case .newlines,
            .carriageReturns,
            .carriageReturnLineFeeds:
          return true
        default:
          return false
        }
      }
    }
    """)
}
