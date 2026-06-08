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
@_spi(_QualifiedLookup) @_spi(Experimental) import SwiftLexicalLookup
import SwiftParser
import SwiftSyntax
import XCTest

/// Source code annotated with qualified-lookup expectations.
///
/// Examples at `assertTypeMemberLookup` documentation.
struct QualifiedLookupSource: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
  /// An expectation describes the lookup parameters that should surfaces the attached
  /// declaration at qualified lookup. It also includes source location for better
  /// diagnostics during testing.
  ///
  /// For example:
  ///   """
  ///   class A {
  ///     \(.deinit()) //   searching for the name `*deinit*` should surface
  ///     deinit {}    //<- this declaration
  ///   }
  ///   """
  ///
  /// Most ways to create a lookup expectation are wrappers around ``DeclNameRef``.
  /// The default ``memberKind`` looks only for instance members. So --for now--
  /// the only way to modify ``memberKind`` is to adding `.static()`, e.g.:
  ///   """
  ///   struct A {
  ///     static \(.named("f", args: []).static()) func f() {}
  ///   }
  ///   """
  struct DeclLookupExpectation {
    /// The name of the declaration for which to look, or `nil` if invalid.
    ///
    /// It's set to `nil` if  the test uses an invalid declaration name (which
    /// we diagnose when initializing `DeclLookupExpectation`)
    let declRef: DeclNameRef?
    /// The kind of members we request during lookup
    var memberKind: MemberKind
    // Source location where this expectation was created
    let file: StaticString
    let line: UInt

    /// Try to parse the given string as an identifier token. Creates XCT assertion failure
    /// and throws upon failure
    static func _parseIdentifier(_ tokenString: StaticString, file: StaticString, line: UInt) throws -> Identifier {
      struct InvalidIdentifierFailure: Error {}

      // let token = TokenSyntax(stringLiteral: tokenString)
      let tokens = Array(ExprSyntax(stringLiteral: tokenString.description).tokens(viewMode: .all))
      guard tokens.count == 1, let token = tokens.first else {
        XCTFail(
          "Invalid expectation identifier; expected one token but got three tokens instead '\(tokens.map(\.tokenKind))'",
          file: file,
          line: line
        )
        throw InvalidIdentifierFailure()

      }
      guard Identifier(validating: token) != nil else {
        XCTFail(
          "Invalid expectation token; expected identifier or dollar identifier but got token kind '\(token.tokenKind)' instead.",
          file: file,
          line: line
        )
        throw InvalidIdentifierFailure()
      }
      // TODO: Handle `identifier`-style "non-canonical" identifiers, e.g., "`myID`" or "`init`"
      let identifier = Identifier(canonicalName: tokenString)

      // Construct identifier through static string because we can't use a string
      // that's not in the syntax tree
      return identifier
    }

    /// Creates a raw ``DeclNameRef`` using ``memberKind`` for lookup.
    /// You can use other static functions in ``DeclLookupExpectation`` for convenience.
    static func decl(
      exact ref: DeclNameRef,
      memberKind: MemberKind = .default,
      file: StaticString = #file,
      line: UInt = #line
    ) -> DeclLookupExpectation {
      DeclLookupExpectation(declRef: ref, memberKind: memberKind, file: file, line: line)
    }

    private static func _failedInit(file: StaticString, line: UInt) -> DeclLookupExpectation {
      DeclLookupExpectation(declRef: nil, memberKind: .default, file: file, line: line)
    }

    /// Corresponds to a non-macro ``DeclNameRef/identifier``
    static func named(
      _ name: StaticString,
      args optionalArgs: [StaticString?]? = nil,
      file: StaticString = #file,
      line: UInt = #line
    ) -> DeclLookupExpectation {
      do {
        return try .decl(
          exact: DeclNameRef(
            baseName: .identifier(
              identifier: _parseIdentifier(name, file: file, line: line),
              args: optionalArgs?.map({ (argName: StaticString?) -> Identifier? in
                try argName.map({ try _parseIdentifier($0, file: file, line: line) })
              })
            )
          ),
          file: file,
          line: line
        )
      } catch {
        return ._failedInit(file: file, line: line)
      }
    }
    // TODO: Add macro version

    /// Corresponds to ``DeclNameRef/deinit``
    static func `deinit`(
      file: StaticString = #file,
      line: UInt = #line
    ) -> DeclLookupExpectation {
      return .decl(
        exact: DeclNameRef(
          baseName: .deinit
        ),
        file: file,
        line: line
      )
    }

    /// Creates an ``DeclNameRef/`init```. Automatically configures lookup to
    /// look for static declarations.
    static func `init`(
      _ optionalArgs: [StaticString?]?,
      file: StaticString = #file,
      line: UInt = #line
    ) -> DeclLookupExpectation {
      do {
        return try .decl(
          exact: DeclNameRef(
            baseName: .`init`(
              args: optionalArgs?.map({ (argName: StaticString?) -> Identifier? in
                try argName.map({ try _parseIdentifier($0, file: file, line: line) })
              })
            )
          ),
          memberKind: .includeAllMembers,
          file: file,
          line: line
        )
      } catch {
        return ._failedInit(file: file, line: line)
      }
    }
    /// Corresponds to ``DeclNameRef/unnamedCall``
    static func unnamed(
      _ args: [StaticString],
      file: StaticString = #file,
      line: UInt = #line
    ) -> DeclLookupExpectation {
      do {
        return try .decl(
          exact: DeclNameRef(
            baseName: .unnamedCall(
              args: args.map({
                try Optional(_parseIdentifier($0, file: file, line: line))
              })
            )
          ),
          file: file,
          line: line
        )
      } catch {
        return ._failedInit(file: file, line: line)
      }
    }

    /// Corresponds to ``DeclNameRef/subscript``
    static func `subscript`(
      _ args: [StaticString],
      file: StaticString = #file,
      line: UInt = #line
    ) -> DeclLookupExpectation {
      do {
        return try .decl(
          exact: DeclNameRef(
            baseName: .subscript(
              args: args.map({
                try Optional(_parseIdentifier($0, file: file, line: line))
              })
            )
          ),
          file: file,
          line: line
        )
      } catch {
        return ._failedInit(file: file, line: line)
      }
    }

    /// Looks only for static declarations.
    func `static`() -> DeclLookupExpectation {
      var copy = self
      copy.memberKind = .includeStatic
      return copy
    }
  }

  // ``QualifiedLookupSource`` consists of source code strings and
  // expectation components.
  enum Component {
    case str(String)
    case expectations([DeclLookupExpectation], file: StaticString, line: UInt)
  }

  // Syntactic sugar for listing expectations alongside source code.
  struct Interpolation: StringInterpolationProtocol {
    fileprivate var components: [Component]

    init(literalCapacity: Int, interpolationCount: Int) {
      components = []
    }
    mutating func appendLiteral(_ literal: String) {
      components.append(.str(literal))
    }
    mutating func appendInterpolation(
      _ expectations: DeclLookupExpectation...,
      file: StaticString = #file,
      line: UInt = #line
    ) {
      components.append(.expectations(expectations, file: file, line: line))
    }
  }

  /// The source with all markers removed
  let source: String
  /// A map from positions in the string to a list of expectations for the declaration at that location.
  let positionsToExpectations: [String.Index: (expectations: [DeclLookupExpectation], file: StaticString, line: UInt)]

  init(stringInterpolation: Interpolation) {
    var source = ""
    var positionsToExpectations = [
      String.Index: (expectations: [DeclLookupExpectation], file: StaticString, line: UInt)
    ]()
    for component in stringInterpolation.components {
      switch component {
      case .str(let str): source.append(str)
      case .expectations(let declExpectations, let file, let line):
        // Get the endIndex so we refer to the token after the expectation. E.g. with '\(.decl(exact: .deinit)) deinit {}'
        // we'll refer directly to the `deinit`.
        //
        // Diagnose existing expectation (we allow only one per source index)
        if let existingExpectation = positionsToExpectations[source.endIndex] {
          XCTFail(
            "[Lookup Failure] Second expectation for same source index is prohibited (original expectation at \(existingExpectation.file):\(existingExpectation.line))",
            file: file,
            line: line
          )
          continue
        }
        // Save expectation
        positionsToExpectations[source.endIndex] = (declExpectations, file: file, line: line)
      }
    }

    self.source = source
    self.positionsToExpectations = positionsToExpectations
  }

  init(stringLiteral value: String) {
    // Just use the interpolation initializer
    var interpolation = Interpolation(literalCapacity: 1, interpolationCount: 0)
    interpolation.appendLiteral(value)
    self.init(stringInterpolation: interpolation)
  }
}

