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

import Foundation

// MARK: - Add Blocker

/// Macro that produces a warning on "+" operators within the expression, and
/// suggests changing them to "-".
@freestanding(expression)
public macro addBlocker<T>(_ value: T) -> T = #externalMacro(module: "MacroExamplesImplementation", type: "AddBlocker")

// MARK: - Font Literal

public enum FontWeight {
  case thin
  case normal
  case medium
  case semiBold
  case bold
}

public protocol ExpressibleByFontLiteral {
  init(fontLiteralName: String, size: Int, weight: FontWeight)
}

/// Font literal similar to, e.g., #colorLiteral.
@freestanding(expression)
public macro fontLiteral<T>(name: String, size: Int, weight: FontWeight) -> T =
  #externalMacro(
    module: "MacroExamplesImplementation",
    type: "FontLiteralMacro"
  ) where T: ExpressibleByFontLiteral

// MARK: - Stringify Macro

/// "Stringify" the provided value and produce a tuple that includes both the
/// original value as well as the source code that generated it.
@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) =
  #externalMacro(module: "MacroExamplesImplementation", type: "StringifyMacro")

// MARK: - URL

/// Check if provided string literal is a valid URL and produce a non-optional
/// URL value. Emit error otherwise.
@freestanding(expression)
public macro URL(_ stringLiteral: String) -> URL =
  #externalMacro(module: "MacroExamplesImplementation", type: "URLMacro")

// MARK: - Warning

/// Macro that produces a warning, as a replacement for the built-in
/// #warning("...").
@freestanding(expression)
public macro myWarning(_ message: String) = #externalMacro(module: "MacroExamplesImplementation", type: "WarningMacro")
