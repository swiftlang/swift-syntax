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
import SwiftRefactor
import XcodeKit

final class SourceEditorExtension: NSObject, XCSourceEditorExtension {
  func extensionDidFinishLaunching() {
    Self.forEachRefactoringProvider { provider in
      RefactoringRegistry.shared.register(provider)
    }
  }

  var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
    return RefactoringRegistry.shared.providers.map { provider in
      return [
        .classNameKey: SourceEditorCommand.className(),
        .identifierKey: String(describing: provider),
        .nameKey: String(describing: provider),
      ]
    }
  }
}
