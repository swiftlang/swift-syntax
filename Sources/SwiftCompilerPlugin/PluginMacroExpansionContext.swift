//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
import SwiftParser
import SwiftOperators
import SwiftSyntax
import SwiftSyntaxMacros

/// Manages known source code combined with their filename/fileID. This can be
/// used to get line/column from a syntax node in the managed source code.
class SourceManager {
  class KnownSourceSyntax {
    struct Location {
      var offset: Int
      var line: Int
      var column: Int
      var fileID: String
      var fileName: String
    }

    let node: Syntax
    let location: Location

    init(node: Syntax, location: Location) {
      self.node = node
      self.location = location
    }

    /// Location converter to get line/column in the node.
    lazy var locationConverter: SourceLocationConverter = .init(
      file: self.location.fileName,
      tree: self.node
    )
  }

  struct SourcePosition {
    var fileName: String
    var utf8Offset: Int
  }

  struct SourceRange {
    var fileName: String
    var startUTF8Offset: Int
    var endUTF8Offset: Int
  }

  /// Syntax added by `add(_:)` method. Keyed by the `id` of the node.
  private var knownSourceSyntax: [Syntax.ID: KnownSourceSyntax] = [:]

  /// Convert syntax information to a `Syntax` node. The location informations
  /// are cached in the source manager to provide `location(of:)` et al.
  func add(_ syntaxInfo: PluginMessage.Syntax) -> Syntax {

    var node: Syntax
    var parser = Parser(syntaxInfo.source)
    switch syntaxInfo.kind {
    case .declaration:
      node = Syntax(DeclSyntax.parse(from: &parser))
    case .statement:
      node = Syntax(StmtSyntax.parse(from: &parser))
    case .expression:
      node = Syntax(ExprSyntax.parse(from: &parser))
    case .type:
      node = Syntax(TypeSyntax.parse(from: &parser))
    case .pattern:
      node = Syntax(PatternSyntax.parse(from: &parser))
    case .attribute:
      node = Syntax(AttributeSyntax.parse(from: &parser))
    }
    do {
      node = try OperatorTable.standardOperators.foldAll(node)
    } catch let error {
      // TODO: Error handling.
      fatalError(error.localizedDescription)
    }

    let location = KnownSourceSyntax.Location(
      offset: syntaxInfo.location.offset,
      line: syntaxInfo.location.line,
      column: syntaxInfo.location.column,
      fileID: syntaxInfo.location.fileID,
      fileName: syntaxInfo.location.fileName
    )

    knownSourceSyntax[node.id] = KnownSourceSyntax(node: node, location: location)

    return node
  }

  /// Get position (file name + offset) of `node` in the known root nodes.
  /// The root node of `node` must be one of the retured value from `add(_:)`.
  func position(
    of node: Syntax,
    at kind: PositionInSyntaxNode
  ) -> SourcePosition? {
    guard let base = self.knownSourceSyntax[node.root.id] else {
      return nil
    }
    let localPosition = node.position(at: kind)
    let positionOffset = base.location.offset
    return SourcePosition(
      fileName: base.location.fileName,
      utf8Offset: localPosition.advanced(by: positionOffset).utf8Offset
    )
  }

  /// Get position range of `node` in the known root nodes.
  /// The root node of `node` must be one of the retured value from `add(_:)`.
  func range(
    of node: Syntax,
    from startKind: PositionInSyntaxNode = .afterLeadingTrivia,
    to endKind: PositionInSyntaxNode = .beforeTrailingTrivia
  ) -> SourceRange? {
    guard let base = self.knownSourceSyntax[node.root.id] else {
      return nil
    }
    let localStartPosition = node.position(at: startKind)
    let localEndPosition = node.position(at: endKind)
    assert(localStartPosition <= localEndPosition)

    let positionOffset = base.location.offset

    return SourceRange(
      fileName: base.location.fileName,
      startUTF8Offset: localStartPosition.advanced(by: positionOffset).utf8Offset,
      endUTF8Offset: localEndPosition.advanced(by: positionOffset).utf8Offset
    )
  }

  /// Get location of `node` in the known root nodes.
  /// The root node of `node` must be one of the retured value from `add(_:)`.
  func location(of node: Syntax, at kind: PositionInSyntaxNode, filePathMode: SourceLocationFilePathMode) -> SourceLocation? {
    guard let base = self.knownSourceSyntax[node.root.id] else {
      return nil
    }
    let file: String
    switch filePathMode {
    case .fileID: file = base.location.fileID
    case .filePath: file = base.location.fileName
    }

    let localPosition = node.position(at: kind)
    let localLocation = base.locationConverter.location(for: localPosition)

    let positionOffset = base.location.offset
    let lineOffset = base.location.line - 1
    let columnOffset = localLocation.line == 1 ? base.location.column : 0

    return SourceLocation(
      line: localLocation.line! + lineOffset,
      column: localLocation.column! + columnOffset,
      offset: localLocation.offset + positionOffset,
      file: file
    )
  }
}

fileprivate extension Syntax {
  /// get a position in the node by `PositionInSyntaxNode`.
  func position(at pos: PositionInSyntaxNode) -> AbsolutePosition {
    switch pos {
    case .beforeLeadingTrivia:
      return self.position
    case .afterLeadingTrivia:
      return self.positionAfterSkippingLeadingTrivia
    case .beforeTrailingTrivia:
      return self.endPositionBeforeTrailingTrivia
    case .afterTrailingTrivia:
      return self.endPosition
    }
  }
}

class PluginMacroExpansionContext {
  /// The macro expansion discriminator, which is used to form unique names
  /// when requested.
  ///
  /// The expansion discriminator is combined with the `uniqueNames` counters
  /// to produce unique names.
  private var discriminator: String

  private var sourceManger: SourceManager

  /// Counter for each of the uniqued names.
  ///
  /// Used in conjunction with `expansionDiscriminator`.
  private var uniqueNames: [String: Int] = [:]

  /// The set of diagnostics that were emitted as part of expanding the
  /// macro.
  internal private(set) var diagnostics: [Diagnostic] = []

  init(sourceManager: SourceManager, discriminator: String = "") {
    self.sourceManger = sourceManager
    self.discriminator = discriminator
  }
}

extension PluginMacroExpansionContext: MacroExpansionContext {
  /// Generate a unique name for use in the macro.
  public func createUniqueName(_ providedName: String) -> TokenSyntax {
    // If provided with an empty name, substitute in something.
    let name = providedName.isEmpty ? "__local" : providedName

    // Grab a unique index value for this name.
    let uniqueIndex = uniqueNames[name, default: 0]
    uniqueNames[name] = uniqueIndex + 1

    // Start with the discriminator.
    var resultString = discriminator

    // Mangle the name
    resultString += "\(name.count)\(name)"

    // Mangle the operator for unique macro names.
    resultString += "fMu"

    // Mangle the index.
    if uniqueIndex > 0 {
      resultString += "\(uniqueIndex - 1)"
    }
    resultString += "_"

    return TokenSyntax(.identifier(resultString), presence: .present)
  }

  /// Produce a diagnostic while expanding the macro.
  public func diagnose(_ diagnostic: Diagnostic) {
    diagnostics.append(diagnostic)
  }

  public func location<Node: SyntaxProtocol>(
    of node: Node,
    at positionMode: PositionInSyntaxNode,
    filePathMode: SourceLocationFilePathMode
  ) -> SourceLocation? {
    return sourceManger.location(
      of: Syntax(node),
      at: positionMode,
      filePathMode: filePathMode
    )
  }
}
