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

#if compiler(>=6)
internal import SwiftSyntax
#else
import SwiftSyntax
#endif

// This file provides compatibility aliases to keep dependents of SwiftSyntax building.
// All users of the declarations in this file should transition away from them ASAP.

extension TokenSpec {
  @available(*, deprecated, renamed: "leftSquare")
  public static var leftSquareBracket: TokenSpec {
    return .leftSquare
  }

  @available(*, deprecated, renamed: "rightSquare")
  public static var rightSquareBracket: TokenSpec {
    return .rightSquare
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add a compatibility layer code here     //
// please insert it in alphabetical order above                             //
//==========================================================================//
