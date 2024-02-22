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

// This test file has been translated from swift/test/Parse/deprecated_where.swift

import XCTest

// TODO: The generic where clause next to generic parameters is only valid in language mode 4. We should disallow them in language mode 5.

final class DeprecatedWhereTests: XCTestCase {
  func testDeprecatedWhere1() {
    assertParsedSource(
      """
      func testCombinedConstraintsOld<T: protocol<ProtoA, ProtoB> where T: ProtoC>(x: T) {}
      """,
      expecting:
        """
        1 │ func testCombinedConstraintsOld<T: protocol<ProtoA, ProtoB> where T: ProtoC>(x: T) {}
          │                                │   │       │                               ╰─ error: unexpected code '>(x: T)' in protocol
          │                                │   │       ╰─ error: expected identifier in protocol
          │                                │   ├─ error: expected inherited type in generic parameter
          │                                │   ├─ error: expected '>' to end generic parameter clause
          │                                │   ╰─ error: expected parameter clause in function signature
          │                                ╰─ note: to match this opening '<'

        """
    )
  }

  func testDeprecatedWhere2() {
    assertParsedSource(
      """
      func testCombinedConstraintsOld<T: protocol<ProtoA, ProtoB> where T: ProtoC>(x: T) where T: ProtoD {}
      """,
      expecting:
        """
        1 │ func testCombinedConstraintsOld<T: protocol<ProtoA, ProtoB> where T: ProtoC>(x: T) where T: ProtoD {}
          │                                │   │       │                               ╰─ error: unexpected code '>(x: T) where T: ProtoD' in protocol
          │                                │   │       ╰─ error: expected identifier in protocol
          │                                │   ├─ error: expected inherited type in generic parameter
          │                                │   ├─ error: expected '>' to end generic parameter clause
          │                                │   ╰─ error: expected parameter clause in function signature
          │                                ╰─ note: to match this opening '<'

        """
    )
  }
}
