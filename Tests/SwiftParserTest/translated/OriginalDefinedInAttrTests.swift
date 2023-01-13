//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/original_defined_in_attr.swift

import XCTest

final class OriginalDefinedInAttrTests: XCTestCase {
  func testOriginalDefinedInAttr1() {
    AssertParse(
      #"""
      @_originallyDefinedIn(module: "foo", OSX 13.13) 
      public func foo() {}
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '@_originallyDefinedIn' requires that 'foo()' have explicit availability for macOS
      ]
    )
  }

  func testOriginalDefinedInAttr2() {
    AssertParse(
      #"""
      @_originallyDefinedIn(1️⃣modulename: "foo", OSX 13.13)
      public func foo1() {}
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected 'module' in @_originallyDefinedIn arguments"),
        DiagnosticSpec(message: "unexpected code 'modulename' before @_originallyDefinedIn arguments"),
      ]
    )
  }

  func testOriginalDefinedInAttr3() {
    AssertParse(
      #"""
      @_originallyDefinedIn(module: "foo", OSX 13.13.3) 
      public class ToplevelClass {}
      """#,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: '@_originallyDefinedIn' only uses major and minor version number
        // TODO: Old parser expected error on line 1: '@_originallyDefinedIn' requires that 'ToplevelClass' have explicit availability for macOS
      ]
    )
  }

  func testOriginalDefinedInAttr4() {
    AssertParse(
      #"""
      @_originallyDefinedIn(module: "foo"1️⃣)
      public class ToplevelClass1 {}
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ',' and version list in @_originallyDefinedIn arguments")
      ]
    )
  }

  func testOriginalDefinedInAttr5() {
    AssertParse(
      """
      @_originallyDefinedIn(1️⃣OSX 13.13.3)
      public class ToplevelClass2 {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'module:', string literal, and ',' in @_originallyDefinedIn arguments")
      ]
    )
  }

  func testOriginalDefinedInAttr6() {
    AssertParse(
      #"""
      @_originallyDefinedIn(module: "foo",1️⃣
      public class ToplevelClass3 {}
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in version"),
        DiagnosticSpec(message: "expected ')' to end attribute"),
      ]
    )
  }

  func testOriginalDefinedInAttr7() {
    AssertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", * 13.13) 
      public class ToplevelClass4 {}
      """#
    )

    AssertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.13, iOS 7.0)
      public class ToplevelClass4 {}
      """#
    )

    AssertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.14, * 7.0)
      public class ToplevelClass4 {}
      """#
    )

    AssertParse(
      #"""
      public class ToplevelClass4 {
        @_originallyDefinedIn(module: "foo", OSX 13.13)
        subscript(index: Int) -> Int {
              get { return 1 }
              set(newValue) {}
        }
      }
      """#
    )
  }

  func testOriginalDefinedInAttr8() {
    AssertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.13) 
      @_originallyDefinedIn(module: "foo", iOS 7.0)
      internal class ToplevelClass5 {}
      """#,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: '@_originallyDefinedIn' does not have any effect on internal declarations
      ]
    )
  }

  func testOriginalDefinedInAttr9() {
    AssertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.13) 
      @_originallyDefinedIn(module: "foo", iOS 7.0)
      private class ToplevelClass6 {}
      """#,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: '@_originallyDefinedIn' does not have any effect on private declarations
      ]
    )
  }

  func testOriginalDefinedInAttr10() {
    AssertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.13) 
      @_originallyDefinedIn(module: "foo", iOS 7.0)
      fileprivate class ToplevelClass7 {}
      """#,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: '@_originallyDefinedIn' does not have any effect on fileprivate declarations
      ]
    )
  }

  func testOriginalDefinedInAttr11() {
    AssertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.13, iOS 7.0) 
      internal class ToplevelClass8 {}
      """#,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: '@_originallyDefinedIn' does not have any effect on internal declarations
      ]
    )
  }

  func testOrinalDefinedInAttr12() {
    AssertParse(
      """
      @_originallyDefinedIn(module: "ToasterKit", _iOS13Aligned)
      struct Vehicle {}
      """
    )
  }

}
