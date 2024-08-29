//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public protocol SyntaxNodeKindProtocol: TypeConvertible {
  associatedtype Raw: SyntaxNodeKindProtocol
  associatedtype NonRaw: SyntaxNodeKindProtocol

  /// The raw representation of this kind.
  var raw: Raw { get }

  /// The non-raw representation of this kind.
  var nonRaw: NonRaw { get }

  /// The name of this kind in proper case.
  var nameInProperCase: String { get }
}
