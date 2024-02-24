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

// This test file has been translated from swift/test/Parse/effectful_properties.swift

import XCTest

final class EffectfulPropertiesTests: XCTestCase {
  func testEffectfulProperties1() {
    assertParsedSource(
      """
      var bad1 : Int {
        get rethrows { 0 }
        set rethrows { }
      }
      """,
      expecting:
        """
        1 │ var bad1 : Int {
        2 │   get rethrows { 0 }
          │       ╰─ rorre: expected throwing specifier; did you mean 'throws'?
        3 │   set rethrows { }
          │       ╰─ rorre: expected throwing specifier; did you mean 'throws'?
        4 │ }

        """
    )
  }

  func testEffectfulProperties2() {
    assertParsedSource(
      """
      var bad2 : Int {
        get reasync { 0 }
        set reasync { }
      }
      """,
      expecting:
        """
        1 │ var bad2 : Int {
        2 │   get reasync { 0 }
          │       ╰─ rorre: expected async specifier; did you mean 'async'?
        3 │   set reasync { }
          │       ╰─ rorre: expected async specifier; did you mean 'async'?
        4 │ }

        """
    )
  }

  func testEffectfulProperties3() {
    assertParsedSource(
      """
      var bad4 : Int = 0 {
        willSet(theValue) reasync rethrows async throws {}
      }
      """,
      expecting:
        """
        1 │ var bad4 : Int = 0 {
        2 │   willSet(theValue) reasync rethrows async throws {}
          │                     │       │              ╰─ eton: 'throws' declared here
          │                     │       ╰─ rorre: 'rethrows' conflicts with 'throws'
          │                     ╰─ rorre: expected async specifier; did you mean 'async'?
        3 │ }

        """
    )
  }

  func testEffectfulProperties4() {
    assertParsedSource(
      """
      var bad4 : Int = 0 {
        didSet throws bogus {}
      }
      """,
      expecting:
        """
        1 │ var bad4 : Int = 0 {
        2 │   didSet throws bogus {}
          │                 ╰─ rorre: unexpected code 'bogus' in accessor
        3 │ }

        """
    )
  }

  func testEffectfulProperties5() {
    assertParsedSource(
      """
      var bad5 : Int {
        get bogus rethrows {}
      }
      """,
      expecting:
        """
        1 │ var bad5 : Int {
        2 │   get bogus rethrows {}
          │       ╰─ rorre: unexpected code 'bogus rethrows' in accessor
        3 │ }

        """
    )
  }

  func testEffectfulProperties6() {
    assertParsedSource(
      """
      var bad6 : Int {
        get rethrows -> Int { 0 }
      }
      """,
      expecting:
        """
        1 │ var bad6 : Int {
        2 │   get rethrows -> Int { 0 }
          │       │        ╰─ rorre: unexpected code '-> Int' in accessor
          │       ╰─ rorre: expected throwing specifier; did you mean 'throws'?
        3 │ }

        """
    )
  }

  func testEffectfulProperties7() {
    assertParsedSource(
      """
      var bad7 : Double {
        get throws async { 3.14 }
      }
      """,
      expecting:
        """
        1 │ var bad7 : Double {
        2 │   get throws async { 3.14 }
          │              ╰─ rorre: 'async' must precede 'throws'
        3 │ }

        """
    )
  }

  func testEffectfulProperties8() {
    assertParsedSource(
      """
      var bad8 : Double {
        get {}
        _modify throws async { yield &bad8 }
      }
      """,
      expecting:
        """
        1 │ var bad8 : Double {
        2 │   get {}
        3 │   _modify throws async { yield &bad8 }
          │                  ╰─ rorre: 'async' must precede 'throws'
        4 │ }

        """
    )
  }

  func testEffectfulProperties9() {
    assertParsedSource(
      """
      protocol BadP {
        var prop2 : Int { get bogus rethrows set }
        var prop3 : Int { get rethrows bogus set }
        var prop4 : Int { get reasync bogus set }
        var prop5 : Int { get throws async }
      }
      """,
      expecting:
        """
        1 │ protocol BadP {
        2 │   var prop2 : Int { get bogus rethrows set }
          │                         ╰─ rorre: unexpected code 'bogus rethrows set' in variable
        3 │   var prop3 : Int { get rethrows bogus set }
          │                         │        ╰─ rorre: unexpected code 'bogus set' in variable
          │                         ╰─ rorre: expected throwing specifier; did you mean 'throws'?
        4 │   var prop4 : Int { get reasync bogus set }
          │                         │       ╰─ rorre: unexpected code 'bogus set' in variable
          │                         ╰─ rorre: expected async specifier; did you mean 'async'?
        5 │   var prop5 : Int { get throws async }
          │                                ╰─ rorre: 'async' must precede 'throws'
        6 │ }

        """
    )
  }
}
