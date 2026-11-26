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

import SwiftIfConfig

public struct LookupConfig {
  /// Specifies whether lookup should finish in the closest sequential scope.
  ///
  /// ### Example
  /// ```swift
  /// class X {
  ///   let a = 42
  ///
  ///   func (a: Int) {
  ///     let a = 123
  ///
  ///     a // <-- lookup here
  ///   }
  /// }
  /// ```
  /// When looking up at the specified position with `finishInSequentialScope`
  /// set to `false`, lookup will return declaration from inside function body,
  /// function parameter and the `a` declaration from `class X` member block.
  /// If `finishInSequentialScope` would be set to `false`, the only name
  /// returned by lookup would be the `a` declaration from inside function body.
  public var finishInSequentialScope: Bool
  public var configuredRegions: ConfiguredRegions?
  /// Documentated at internal init
  internal var _lookupTopScope: Bool = false
  /// Doesn't return `.lookForGenericParameters` for the extended type
  /// of an extension.
  ///
  /// This flag should likely be removed and become the default behavior.
  ///
  /// For instance, if we turn on `_dontFindGenericParametersForExtendedType`:
  /// ```
  /// extension A where // <- Looking up `A` here doesn't look for generic parameters
  ///                   //    of the extended type `A`
  ///   T == Int // <- Looking up `T` here *will* look for generic parameters of `A`
  /// { ... }
  /// ```
  /// If the flag is off, looking up `A` in `extension A` will also tell us to
  /// look for generic parameters of `A` (the very syntax we're looking up).
  internal var _dontFindGenericParametersForExtendedType: Bool = false

  /// Creates a new lookup configuration.
  ///
  /// - `finishInSequentialScope` - specifies whether lookup should finish
  ///   in the closest sequential scope. `false` by default.
  public init(
    finishInSequentialScope: Bool = false,
    configuredRegions: ConfiguredRegions? = nil
  ) {
    self.finishInSequentialScope = finishInSequentialScope
    self.configuredRegions = configuredRegions
  }

  /// Creates a new lookup configuration, setting `_lookupTopScope`.
  ///
  /// - `finishInSequentialScope` - specifies whether lookup should finish
  ///   in the closest sequential scope. `false` by default.
  /// - `_lookupTopScope` - Whether the top-level scope (SourceFileSyntax) introduces name
  ///   to the lookup (other than what's introduced from guard statements).
  /// - `_dontFindGenericParametersForExtendedType`: Whether we should avoid
  ///   returning generic parameters for lookup initiated in an extension's
  ///   extended-type syntax.
  @_spi(Experimental) public init(
    finishInSequentialScope: Bool = false,
    configuredRegions: ConfiguredRegions? = nil,
    _lookupTopScope: Bool,
    _dontFindGenericParametersForExtendedType: Bool
  ) {
    self.finishInSequentialScope = finishInSequentialScope
    self.configuredRegions = configuredRegions
    self._lookupTopScope = _lookupTopScope
    self._dontFindGenericParametersForExtendedType = _dontFindGenericParametersForExtendedType
  }
}
