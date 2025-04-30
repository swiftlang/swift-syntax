//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if compiler(>=6)
internal import SwiftDiagnostics
internal import SwiftSyntax
#else
import SwiftDiagnostics
import SwiftSyntax
#endif

/// Errors in macro handing.
enum MacroExpansionError {
  case macroTypeNotFound(PluginMessage.MacroReference)
  case freestandingMacroSyntaxIsNotMacro
  case invalidExpansionMessage
  case invalidMacroRole(PluginMessage.MacroRole)
}

extension MacroExpansionError: DiagnosticMessage {
  var message: String {
    switch self {
    case .macroTypeNotFound(let ref):
      return "macro type '\(ref.moduleName).\(ref.typeName)' not found when expanding macro '\(ref.name)'"

    case .freestandingMacroSyntaxIsNotMacro:
      return "macro syntax couldn't be parsed"

    case .invalidExpansionMessage:
      return "internal message error; please file a bug report"

    case .invalidMacroRole(let role):
      return "invalid macro role '\(role)' for expansion"
    }
  }
  var diagnosticID: SwiftDiagnostics.MessageID {
    .init(domain: "SwiftCompilerPlugin", id: "\(type(of: self)).\(self)")
  }
  var severity: SwiftDiagnostics.DiagnosticSeverity {
    .error
  }
}

extension MacroExpansionError: Error {}

extension PluginMessage.Diagnostic.Severity {
  init(from syntaxDiagSeverity: SwiftDiagnostics.DiagnosticSeverity) {
    switch syntaxDiagSeverity {
    case .error: self = .error
    case .warning: self = .warning
    case .note: self = .note
    case .remark: self = .remark
    #if RESILIENT_LIBRARIES
    @unknown default: fatalError()
    #endif
    }
  }
}

extension PluginMessage.Diagnostic {
  init(from syntaxDiag: SwiftDiagnostics.Diagnostic, in sourceManager: SourceManager) {
    if let position = sourceManager.position(
      of: syntaxDiag.node,
      at: .afterLeadingTrivia
    ) {
      self.position = .init(fileName: position.fileName, offset: position.utf8Offset)
    } else {
      self.position = .invalid
    }

    self.severity = .init(from: syntaxDiag.diagMessage.severity)
    self.message = syntaxDiag.message

    self.highlights = syntaxDiag.highlights.compactMap {
      guard let range = sourceManager.range(of: $0) else {
        return nil
      }
      return .init(
        fileName: range.fileName,
        startOffset: range.startUTF8Offset,
        endOffset: range.endUTF8Offset
      )
    }

    self.notes = syntaxDiag.notes.compactMap {
      guard let pos = sourceManager.position(of: $0.node, at: .afterLeadingTrivia) else {
        return nil
      }
      let position = PluginMessage.Diagnostic.Position(
        fileName: pos.fileName,
        offset: pos.utf8Offset
      )
      return .init(position: position, message: $0.message)
    }

    self.fixIts = syntaxDiag.fixIts.compactMap {
      PluginMessage.Diagnostic.FixIt(
        message: $0.message.message,
        changes: $0.changes.compactMap {
          let range: SourceManager.SourceRange?
          let text: String
          switch $0 {
          case .replace(let oldNode, let newNode):
            // Replace the whole node including leading/trailing trivia, but if
            // the trivia are the same, don't include them in the replacing range.
            let leadingMatch = oldNode.leadingTrivia == newNode.leadingTrivia
            let trailingMatch = oldNode.trailingTrivia == newNode.trailingTrivia
            range = sourceManager.range(
              of: oldNode,
              from: leadingMatch ? .afterLeadingTrivia : .beforeLeadingTrivia,
              to: trailingMatch ? .beforeTrailingTrivia : .afterTrailingTrivia
            )
            var newNode = newNode.detached
            if leadingMatch {
              newNode.leadingTrivia = []
            }
            if trailingMatch {
              newNode.trailingTrivia = []
            }
            text = newNode.description
          case .replaceLeadingTrivia(let token, let newTrivia):
            guard token.leadingTrivia != newTrivia else {
              return nil
            }
            range = sourceManager.range(
              of: Syntax(token),
              from: .beforeLeadingTrivia,
              to: .afterLeadingTrivia
            )
            text = newTrivia.description
          case .replaceTrailingTrivia(let token, let newTrivia):
            guard token.trailingTrivia != newTrivia else {
              return nil
            }
            range = sourceManager.range(
              of: Syntax(token),
              from: .beforeTrailingTrivia,
              to: .afterTrailingTrivia
            )
            text = newTrivia.description
          case .replaceChild(let replaceChildData):
            range = sourceManager.range(replaceChildData.replacementRange, in: replaceChildData.parent)
            text = replaceChildData.newChild.description
          case .replaceText(
            range: let replacementRange,
            with: let newText,
            in: let syntax
          ):
            range = sourceManager.range(replacementRange, in: syntax)
            text = newText
          #if RESILIENT_LIBRARIES
          @unknown default:
            fatalError()
          #endif
          }
          guard let range else {
            return nil
          }
          return .init(
            range: PositionRange(
              fileName: range.fileName,
              startOffset: range.startUTF8Offset,
              endOffset: range.endUTF8Offset
            ),
            newText: text
          )
        }
      )
    }
  }
}
