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

@_spi(Experimental) public struct LookupConfig {
  /// Specifies behavior of file scope.
  @_spi(Experimental) public var fileScopeHandling: FileScopeHandlingConfig
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
  @_spi(Experimental) public var finishInSequentialScope: Bool
  /// Specifies whether to include results generated in file and member block scopes.
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
  /// When looking up at the specified position with `includeMembers`
  /// set to `true`, lookup will return declaration from inside function body,
  /// function parameter and the `a` declaration from `class X` member block.
  /// If `includeMembers` would be set to `false`, the latter name would be omitted.
  @_spi(Experimental) public var includeMembers: Bool

  /// Creates a new lookup configuration.
  ///
  /// - `fileScopeHandling` - specifies behavior of file scope.
  ///   `memberBlockUpToLastDecl` by default.
  /// - `finishInSequentialScope` - specifies whether lookup should finish
  ///   in the closest sequential scope. `false` by default.
  /// - `includeMembers` - specifies whether to include results generated
  ///   in file and member block scopes. `true` by default.
  @_spi(Experimental) public init(
    fileScopeHandling: FileScopeHandlingConfig = .memberBlockUpToLastDecl,
    finishInSequentialScope: Bool = false,
    includeMembers: Bool = true
  ) {
    self.fileScopeHandling = fileScopeHandling
    self.finishInSequentialScope = finishInSequentialScope
    self.includeMembers = includeMembers
  }
}
