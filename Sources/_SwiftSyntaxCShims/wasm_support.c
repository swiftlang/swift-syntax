//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if defined(__wasm32__)

// defined in CompilerPluginMessageHandler.swift
void _swift_wasm_macro_pump(void);

__attribute__((export_name("swift_wasm_macro_v1_pump")))
void swift_wasm_macro_pump(void) {
    _swift_wasm_macro_pump();
}

#endif
