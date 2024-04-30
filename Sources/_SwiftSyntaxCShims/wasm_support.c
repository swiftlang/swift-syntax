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

// uint32_t
#define SWIFT_WASM_MACRO_ABI 1

#define _STR(X) #X
#define STR(X) _STR(X)

// Add a `swift_wasm_macro_abi` section to the generated Wasm file
// to allow the runner to check our ABI version and act accordingly.
//
// LLVM has special-cased handling to map .custom_section.foo to
// Wasm Custom Section "foo". this must be a metadata section rather
// than a data section so we can't use __attribute__((section)) for it.
// See: https://reviews.llvm.org/D43097
__asm__("\t.section .custom_section.swift_wasm_macro_abi,\"\",@\n\t.4byte " STR(SWIFT_WASM_MACRO_ABI) "\n");

// defined in CompilerPlugin.swift
void _swift_wasm_macro_pump(void);

__attribute__((export_name("swift_wasm_macro_pump")))
void swift_wasm_macro_pump(void) {
    _swift_wasm_macro_pump();
}

#endif
