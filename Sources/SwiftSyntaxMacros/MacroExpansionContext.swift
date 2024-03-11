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

#if swift(>=6)
public import SwiftDiagnostics
public import SwiftSyntax
import SwiftSyntaxBuilder
#else
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
#endif

/// Interface to extract information about the context in which a given
/// macro is expanded.
public protocol MacroExpansionContext: AnyObject {
  /// Generate a unique name for use in the macro.
  ///
  /// - Parameters:
  ///   - name: The name to use as a basis for the uniquely-generated name,
  ///     which will appear in the unique name that's produced here.
  ///
  /// - Returns: an identifier token containing a unique name that will not
  ///   conflict with any other name in a well-formed program.
  func makeUniqueName(_ name: String) -> TokenSyntax

  /// Produce a diagnostic while expanding the macro.
  func diagnose(_ diagnostic: Diagnostic)

  /// Retrieve a source location for the given syntax node.
  ///
  /// - Parameters:
  ///   - node: The syntax node whose source location to produce.
  ///   - position: The position within the syntax node for the resulting
  ///     location.
  ///   - filePathMode: How the file name contained in the source location is
  ///     formed.
  ///
  /// - Returns: the source location within the given node, or `nil` if the
  ///   given syntax node is not rooted in a source file that the macro
  ///   expansion context knows about.
  func location(
    of node: some SyntaxProtocol,
    at position: PositionInSyntaxNode,
    filePathMode: SourceLocationFilePathMode
  ) -> AbstractSourceLocation?

  /// Return an array of enclosing lexical contexts for the purpose of macros,
  /// starting from the syntax node at which the macro expansion occurs
  /// and containing all "context" nodes including functions, closures, types,
  /// properties, subscripts, and extensions.
  ///
  /// Lexical contexts will have many of their details stripped out to prevent
  /// macros from having visibility into unrelated code. For example, functions
  /// and closures have their bodies removed, types and extensions have their
  /// member lists emptied, and properties and subscripts have their accessor
  /// blocks removed.
  ///
  /// The first entry in the array is the innermost context. For attached
  /// macros, this is often the declaration to which the macro is attached.
  /// This array can be empty if there is no context, for example when a
  /// freestanding macro is used at file scope.
  var lexicalContext: [Syntax] { get }
}

extension MacroExpansionContext {
  /// Retrieve a source location for the given syntax node's starting token
  /// (after leading trivia) using file naming according to `#fileID`.
  ///
  /// - Parameters:
  ///   - node: The syntax node whose source location to produce.
  ///
  /// - Returns: the source location within the given node, or `nil` if the
  ///   given syntax node is not rooted in a source file that the macro
  ///   expansion context knows about.
  public func location(
    of node: some SyntaxProtocol
  ) -> AbstractSourceLocation? {
    return location(of: node, at: .afterLeadingTrivia, filePathMode: .fileID)
  }

  public var lexicalContext: [Syntax] {
    fatalError(
      "`MacroExpansionContext` conformance must implement `lexicalContext`"
    )
  }
}

/// Diagnostic message used for thrown errors.
private struct ThrownErrorDiagnostic: DiagnosticMessage {
  let message: String

  var severity: DiagnosticSeverity { .error }

  var diagnosticID: MessageID {
    .init(domain: "SwiftSyntaxMacros", id: "ThrownErrorDiagnostic")
  }
}

extension MacroExpansionContext {
  /// Adds diagnostics from the error thrown during a macro expansion.
  public func addDiagnostics(from error: Error, node: some SyntaxProtocol) {
    // Inspect the error to form an appropriate set of diagnostics.
    var diagnostics: [Diagnostic]
    if let diagnosticsError = error as? DiagnosticsError {
      diagnostics = diagnosticsError.diagnostics
    } else if let message = error as? DiagnosticMessage {
      diagnostics = [Diagnostic(node: Syntax(node), message: message)]
    } else if let error = error as? SyntaxStringInterpolationInvalidNodeTypeError {
      let diagnostic = Diagnostic(node: Syntax(node), message: ThrownErrorDiagnostic(message: "Internal macro error: \(error.description)"))
      diagnostics = [diagnostic]
    } else {
      diagnostics = [Diagnostic(node: Syntax(node), message: ThrownErrorDiagnostic(message: String(describing: error)))]
    }

    // Emit the diagnostics.
    for diagnostic in diagnostics {
      diagnose(diagnostic)
    }

    // Handle possibility that none of the diagnostics was an error.
    if !diagnostics.contains(
      where: { $0.diagMessage.severity == .error }
    ) {
      diagnose(
        Diagnostic(
          node: Syntax(node),
          message: ThrownErrorDiagnostic(
            message: "macro expansion failed without generating an error"
          )
        )
      )
    }
  }
}

/// Describe the position within a syntax node that can be used to compute
/// source locations.
public enum PositionInSyntaxNode {
  /// Refers to the start of the syntax node's leading trivia, which is
  /// the first source location covered by the syntax node.
  case beforeLeadingTrivia

  /// Refers to the start of the syntax node's first token, which
  /// immediately follows the leading trivia.
  case afterLeadingTrivia

  /// Refers to the end of the syntax node's last token, right before the
  /// trailing trivia.
  case beforeTrailingTrivia

  /// Refers just past the end of the source text that is covered by the
  /// syntax node, after all trailing trivia.
  case afterTrailingTrivia
}

/// Describes the source location file path
public enum SourceLocationFilePathMode {
  /// A file ID consisting of the module name and file name (without full path),
  /// as would be generated by the macro expansion `#fileID`.
  case fileID

  /// A full path name as would be generated by the macro expansion `#filePath`,
  /// e.g., `/home/taylor/alison.swift`.
  case filePath
}
