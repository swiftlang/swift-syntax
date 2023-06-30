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

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros

/// An implementation of the `MacroExpansionContext` protocol that is
/// suitable for testing purposes.
public class BasicMacroExpansionContext {
  /// A single source file that is known to the macro expansion context.
  public struct KnownSourceFile {
    /// The name of the module in which this source file resides.
    let moduleName: String

    /// The full path to the file.
    let fullFilePath: String

    public init(moduleName: String, fullFilePath: String) {
      self.moduleName = moduleName
      self.fullFilePath = fullFilePath
    }
  }

  /// Create a new macro evaluation context.
  public init(
    expansionDiscriminator: String = "__macro_local_",
    sourceFiles: [SourceFileSyntax: KnownSourceFile] = [:]
  ) {
    self.expansionDiscriminator = expansionDiscriminator
    self.sourceFiles = sourceFiles
  }

  /// The set of diagnostics that were emitted as part of expanding the
  /// macro.
  public private(set) var diagnostics: [Diagnostic] = []

  /// Mapping from the root source file syntax nodes to the known source-file
  /// information about that source file.
  private var sourceFiles: [SourceFileSyntax: KnownSourceFile] = [:]

  /// Mapping from intentionally-disconnected syntax node roots to the
  /// absolute offsets that have within a given source file, which is used
  /// to establish the link between a node that been intentionally disconnected
  /// from a source file to hide information from the macro implementation.
  private var disconnectedNodes: [Syntax: (SourceFileSyntax, Int)] = [:]

  /// The macro expansion discriminator, which is used to form unique names
  /// when requested.
  ///
  /// The expansion discriminator is combined with the `uniqueNames` counters
  /// to produce unique names.
  private var expansionDiscriminator: String = ""

  /// Counter for each of the uniqued names.
  ///
  /// Used in conjunction with `expansionDiscriminator`.
  private var uniqueNames: [String: Int] = [:]

}

extension BasicMacroExpansionContext {
  /// Note that the given node that was at the given position in the provided
  /// source file has been disconnected and is now a new root.
  private func addDisconnected(
    _ node: some SyntaxProtocol,
    at offset: AbsolutePosition,
    in sourceFile: SourceFileSyntax
  ) {
    disconnectedNodes[Syntax(node)] = (sourceFile, offset.utf8Offset)
  }

  /// Detach the given node, and record where it came from.
  public func detach<Node: SyntaxProtocol>(_ node: Node) -> Node {
    let detached = node.detach()

    if let rootSourceFile = node.root.as(SourceFileSyntax.self) {
      addDisconnected(detached, at: node.position, in: rootSourceFile)
    }

    return detached
  }
}

extension String {
  /// Retrieve the base name of a string that represents a path, removing the
  /// directory.
  fileprivate var basename: String {
    guard let lastSlash = lastIndex(of: "/") else {
      return self
    }

    return String(self[index(after: lastSlash)...])
  }

}
extension BasicMacroExpansionContext: MacroExpansionContext {
  /// Generate a unique name for use in the macro.
  public func makeUniqueName(_ providedName: String) -> TokenSyntax {
    // If provided with an empty name, substitute in something.
    let name = providedName.isEmpty ? "__local" : providedName

    // Grab a unique index value for this name.
    let uniqueIndex = uniqueNames[name, default: 0]
    uniqueNames[name] = uniqueIndex + 1

    // Start with the expansion discriminator.
    var resultString = expansionDiscriminator

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

  public func location(
    of node: some SyntaxProtocol,
    at position: PositionInSyntaxNode,
    filePathMode: SourceLocationFilePathMode
  ) -> AbstractSourceLocation? {
    // Dig out the root source file and figure out how we need to adjust the
    // offset of the given syntax node to adjust for it.
    let rootSourceFile: SourceFileSyntax
    let offsetAdjustment: Int
    if let directRootSourceFile = node.root.as(SourceFileSyntax.self) {
      // The syntax node came from the source file itself.
      rootSourceFile = directRootSourceFile
      offsetAdjustment = 0
    } else if let (adjustedSourceFile, offset) = disconnectedNodes[Syntax(node)] {
      // The syntax node came from a disconnected root, so adjust for that.
      rootSourceFile = adjustedSourceFile
      offsetAdjustment = offset
    } else {
      return nil
    }

    guard let knownRoot = sourceFiles[rootSourceFile] else {
      return nil
    }

    // Determine the filename to use in the resulting location.
    let fileName: String
    switch filePathMode {
    case .fileID:
      fileName = "\(knownRoot.moduleName)/\(knownRoot.fullFilePath.basename)"

    case .filePath:
      fileName = knownRoot.fullFilePath
    }

    // Find the node's offset relative to its root.
    let rawPosition: AbsolutePosition
    switch position {
    case .beforeLeadingTrivia:
      rawPosition = node.position

    case .afterLeadingTrivia:
      rawPosition = node.positionAfterSkippingLeadingTrivia

    case .beforeTrailingTrivia:
      rawPosition = node.endPositionBeforeTrailingTrivia

    case .afterTrailingTrivia:
      rawPosition = node.endPosition
    }

    // Do the location lookup.
    let converter = SourceLocationConverter(file: fileName, tree: rootSourceFile)
    return AbstractSourceLocation(converter.location(for: rawPosition.advanced(by: offsetAdjustment)))
  }
}
