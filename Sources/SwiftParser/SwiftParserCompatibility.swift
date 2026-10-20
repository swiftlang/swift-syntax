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

public import SwiftSyntax

// This file provides compatibility aliases to keep dependents of SwiftSyntax building.
// All users of the declarations in this file should transition away from them ASAP.

extension Parser {
  @_spi(ExperimentalLanguageFeatures)
  @available(*, deprecated, renamed: "LanguageFeatures")
  public typealias ExperimentalFeatures = LanguageFeatures

  @_spi(ExperimentalLanguageFeatures)
  @available(*, deprecated, renamed: "init(_:maximumNestingLevel:parseTransition:swiftVersion:languageFeatures:)")
  public init(
    _ input: String,
    maximumNestingLevel: Int? = nil,
    parseTransition: IncrementalParseTransition? = nil,
    swiftVersion: SwiftVersion? = nil,
    experimentalFeatures: LanguageFeatures
  ) {
    self.init(
      input,
      maximumNestingLevel: maximumNestingLevel,
      parseTransition: parseTransition,
      swiftVersion: swiftVersion,
      languageFeatures: experimentalFeatures
    )
  }

  @_spi(ExperimentalLanguageFeatures)
  @available(*, deprecated, renamed: "init(_:maximumNestingLevel:parseTransition:swiftVersion:languageFeatures:)")
  public init(
    _ input: UnsafeBufferPointer<UInt8>,
    maximumNestingLevel: Int? = nil,
    parseTransition: IncrementalParseTransition? = nil,
    swiftVersion: SwiftVersion? = nil,
    experimentalFeatures: LanguageFeatures
  ) {
    self.init(
      input,
      maximumNestingLevel: maximumNestingLevel,
      parseTransition: parseTransition,
      swiftVersion: swiftVersion,
      languageFeatures: experimentalFeatures
    )
  }

  @_spi(ExperimentalLanguageFeatures)
  @available(*, deprecated, renamed: "parse(source:maximumNestingLevel:swiftVersion:languageFeatures:)")
  public static func parse(
    source: String,
    maximumNestingLevel: Int? = nil,
    swiftVersion: SwiftVersion? = nil,
    experimentalFeatures: LanguageFeatures
  ) -> SourceFileSyntax {
    return parse(
      source: source,
      maximumNestingLevel: maximumNestingLevel,
      swiftVersion: swiftVersion,
      languageFeatures: experimentalFeatures
    )
  }

  @_spi(ExperimentalLanguageFeatures)
  @available(*, deprecated, renamed: "parse(source:maximumNestingLevel:swiftVersion:languageFeatures:)")
  public static func parse(
    source: UnsafeBufferPointer<UInt8>,
    maximumNestingLevel: Int? = nil,
    swiftVersion: SwiftVersion? = nil,
    experimentalFeatures: LanguageFeatures
  ) -> SourceFileSyntax {
    return parse(
      source: source,
      maximumNestingLevel: maximumNestingLevel,
      swiftVersion: swiftVersion,
      languageFeatures: experimentalFeatures
    )
  }
}

extension TokenSpec {
  @available(*, deprecated, renamed: "leftSquare")
  public static var leftSquareBracket: TokenSpec {
    return .leftSquare
  }

  @available(*, deprecated, renamed: "rightSquare")
  public static var rightSquareBracket: TokenSpec {
    return .rightSquare
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add a compatibility layer code here     //
// please insert it in alphabetical order above                             //
//==========================================================================//
