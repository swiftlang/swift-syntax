// REQUIRES: platform=Darwin
//
// RUN: %empty-directory(%t)
//
// RUN: %swift-frontend -typecheck -verify -swift-version 5 \
// RUN:   -enable-experimental-feature CodeItemMacros \
// RUN:   -enable-experimental-feature ExtensionMacros \
// RUN:   -dump-macro-expansions \
// RUN:   -load-plugin-executable %examples_bin_path/ExamplePlugin#ExamplePlugin \
// RUN:   -parse-as-library \
// RUN:   -module-name TestApp \
// RUN:   %s 2>&1 | tee %t/expansions-dump.txt
//
// RUN: %FileCheck %s < %t/expansions-dump.txt

@freestanding(expression)
macro echo<T>(_: T) -> T = #externalMacro(module: "ExamplePlugin", type: "EchoExpressionMacro")

@freestanding(declaration)
macro funcUnique() = #externalMacro(module: "ExamplePlugin", type: "FuncUniqueMacro")

@freestanding(codeItem)
macro printAny(_: Any) = #externalMacro(module: "ExamplePlugin", type: "PrintAnyMacro")

@attached(member, names: named(__metadata__))
macro Metadata() = #externalMacro(module: "ExamplePlugin", type: "MetadataMacro")

@attached(peer, names: suffixed(_peer))
macro PeerWithSuffix() = #externalMacro(module: "ExamplePlugin", type: "PeerValueWithSuffixNameMacro")

@attached(memberAttribute)
macro MemberDeprecated() = #externalMacro(module: "ExamplePlugin", type: "MemberDeprecatedMacro")

@attached(extension, conformances: Equatable)
macro Equatable() = #externalMacro(module: "ExamplePlugin", type: "EquatableConformanceMacro")

@attached(accessor)
macro DidSetPrint() = #externalMacro(module: "ExamplePlugin", type: "DidSetPrintMacro")

@Metadata
@MemberDeprecated
@Equatable
@PeerWithSuffix
struct MyStruct {
  @DidSetPrint
  var value: Int = #echo(12)
  // expected-error@-1 {{expansion of macro 'DidSetPrint()' did not produce a non-observing accessor}}

  func _test() {
    #printAny("test")
  }
}

#funcUnique

// CHECK: @__swiftmacro_7TestApp8MyStruct14PeerWithSuffixfMp_.swift
// CHECK-NEXT: ------------------------------
// CHECK-NEXT: var MyStruct_peer: Int {
// CHECK-NEXT:     1
// CHECK-NEXT: }
// CHECK-NEXT: ------------------------------

// CHECK: @__swiftmacro_7TestApp8MyStruct8MetadatafMm_.swift
// CHECK-NEXT: ------------------------------
// CHECK-NEXT: static var __metadata__: [String: String] {
// CHECK-NEXT:     ["name": "MyStruct"]
// CHECK-NEXT: }
// CHECK-NEXT: ------------------------------

// CHECK: @__swiftmacro_7TestApp8MyStructV5value16MemberDeprecatedfMr_.swift
// CHECK-NEXT: ------------------------------
// CHECK-NEXT: @available(*, deprecated)
// CHECK-NEXT: ------------------------------

// CHECK: @__swiftmacro_7TestApp8MyStructV5_test16MemberDeprecatedfMr0_.swift
// CHECK-NEXT: ------------------------------
// CHECK-NEXT: @available(*, deprecated)
// CHECK-NEXT: ------------------------------

// CHECK: @__swiftmacro_7TestApp8MyStruct9EquatablefMe_.swift
// CHECK-NEXT: ------------------------------
// CHECK-NEXT: extension MyStruct: Equatable  {
// CHECK-NEXT: }
// CHECK-NEXT: ------------------------------

// CHECK: @__swiftmacro_7TestApp8MyStructV5value11DidSetPrintfMa_.swift
// CHECK-NEXT: ------------------------------
// CHECK-NEXT: {
// CHECK-NEXT:     didSet {
// CHECK-NEXT:         print(value)
// CHECK-NEXT:     }
// CHECK-NEXT: }
// CHECK-NEXT: ------------------------------

// CHECK: @__swiftmacro_7TestApp8MyStructV4echofMf_.swift
// CHECK-NEXT: ------------------------------
// CHECK-NEXT: /* echo */12
// CHECK-NEXT: ------------------------------

// CHECK: @__swiftmacro_7TestApp33_B5E4CA48BE2C4AA1BE7F954C809E362ALl10funcUniquefMf_.swift
// CHECK-NEXT: ------------------------------
// CHECK-NEXT: func $s7TestApp33_B5E4CA48BE2C4AA1BE7F954C809E362ALl10funcUniquefMf_6uniquefMu_() {
// CHECK-NEXT: }

// CHECK: @__swiftmacro_7TestApp8MyStructV5_testyyF8printAnyfMf0_.swift
// CHECK-NEXT: ------------------------------
// CHECK-NEXT: print("test")
// CHECK-NEXT: ------------------------------
