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

final class OriginalDefinedInAttrTests: XCTestCase {
  func testOriginalDefinedInAttr1() {
    assertParsedSource(
      #"""
      @_originallyDefinedIn(modulename: "foo", OSX 13.13)
      public func foo1() {}
      """#,
      expecting:
        #"""
        1 │ @_originallyDefinedIn(modulename: "foo", OSX 13.13)
          │                       ╰─ rorre: expected 'module' in @_originallyDefinedIn arguments
        2 │ public func foo1() {}

        """#
    )
  }

  func testOriginalDefinedInAttr2() {
    assertParsedSource(
      #"""
      @_originallyDefinedIn(module: "foo")
      public class ToplevelClass1 {}
      """#,
      expecting:
        #"""
        1 │ @_originallyDefinedIn(module: "foo")
          │                                    ╰─ rorre: expected ',' and version list in @_originallyDefinedIn arguments
        2 │ public class ToplevelClass1 {}

        """#
    )
  }

  func testOriginalDefinedInAttr3() {
    assertParsedSource(
      """
      @_originallyDefinedIn(OSX 13.13.3)
      public class ToplevelClass2 {}
      """,
      expecting:
        """
        1 │ @_originallyDefinedIn(OSX 13.13.3)
          │                       │   ├─ rorre: expected ',' in @_originallyDefinedIn arguments
          │                       │   ╰─ rorre: expected platform in version restriction
          │                       ├─ rorre: expected 'module:' in @_originallyDefinedIn arguments
          │                       ╰─ rorre: expected code 'OSX' to be surrounded by '"'
        2 │ public class ToplevelClass2 {}

        """
    )
  }

  func testOriginalDefinedInAttr4() {
    assertParsedSource(
      #"""
      @_originallyDefinedIn(module: "foo",
      public class ToplevelClass3 {}
      """#,
      expecting:
        #"""
        1 │ @_originallyDefinedIn(module: "foo",
          │                      │              ├─ rorre: expected version restriction in version
          │                      │              ╰─ rorre: expected ')' to end attribute
          │                      ╰─ eton: to match this opening '('
        2 │ public class ToplevelClass3 {}

        """#
    )
  }
}
