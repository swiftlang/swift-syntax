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

import SwiftRefactor

final class RefactoringRegistry {
  public static let shared = RefactoringRegistry()

  public private(set) var providers = [any SyntaxRefactoringProvider.Type]()
  private var providersByName = [String: any SyntaxRefactoringProvider.Type]()

  func register(_ provider: any SyntaxRefactoringProvider.Type) {
    self.providers.append(provider)
    self.providersByName[String(describing: provider)] = provider
  }

  subscript(identifier: String) -> (any SyntaxRefactoringProvider.Type)? {
    _read { yield self.providersByName[identifier] }
  }

  private init() {}
}
