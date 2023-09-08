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

// MARK: - Dictionary Storage

// Move the storage from each of the stored properties into a dictionary
// called `_storage`, turning the stored properties into computed properties.
@DictionaryStorage
struct Point {
  var x: Int = 1
  var y: Int = 2
}

func runDictionaryStorageMacroPlayground() {
  var point = Point()
  print("Point storage begins as an empty dictionary: \(point)")
  print("Default value for point.x: \(point.x)")
  point.y = 17
  print("Point storage contains only the value we set:  \(point)")
}

// MARK: - Observable

struct Treat {}

@Observable
final class Dog {
  var name: String?
  var treat: Treat?

  var isHappy: Bool = true

  init() {}

  func bark() {
    print("bork bork")
  }
}

func runObservableMacroPlayground() {
  let dog = Dog()
  print(dog.name ?? "")
  dog.name = "George"
  dog.treat = Treat()
  print(dog.name ?? "")
  dog.bark()
}

// MARK: - Option Set

@MyOptionSet<UInt8>
struct ShippingOptions {
  private enum Options: Int {
    case nextDay
    case secondDay
    case priority
    case standard
  }

  static let express: ShippingOptions = [.nextDay, .secondDay]
  static let all: ShippingOptions = [.express, .priority, .standard]
}
