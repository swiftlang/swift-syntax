//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// Specifies how names should be introduced at the file scope.
@_spi(Experimental) public enum FileScopeNameIntroductionStrategy: LookupConfig {
  /// Default behavior. Names introduced sequentially like in member block
  /// scope up to the first non-declaration after and including which,
  /// the declarations are treated like in code block scope.
  case memberBlockUpToLastDecl
  /// File scope behaves like member block scope.
  case memberBlock
  /// File scope behaves like code block scope.
  case codeBlock
}
