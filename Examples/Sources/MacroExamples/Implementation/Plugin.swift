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

#if canImport(SwiftCompilerPlugin)
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct MyPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    AddAsyncMacro.self,
    AddBlocker.self,
    AddCompletionHandlerMacro.self,
    CaseDetectionMacro.self,
    CodableKey.self,
    CustomCodable.self,
    DefaultFatalErrorImplementationMacro.self,
    DictionaryStorageMacro.self,
    DictionaryStoragePropertyMacro.self,
    EquatableExtensionMacro.self,
    FontLiteralMacro.self,
    FuncUniqueMacro.self,
    MemberDeprecatedMacro.self,
    MetaEnumMacro.self,
    NativeColumnMacro.self,
    NativeFileIDMacro.self,
    NativeFilePathMacro.self,
    NativeLineMacro.self,
    NewTypeMacro.self,
    ObservableMacro.self,
    ObservablePropertyMacro.self,
    OptionSetMacro.self,
    PeerValueWithSuffixNameMacro.self,
    StringifyMacro.self,
    URLMacro.self,
    WarningMacro.self,
    WrapStoredPropertiesMacro.self,
  ]
}
#endif
