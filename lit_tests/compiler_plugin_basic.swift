// REQUIRES: platform=Darwin
//
// RUN: %empty-directory(%t)
//
// RUN: %swift-frontend -typecheck -swift-version 5 \
// RUN:   -enable-experimental-feature Macros \
// RUN:   -dump-macro-expansions \
// RUN:   -load-plugin-executable %build_dir/ExamplePlugin#ExamplePlugin \
// RUN    -module-name MyApp \
// RUN:   %s > %t/expansions-dump.txt 2>&1
//
// RUN: %FileCheck %s < %t/expansions-dump.txt

@freestanding(expression)
macro echo<T>(_: T) -> T = #externalMacro(module: "ExamplePlugin", type: "EchoExpressionMacro")

@attached(member)
macro Metadata() = #externalMacro(module: "ExamplePlugin", type: "MetadataMacro")

@Metadata
class MyClass {
  var value: Int = #echo(12)
}

// For '@Metadata'
// CHECK: static var __metadata__: [String: String] { ["name": "MyClass"] }

// For '#echo(12)'
// CHECK: /* echo */12
