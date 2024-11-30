//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

public protocol ManifestEditRefactoringProvider: EditRefactoringProvider
where Self.Input == SourceFileSyntax {

  static func manifestRefactor(syntax: SourceFileSyntax, in context: Context) throws -> PackageEditResult
}

extension EditRefactoringProvider where Self: ManifestEditRefactoringProvider {
  public static func textRefactor(syntax: Input, in context: Context) -> [SourceEdit] {
    return (try? manifestRefactor(syntax: syntax, in: context).manifestEdits) ?? []
  }
}
