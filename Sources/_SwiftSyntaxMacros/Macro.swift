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
#if canImport(_CompilerPluginSupport)
import _CompilerPluginSupport
#else
public typealias _CompilerPlugin = Any
#endif

/// Describes a macro.
public protocol Macro: _CompilerPlugin {
  /// The name of this macro.
  static var name: String { get }

  /// Documentation for this macro.
  ///
  /// This documentation should be written in the Markdown format used for
  /// commenting Swift declarations.
  static var documentation: String { get }

  /// The generic signature to use when describing the type of this macro.
  static var genericSignature: GenericParameterClauseSyntax? { get }

  /// The type signature for this macro.
  ///
  /// A function type indicates a function-like macro (such as
  /// `#colorLiteral(red: r, green: b, blue: b, alpha: a)`) that takes
  /// arguments, whereas any other type indicates a value-like macro (such
  /// as `#line`) that does not. This is a syntactic distinction, not a
  /// semantic one.
  static var signature: TypeSyntax { get }
}

extension Macro {
  /// Default, empty documentation string for macros.
  public static var documentation: String { "" }
}

#if canImport(_CompilerPluginSupport)
extension Macro {
  public static func _name() -> (UnsafePointer<UInt8>, count: Int) {
    var name = name
    return name.withUTF8 { buffer in
      let result = UnsafeMutablePointer<UInt8>.allocate(capacity: buffer.count)
      result.initialize(from: buffer.baseAddress!, count: buffer.count)
      return (UnsafePointer(result), count: buffer.count)
    }
  }
}
#endif
