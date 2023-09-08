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

import Foundation
import MacroExamplesInterface

func runMemberMacrosPlayground() {
  // MARK: - Case Detection

  @CaseDetection
  enum Pet {
    case dog
    case cat(curious: Bool)
    case parrot
    case snake
  }

  let pet: Pet = .cat(curious: true)
  print("Pet is dog: \(pet.isDog)")
  print("Pet is cat: \(pet.isCat)")

  // MARK: - Custom Codable

  @CustomCodable
  struct CustomCodableString: Codable {

    @CodableKey(name: "OtherName")
    var propertyWithOtherName: String

    var propertyWithSameName: Bool

    func randomFunction() {

    }
  }

  let json = """
    {
      "OtherName": "Name",
      "propertyWithSameName": true
    }

    """.data(using: .utf8)!

  let jsonDecoder = JSONDecoder()
  let product = try! jsonDecoder.decode(CustomCodableString.self, from: json)
  print(product.propertyWithOtherName)

  // MARK: - Meta Enum

  // `@MetaEnum` adds a nested enum called `Meta` with the same cases, but no
  // associated values/payloads. Handy for e.g. describing a schema.
  @MetaEnum enum Value {
    case integer(Int)
    case text(String)
    case boolean(Bool)
    case null
  }

  print(Value.Meta(.integer(42)) == .integer)

  // MARK: - New Type

  @NewType(String.self)
  struct Hostname:
    NewTypeProtocol,
    Hashable,
    CustomStringConvertible
  {}

  @NewType(String.self)
  struct Password:
    NewTypeProtocol,
    Hashable,
    CustomStringConvertible
  {
    var description: String { "(redacted)" }
  }

  let hostname = Hostname("localhost")
  print("hostname: description=\(hostname) hashValue=\(hostname.hashValue)")

  let password = Password("squeamish ossifrage")
  print("password: description=\(password) hashValue=\(password.hashValue)")
}
