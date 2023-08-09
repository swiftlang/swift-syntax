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

// This test file has been translated from swift/test/Parse/original_defined_in_attr.swift

import XCTest

final class OriginalDefinedInAttrTests: ParserTestCase {
  func testOriginalDefinedInAttr1() {
    assertParse(
      #"""
      @_originallyDefinedIn(module: "foo", OSX 13.13)
      public func foo() {}
      """#
    )
  }

  func testOriginalDefinedInAttr2() {
    assertParse(
      #"""
      @_originallyDefinedIn(1️⃣modulename: "foo", OSX 13.13)
      public func foo1() {}
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "expected 'module' in @_originallyDefinedIn arguments",
          fixIts: ["replace 'modulename' with 'module'"]
        )
      ],
      fixedSource: #"""
        @_originallyDefinedIn(module: "foo", OSX 13.13)
        public func foo1() {}
        """#
    )
  }

  func testOriginalDefinedInAttr3() {
    assertParse(
      #"""
      @_originallyDefinedIn(module: "foo", OSX 13.13.3)
      public class ToplevelClass {}
      """#
    )
  }

  func testOriginalDefinedInAttr4() {
    assertParse(
      #"""
      @_originallyDefinedIn(module: "foo"1️⃣)
      public class ToplevelClass1 {}
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected ',' and version list in @_originallyDefinedIn arguments",
          fixIts: ["insert ',' and version list"]
        )
      ],
      fixedSource: #"""
        @_originallyDefinedIn(module: "foo", <#identifier#>)
        public class ToplevelClass1 {}
        """#
    )
  }

  func testOriginalDefinedInAttr5() {
    assertParse(
      """
      @_originallyDefinedIn(1️⃣OSX 2️⃣13.13.3)
      public class ToplevelClass2 {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected 'module:' in @_originallyDefinedIn arguments",
          fixIts: ["insert 'module:'"]
        ),
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: #"expected code 'OSX' to be surrounded by '"'"#,
          fixIts: [#"insert '"' and '"'"#]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected ',' in @_originallyDefinedIn arguments",
          fixIts: ["insert ','"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected platform in version restriction",
          fixIts: ["insert platform"]
        ),
      ],
      fixedSource: """
        @_originallyDefinedIn(module: "OSX", <#identifier#> 13.13.3)
        public class ToplevelClass2 {}
        """
    )
  }

  func testOriginalDefinedInAttr6() {
    assertParse(
      #"""
      @_originallyDefinedInℹ️(module: "foo",1️⃣
      public class ToplevelClass3 {}
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "expected version restriction in version",
          fixIts: ["insert version restriction"]
        ),
        DiagnosticSpec(
          message: "expected ')' to end attribute",
          notes: [NoteSpec(message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
      ],
      fixedSource: #"""
        @_originallyDefinedIn(module: "foo", <#identifier#>)
        public class ToplevelClass3 {}
        """#
    )
  }

  func testOriginalDefinedInAttr7() {
    assertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", * 13.13)
      public class ToplevelClass4 {}
      """#
    )

    assertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.13, iOS 7.0)
      public class ToplevelClass4 {}
      """#
    )

    assertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.14, * 7.0)
      public class ToplevelClass4 {}
      """#
    )

    assertParse(
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
    assertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.13)
      @_originallyDefinedIn(module: "foo", iOS 7.0)
      internal class ToplevelClass5 {}
      """#
    )
  }

  func testOriginalDefinedInAttr9() {
    assertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.13)
      @_originallyDefinedIn(module: "foo", iOS 7.0)
      private class ToplevelClass6 {}
      """#
    )
  }

  func testOriginalDefinedInAttr10() {
    assertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.13)
      @_originallyDefinedIn(module: "foo", iOS 7.0)
      fileprivate class ToplevelClass7 {}
      """#
    )
  }

  func testOriginalDefinedInAttr11() {
    assertParse(
      #"""
      @available(OSX 13.10, *)
      @_originallyDefinedIn(module: "foo", OSX 13.13, iOS 7.0)
      internal class ToplevelClass8 {}
      """#
    )
  }

  func testOrinalDefinedInAttr12() {
    assertParse(
      """
      @_originallyDefinedIn(module: "ToasterKit", _iOS13Aligned)
      struct Vehicle {}
      """
    )
  }
}
