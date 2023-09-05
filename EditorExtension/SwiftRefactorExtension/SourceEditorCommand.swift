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

import Foundation
import SwiftParser
import SwiftRefactor
import SwiftSyntax
import XcodeKit

enum ExtensionError: Error {
  case unsupportedContentType
  case unknownRefactoring(String)
}

final class SourceEditorCommand: NSObject, XCSourceEditorCommand {
  func perform(with invocation: XCSourceEditorCommandInvocation) async throws {
    guard invocation.buffer.contentUTI == "public.swift-source" else {
      throw ExtensionError.unsupportedContentType
    }

    guard let provider = RefactoringRegistry.shared[invocation.commandIdentifier] else {
      throw ExtensionError.unknownRefactoring(invocation.commandIdentifier)
    }

    class Rewriter: SyntaxRewriter {
      private let provider: any SyntaxRefactoringProvider.Type

      init(provider: any SyntaxRefactoringProvider.Type) {
        self.provider = provider
        super.init(viewMode: .sourceAccurate)
      }

      override func visitAny(_ node: Syntax) -> Syntax? {
        func withOpenedRefactoringProvider<T: SyntaxRefactoringProvider>(_ providerType: T.Type) -> Syntax? {
          guard
            let input = node.as(providerType.Input.self),
            providerType.Context.self == Void.self
          else {
            return nil
          }
          let context = unsafeBitCast(Void(), to: providerType.Context.self)
          return providerType.refactor(syntax: input, in: context).map { Syntax($0) }
        }

        return _openExistential(self.provider, do: withOpenedRefactoringProvider)
      }
    }

    let source = Parser.parse(source: invocation.buffer.completeBuffer)
    let transformedSource = Rewriter(provider: provider).visit(source)
    invocation.buffer.completeBuffer = transformedSource.description
  }
}
