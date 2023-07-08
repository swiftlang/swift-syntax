//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// How to choose `assert` vs. `precondition`:
///  - Wherever possible, it is preferable to emit a diagnostic instead of
///    using `precondition`. This way the parser won't crash if the condition is
///    violated.
///  - If you think the diagnostic added above should never be emitted, it is
///    fine to also emit an `assertionFailure` in debug builds to make it easier
///    to debug the unexpected diagnostic.
///  - If in doubt always use `precondition`
///  - `assert` should only be used if checking the assertion has a non-trivial
///    cost and provides little benefit in terms of safety in release builds.

// MARK: - Assert

/// An assertion that is active in DEBUG builds, just like `Swift.assert` and
/// additionally if assertions are explicitly requested by setting the
/// `SWIFTSYNTAX_ENABLE_ASSERTIONS` conditional compilation flag.
/// Use this instead of `precondition` in places where the assertion has a
/// non-trivial cost but provides little value in release builds.
@_transparent
public func assert(
  _ condition: @autoclosure () -> Bool,
  _ message: @autoclosure () -> String = String(),
  file: StaticString = #file,
  line: UInt = #line
) {
  #if SWIFTSYNTAX_ENABLE_ASSERTIONS
  if !_fastPath(condition()) {
    fatalError(message(), file: file, line: line)
  }
  #else
  Swift.assert(condition(), message(), file: file, line: line)
  #endif
}

/// An assertion that is active in DEBUG builds, just like
/// `Swift.assertionFailure` and additionally if assertions are explicitly
/// requested by setting the `SWIFTSYNTAX_ENABLE_ASSERTIONS` conditional
/// compilation flag.
@_transparent
public func assertionFailure(
  _ message: @autoclosure () -> String = String(),
  file: StaticString = #file,
  line: UInt = #line
) {
  #if SWIFTSYNTAX_ENABLE_ASSERTIONS
  fatalError(message(), file: file, line: line)
  #else
  Swift.assertionFailure(message(), file: file, line: line)
  #endif
}

// MARK: - Precondition

/// Override Swift’s `precondition` with slightly changed semantics.
/// In release builds, it also emits the error message upon failure, like `fatalError`.
/// It can also be disabled by setting the `SWIFTSYNTAX_DISABLE_PRECONDITION` conditional compilation flag.
/// Note that `SWIFTSYNTAX_DISABLE_PRECONDITION` does not disable `preconditionFailure`.
@_transparent
public func precondition(
  _ condition: @autoclosure () -> Bool,
  _ message: @autoclosure () -> String = String(),
  file: StaticString = #file,
  line: UInt = #line
) {
  #if !SWIFTSYNTAX_DISABLE_PRECONDITIONS
  if !_fastPath(condition()) {
    fatalError(message(), file: file, line: line)
  }
  #endif
}
