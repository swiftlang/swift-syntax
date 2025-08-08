//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

@_spi(PackageRefactor)
public protocol ManifestEditRefactoringProvider: EditRefactoringProvider
where Self.Input == SourceFileSyntax {

  static func manifestRefactor(syntax: SourceFileSyntax, in context: Context) throws -> PackageEdit
}

extension ManifestEditRefactoringProvider {
  public static func textRefactor(syntax: Input, in context: Context) -> [SourceEdit] {
    return (try? manifestRefactor(syntax: syntax, in: context).manifestEdits) ?? []
  }
}
