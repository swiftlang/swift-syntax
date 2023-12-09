//===----------------------------------------------------------------------===//
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Describes a macro that is freestanding, meaning that it is used with the
/// `#` syntax.
public protocol FreestandingMacro: Macro {
}
