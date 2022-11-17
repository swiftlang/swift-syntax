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
import SwiftParser
import SwiftDiagnostics
#if canImport(_CompilerPluginSupport)
import _CompilerPluginSupport
#endif

/// Describes a macro that is explicitly expanded as an expression.
public protocol ExpressionMacro: Macro {
  /// Evaluate a macro described by the given macro expansion expression
  /// within the given context to produce a replacement expression.
  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax>
}

#if canImport(_CompilerPluginSupport)
extension _CompilerPluginSupport._DiagnosticSeverity {
  fileprivate init(_ other: SwiftDiagnostics.DiagnosticSeverity) {
    switch other {
    case .note: self = .note
    case .warning: self = .warning
    case .error: self = .error
    }
  }
}

extension ExpressionMacro {
  public static func _kind() -> _CompilerPluginKind {
    .expressionMacro
  }

  public static func _rewrite(
    targetModuleName: UnsafePointer<UInt8>,
    targetModuleNameCount: Int,
    filePath: UnsafePointer<UInt8>,
    filePathCount: Int,
    sourceFileText: UnsafePointer<UInt8>,
    sourceFileTextCount: Int,
    localSourceText: UnsafePointer<UInt8>,
    localSourceTextCount: Int
  ) -> (code: UnsafePointer<UInt8>?, codeLength: Int,
        diagnostics: UnsafePointer<_Diagnostic>?,
        diagnosticCount: Int) {
    let targetModuleNameBuffer = UnsafeBufferPointer(
      start: filePath, count: targetModuleNameCount)
    let targetModuleName = String(
      decoding: targetModuleNameBuffer, as: UTF8.self)
    let filePathBuffer = UnsafeBufferPointer(
      start: filePath, count: filePathCount)
    let filePath = String(decoding: filePathBuffer, as: UTF8.self)
    let sourceFileTextBuffer = UnsafeBufferPointer(
      start: sourceFileText, count: sourceFileTextCount)
    let sourceFileSyntax = Parser.parse(source: sourceFileTextBuffer)
    let converter = SourceLocationConverter(
      file: filePath, tree: sourceFileSyntax)
    let context = MacroEvaluationContext(
      moduleName: targetModuleName, sourceLocationConverter: converter)
    let meePosition = AbsolutePosition(
      utf8Offset: sourceFileText.distance(to: localSourceText))
    guard let meeStartToken = sourceFileSyntax.token(at: meePosition),
          let mee = meeStartToken.parent?.as(MacroExpansionExprSyntax.self)
    else {
      fatalError("Unable to locate 'MacroExpansionExprSyntax' at offset \(meePosition)")
    }

    // Evaluate the macro.
    let evalResult = apply(mee, in: context)

    let rawDiags = UnsafeMutablePointer<_Diagnostic>.allocate(
      capacity: evalResult.diagnostics.count)
    for (i, diag) in evalResult.diagnostics.enumerated() {
      rawDiags.advanced(by: i).initialize(to: _makeDiagnostic(
        message: diag.message,
        position: diag.position.utf8Offset,
        severity: .init(diag.diagMessage.severity)))
    }

    var resultString = "\(evalResult.rewritten)"
    return resultString.withUTF8 { buffer in
      let result = UnsafeMutableBufferPointer<UInt8>.allocate(
        capacity: buffer.count + 1)
      _ = result.initialize(from: buffer)
      result[buffer.count] = 0
      return (
        code: UnsafePointer(result.baseAddress), codeLength: buffer.count,
        diagnostics: UnsafePointer?(rawDiags),
        diagnosticCount: evalResult.diagnostics.count)
    }
  }
}
#endif
