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

/// The result of editing a package, including any edits to the package
/// manifest and any new files that are introduced.
@_spi(PackageRefactor)
public struct PackageEdit {
  /// Edits to perform to the package manifest.
  public var manifestEdits: [SourceEdit] = []

  /// Auxiliary files to write.
  public var auxiliaryFiles: [(relativePath: String, contents: SourceFileSyntax)] = []
}
