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
    StringifyMacro.self,
    AddBlocker.self,
    WarningMacro.self,
    FontLiteralMacro.self,
    WrapStoredPropertiesMacro.self,
    DictionaryStorageMacro.self,
    DictionaryStoragePropertyMacro.self,
    ObservableMacro.self,
    ObservablePropertyMacro.self,
    AddCompletionHandlerMacro.self,
    AddAsyncMacro.self,
    CaseDetectionMacro.self,
    MetaEnumMacro.self,
    CodableKey.self,
    CustomCodable.self,
    OptionSetMacro.self,
    NewTypeMacro.self,
    URLMacro.self,
  ]
}
#endif
