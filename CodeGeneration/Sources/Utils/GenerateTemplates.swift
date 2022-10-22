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

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftBasicFormat

public func generateTemplates(templates: [(SourceFile, String)], destination: URL, verbose: Bool) throws {
  try FileManager.default.createDirectory(
    atPath: destination.path,
    withIntermediateDirectories: true,
    attributes: nil
  )

  for (sourceFile, name) in templates {
    let fileURL = destination.appendingPathComponent(name)
    if verbose {
      print("Generating \(fileURL.path)...")
    }
    let syntax = sourceFile.formatted(using: CodeGenerationFormat())
    try "\(syntax)\n".write(to: fileURL, atomically: true, encoding: .utf8)
  }
}
