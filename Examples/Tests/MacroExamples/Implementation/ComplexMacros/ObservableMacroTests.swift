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

import MacroExamplesImplementation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class ObservableMacroTests: XCTestCase {
  private let macros: [String: Macro.Type] = [
    "Observable": ObservableMacro.self,
    "ObservableProperty": ObservablePropertyMacro.self,
  ]

  func testExpansion() {
    assertMacroExpansion(
      """
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
      """,
      expandedSource: #"""
        final class Dog {
          var name: String? {
            get {
              _registrar.beginAccess(\.name)
              defer {
                _registrar.endAccess()
              }
              return _storage.name
            }
            set {
              _registrar.beginAccess(\.name)
              _registrar.register(observable: self, willSet: \.name, to: newValue)
              defer {
                _registrar.register(observable: self, didSet: \.name)
                _registrar.endAccess()
              }
              _storage.name = newValue
            }
          }
          var treat: Treat? {
            get {
              _registrar.beginAccess(\.treat)
              defer {
                _registrar.endAccess()
              }
              return _storage.treat
            }
            set {
              _registrar.beginAccess(\.treat)
              _registrar.register(observable: self, willSet: \.treat, to: newValue)
              defer {
                _registrar.register(observable: self, didSet: \.treat)
                _registrar.endAccess()
              }
              _storage.treat = newValue
            }
          }

          var isHappy: Bool {
            get {
              _registrar.beginAccess(\.isHappy)
              defer {
                _registrar.endAccess()
              }
              return _storage.isHappy
            }
            set {
              _registrar.beginAccess(\.isHappy)
              _registrar.register(observable: self, willSet: \.isHappy, to: newValue)
              defer {
                _registrar.register(observable: self, didSet: \.isHappy)
                _registrar.endAccess()
              }
              _storage.isHappy = newValue
            }
          }

          init() {}

          func bark() {
            print("bork bork")
          }

          let _registrar = ObservationRegistrar<Dog >()

          public nonisolated func addObserver(_ observer: some Observer<Dog >) {
            _registrar.addObserver(observer)
          }

          public nonisolated func removeObserver(_ observer: some Observer<Dog >) {
            _registrar.removeObserver(observer)
          }

          private func withTransaction<T>(_ apply: () throws -> T) rethrows -> T {
            _registrar.beginAccess()
            defer {
              _registrar.endAccess()
            }
            return try apply()
          }

          private struct Storage {

            var name: String?
            var treat: Treat?

            var isHappy: Bool = true
          }

          private var _storage = Storage()
        }

        extension Dog: Observable {
        }
        """#,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