final class TestQualifiedLookup: XCTestCase {
  /// Check each expectation annotation in the given `QualifiedLookupSource`
  /// source code gives the correct result.
  ///
  /// You can create a ``QualifiedLookupSource`` with a string literal, using
  /// string interpolation to add expectations for qualified-lookup. E.g.,
  ///   let source: QualifiedLookupSource = """
  ///   struct MyType {
  ///     var \(.named("a")) // <- looking up "a" in `MyType` should find this identifier pattern
  ///         a: Int
  ///   }
  ///   """
  ///
  /// You can usually copy and modify the existing examples. If you do something
  /// the assertion function doesn't like, you'll get a fairly specific
  /// test failure.
  ///
  /// However, here are some rules of thumb. Each expectation should be placed
  /// before a key token of the target syntax:
  /// a. For normal declarations, place the expectation before the main keyword:
  ///    """
  ///    \(.named("myfunc")
  ///      .named("myfunc", args: ["a"]))
  ///    func myfunc(a: Int)
  ///    """
  ///    Same for subscripts, types, etc.
  /// b. For identifier patterns (in variable decls) and enum elements (in case
  ///    declarations), this doesn't work, so prefer placing the expectation
  ///    before the actual name:
  ///    """
  ///    enum A {
  ///      case \(.named("a"))
  ///           a,
  ///           \(.named("b"))
  ///           b
  ///
  ///      var \(.names("myVar"))
  ///          myVar: Int { 1 }
  ///    }
  ///    """
  /// (These rules follow from the fact that we find the target value
  ///  declaration by getting the parent of the token after the expectation
  ///  and casting it to a `ValueDeclSyntax`.)
  ///
  /// Further, if you have multiple names for the same declarations, list them
  /// in the same interpolation (see
  /// ``QualifiedLookupSource/Interpolation/appendInterpolation``).
  ///
  /// To see exactly what expectations you can create, check out the static
  /// functions in ``DeclLookupExpectation``.
  func assertTypeMemberLookup(
    _ lookupSource: QualifiedLookupSource,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    var parser = Parser(lookupSource.source)
    let sourceFile = SourceFileSyntax.parse(from: &parser)

    /// IMPORTANT: Only use for `lookupSource.source` and `sourceFile`.
    func sourcePosition(of index: String.Index) -> AbsolutePosition {
      AbsolutePosition(
        utf8Offset: lookupSource.source.distance(
          from: lookupSource.source.startIndex,
          to: index
        )
      )
    }

    var sharedDeclGroup: DeclGroupSyntaxType? = nil
    struct Pair<A: Hashable, B: Hashable>: Hashable { let a: A, b: B }
    var namesToExpectations = [Pair<DeclNameRef, MemberKind>: [(ValueDeclSyntax, file: StaticString, line: UInt)]]()

    for (sourceIndex, (expectations, file, line)) in lookupSource.positionsToExpectations {
      // The assertion expects this to be an introducer token
      guard let introducerToken = sourceFile.token(at: sourcePosition(of: sourceIndex)) else {
        XCTFail(
          "[Internal Error] Unexpectedly couldn't find token for expectation.",
          file: file,
          line: line
        )
        continue
      }

      // We expect the parent to be a ValueDeclSyntax
      guard let valueDecl = introducerToken.parent?.as(ValueDeclSyntax.self) else {
        XCTFail(
          "Invalid expectation placement: The parent of the token after the expectation isn't a value declaration; instead got '\(String(reflecting: introducerToken.parent?.kind))'.",
          file: file,
          line: line
        )
        continue
      }

      // Find the implicit decl-group parent
      func declGroupParent(of syntax: Syntax) -> DeclGroupSyntaxType? {
        guard let parent = syntax.parent else { return nil }
        return parent.as(DeclGroupSyntaxType.self) ?? declGroupParent(of: parent)
      }
      guard let declGroup = declGroupParent(of: Syntax(valueDecl)) else {
        XCTFail(
          "Invalid expectation placement: No group-declaration parent for the tested value declaration '\(valueDecl.trimmed)'",
          file: file,
          line: line
        )
        continue
      }

      // Update and ensure everyone uses the same declGroup
      if sharedDeclGroup == nil {
        sharedDeclGroup = declGroup
      } else if let sharedDeclGroup, sharedDeclGroup.id != declGroup.id {
        XCTFail(
          "Only one group declaration allowed but found at least two with types '\(sharedDeclGroup.type?.trimmedDescription ?? "_"))' and '\(declGroup.type?.trimmedDescription ?? "_")' ('\(sharedDeclGroup.trimmedDescription)' and '\(declGroup.trimmedDescription)')",
          file: file,
          line: line
        )
      }

      // Register each expectation for the respective name
      for expectation in expectations {
        // Skip lookup if reference is undefined (diagnosed earlier)
        guard let name = expectation.declRef else { continue }

        // Register expectation for this name
        namesToExpectations[Pair(a: name, b: expectation.memberKind), default: []].append(
          (decl: valueDecl, file: expectation.file, line: expectation.line)
        )
      }
    }

    // Ensure we got at least one shared group
    guard let sharedDeclGroup else {
      XCTFail("No valid expectations found", file: file, line: line)
      return
    }

    // Perform lookup
    for (nameAndMemberKind, expectations) in namesToExpectations {
      let (name, memberKind) = (nameAndMemberKind.a, nameAndMemberKind.b)

      let foundDecls = sharedDeclGroup.findDirectMembers(
        name: name,
        kind: memberKind
      )

      // Cross out matched decls and diagnose unmatched
      var unmatchedDecls = Set(foundDecls)
      for (expectedDecl, file, line) in expectations {
        guard unmatchedDecls.contains(expectedDecl) else {
          XCTFail(
            "[Lookup Failure] Lookup `\(sharedDeclGroup.type?.trimmedDescription ?? "_")`/\(name.debugDescription) \(memberKind) didn't find expected declaration (name: \(expectedDecl.declName.debugDescription), kind: \(expectedDecl.kind), id: \(expectedDecl.id.hashValue)).",
            file: file,
            line: line
          )
          continue
        }
        // Cross out matched declarations
        unmatchedDecls.remove(expectedDecl)
      }

      // Diagnose unmatched
      for unmatchedDecl in unmatchedDecls {
        XCTFail(
          "[Lookup Failure] Lookup `\(sharedDeclGroup.type?.trimmedDescription ?? "_")`/\(name.debugDescription) \(memberKind) found unexpcted declarations (id: \(unmatchedDecl.id.hashValue)): ```\(unmatchedDecl.trimmedDescription)```",
          file: file,
          line: line
        )
      }
    }
  }

  func testCodeBlockSimpleCase() {
    assertTypeMemberLookup(
      """
      struct MyStruct {
        // Test variables with no args plus args (MyStruct could be callable)
        var \(.named("a"), .named("a", args: ["randomArg"]))a,
            \(.named("b"))b: Int

        \(.named("hello", args: []),
          .named("hello"))
        func hello() {}

        // Init can be referenced as <Type>.init, <Type>.init(), <Type>()
        \(.`init`([]),
          .`init`(nil),
          .unnamed([]).static())
        init() {}

        // References: <myValue>.callAsFunction, <myValue>.callAsFunction(), <myValue>()
        \(.named("callAsFunction", args: []),
          .named("callAsFunction"),
          .unnamed([]))
        func callAsFunction() {}

        // We assume the user meant static functions (diagnosed elsewhere)
        case \(.named("case1").static())
             case1,
             \(.named("case2", args: ["a"]).static())
             case2(a: Int)

        // When `callAsFunction` is static, it exhibits no special behavior
        static
        \(.named("callAsFunction", args: []).static())
        func callAsFunction () {}

        \(.deinit())
        deinit {}
      }
      """
    )
  }
}
