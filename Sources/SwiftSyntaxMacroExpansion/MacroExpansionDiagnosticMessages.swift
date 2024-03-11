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
public import SwiftSyntaxMacros
#else
import SwiftSyntaxMacros
#endif

@available(*, deprecated, message: "MacroExpansionErrorMessage has been moved to the SwiftSyntaxMacros module")
public typealias MacroExpansionErrorMessage = SwiftSyntaxMacros.MacroExpansionErrorMessage

@available(*, deprecated, message: "MacroExpansionWarningMessage has been moved to the SwiftSyntaxMacros module")
public typealias MacroExpansionWarningMessage = SwiftSyntaxMacros.MacroExpansionWarningMessage

@available(*, deprecated, message: "MacroExpansionFixItMessage has been moved to the SwiftSyntaxMacros module")
public typealias MacroExpansionFixItMessage = SwiftSyntaxMacros.MacroExpansionFixItMessage
