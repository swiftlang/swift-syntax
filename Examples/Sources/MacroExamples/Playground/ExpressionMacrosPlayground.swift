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
import MacroExamplesInterface

func runExpressionMacrosPlayground() {

  let x = 1
  let y = 2
  let z = 3

  // MARK: - Add Blocker

  // "AddBlocker" complains about addition operations. We emit a warning
  // so it doesn't block compilation.
  print(#addBlocker(x * y + z))

  // MARK: - Font Literal

  struct Font: ExpressibleByFontLiteral {
    init(fontLiteralName: String, size: Int, weight: MacroExamplesInterface.FontWeight) {
    }
  }

  let _: Font = #fontLiteral(name: "Comic Sans", size: 14, weight: .thin)

  // MARK: - Stringify Macro

  // "Stringify" macro turns the expression into a string.
  print(#stringify(x + y))

  // MARK: - URL

  // "#URL" macro provides compile time checked URL construction. If the URL is
  // malformed an error is emitted. Otherwise a non-optional URL is expanded.
  print(#URL("https://swift.org/"))

  //  let domain = "domain.com"
  //print(#URL("https://\(domain)/api/path")) // error: #URL requires a static string literal
  //print(#URL("https://not a url.com:invalid-port/")) // error: Malformed url

  // MARK: - Warning

  #myWarning("remember to pass a string literal here")

  // Uncomment to get an error out of the macro.
  // let text = "oops"
  // #myWarning(text)
}
