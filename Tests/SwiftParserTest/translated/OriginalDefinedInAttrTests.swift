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
      @_originallyDefinedIn(modulename: "foo", OSX 13.13) 
      public func foo1() {}
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected 'module: "original"' in the first argument to @_originallyDefinedIn
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
      @_originallyDefinedIn(module: "foo") 
      public class ToplevelClass1 {}
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected at least one platform version in '@_originallyDefinedIn' attribute
      ]
    )
  }

  func testOriginalDefinedInAttr5() {
    AssertParse(
      """
      @_originallyDefinedIn(OSX 13.13.3) 
      public class ToplevelClass2 {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected 'module: "original"' in the first argument to @_originallyDefinedIn
      ]
    )
  }

  func testOriginalDefinedInAttr6() {
    AssertParse(
      #"""
      @_originallyDefinedIn(module: "foo",
      public class ToplevelClass3 {}#^DIAG^#
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected platform in '@_originallyDefinedIn' attribute
        DiagnosticSpec(message: "expected ')' to end attribute"),
        DiagnosticSpec(message: "expected declaration after attribute"),
      ]
    )
  }

  func testOriginalDefinedInAttr7() {
    AssertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", * 13.13) 
      @_originallyDefinedIn(module: "foo", OSX 13.13, iOS 7.0)
      @_originallyDefinedIn(module: "foo", OSX 13.14, * 7.0) 
      public class ToplevelClass4 {
      	@_originallyDefinedIn(module: "foo", OSX 13.13) 
      	subscript(index: Int) -> Int {
              get { return 1 }
              set(newValue) {}
      	}
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: * as platform name has no effect
        // TODO: Old parser expected error on line 2: expected at least one platform version in '@_originallyDefinedIn' attribute
        // TODO: Old parser expected warning on line 4: * as platform name has no effect
        // TODO: Old parser expected error on line 4: '@_originallyDefinedIn' contains multiple versions for macOS
        // TODO: Old parser expected error on line 6: '@_originallyDefinedIn' attribute cannot be applied to this declaration
      ]
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

}
