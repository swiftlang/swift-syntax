// REQUIRES: platform=Darwin
//
// RUN: %empty-directory(%t)
//
// RUN: %swift-frontend -typecheck -swift-version 5 \
// RUN:   -enable-experimental-feature Macros \
// RUN:   -dump-macro-expansions \
// RUN:   -load-plugin-executable %examples_bin_path/ExamplePlugin#ExamplePlugin \
// RUN    -module-name MyApp \
// RUN:   %s 2>&1 | tee %t/expansions-dump.txt
//
// RUN: %FileCheck %s < %t/expansions-dump.txt

@freestanding(expression)
macro echo<T>(_: T) -> T = #externalMacro(module: "ExamplePlugin", type: "EchoExpressionMacro")

@attached(member, names: named(__metadata__))
macro Metadata() = #externalMacro(module: "ExamplePlugin", type: "MetadataMacro")

@Metadata
class MyClass {
  var value: Int = #echo(12)
}

// For '@Metadata'
// CHECK: static var __metadata__: [String: String] { ["name": "MyClass"] }

// For '#echo(12)'
// CHECK: /* echo */12
