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

import MacroExamplesInterface

func runPeerMacrosPlayground() {
  // MARK: - Add Async

  struct MyStruct {
    @AddAsync
    func c(a: Int, for b: String, _ value: Double, completionBlock: @escaping (Result<String, Error>) -> Void) -> Void {
      completionBlock(.success("a: \(a), b: \(b), value: \(value)"))
    }

    @AddAsync
    func d(a: Int, for b: String, _ value: Double, completionBlock: @escaping (Bool) -> Void) -> Void {
      completionBlock(true)
    }
  }

  Task {
    let myStruct = MyStruct()
    _ = try? await myStruct.c(a: 5, for: "Test", 20)

    _ = await myStruct.d(a: 10, for: "value", 40)
  }

  // MARK: - Add Completion Handler

  class MyClass {
    @AddCompletionHandler
    func f(a: Int, for b: String, _ value: Double) async -> String {
      return b
    }
  }

  MyClass().f(a: 1, for: "hello", 3.14159) { result in
    print("Eventually received \(result + "!")")
  }

  // MARK: - Peer Value With Suffix Name

  @PeerValueWithSuffixName
  actor Counter {
    var value = 0
  }

  _ = Counter()

  //  print("Peer value with suffix name for \(Counter.self): \(String(describing: Counter_peer))")
}
