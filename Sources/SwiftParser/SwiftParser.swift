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

// The types from the SwiftParser module were merged into the SwiftSyntax module
// SwiftParser is an empty module that re-exports SwiftSyntax. Migrate imports
// of SwiftParser to imports of SwiftSyntax.
@_exported import SwiftSyntax
