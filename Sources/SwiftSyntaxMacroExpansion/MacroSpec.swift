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

#if swift(>=6)
public import SwiftSyntax
public import SwiftSyntaxMacros
#else
import SwiftSyntax
import SwiftSyntaxMacros
#endif

/// The information of a macro declaration, to be used with `assertMacroExpansion`.
///
/// In addition to specifying the macro’s type, this allows the specification of conformances that will be passed to the macro’s `expansion` function.
public struct MacroSpec {
  /// The type of macro.
  let type: Macro.Type
  /// The list of types for which the macro needs to add conformances.
  let conformances: [TypeSyntax]

  /// An `InheritedTypeListSytnax` containing all the types for which the macro needs to add conformances.
  var inheritedTypeList: InheritedTypeListSyntax {
    return InheritedTypeListSyntax {
      for conformance in conformances {
        InheritedTypeSyntax(type: conformance)
      }
    }
  }

  /// Creates a new specification from provided macro type
  /// and optional list of generated conformances.
  ///
  /// - Parameters:
  ///   - type: The type of macro.
  ///   - conformances: The list of types that will be passed to the macro’s `expansion` function.
  public init(type: Macro.Type, conformances: [TypeSyntax] = []) {
    self.type = type
    self.conformances = conformances
  }
}
