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

// This file provides compatiblity aliases to keep dependents of SwiftSyntax building.
// All users of the declarations in this file should transition away from them ASAP.

extension SyntaxClassification {
  /// A `#` keyword like `#warning`.
  @available(*, deprecated, renamed: "ifConfigDirective")
  public static var poundDirective: SyntaxClassification {
    return .ifConfigDirective
  }

  @available(*, deprecated, renamed: "ifConfigDirective")
  public static var buildConfigId: SyntaxClassification {
    return .ifConfigDirective
  }

  @available(*, deprecated, message: "String interpolation anchors are now classified as .none")
  public static var stringInterpolationAnchor: SyntaxClassification {
    return .none
  }

  @available(*, deprecated, renamed: "type")
  public static var typeIdentifier: SyntaxClassification {
    return .type
  }

  @available(*, deprecated, renamed: "operator")
  public static var operatorIdentifier: SyntaxClassification {
    return .operator
  }

  @available(*, deprecated, renamed: "floatLiteral")
  public static var floatingLiteral: SyntaxClassification {
    return .floatLiteral
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add a compatiblity layer code here      //
// please insert it in alphabetical order above                             //
//==========================================================================//
