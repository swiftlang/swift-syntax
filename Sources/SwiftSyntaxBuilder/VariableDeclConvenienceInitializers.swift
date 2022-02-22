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

extension VariableDecl {
  public init(_ letOrVarKeyword: TokenSyntax,
              name: ExpressibleAsIdentifierPattern,
              type: ExpressibleAsTypeAnnotation) {
    self.init(letOrVarKeyword: letOrVarKeyword, bindingsBuilder: {
      PatternBinding(pattern: name.createIdentifierPattern(),
                     typeAnnotation: type.createTypeAnnotation())
      })
  }
}
