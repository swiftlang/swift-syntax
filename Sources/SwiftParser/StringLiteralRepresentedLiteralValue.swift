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

#if compiler(>=6)
@_spi(RawSyntax) @_spi(BumpPtrAllocator) public import SwiftSyntax
#else
@_spi(RawSyntax) @_spi(BumpPtrAllocator) import SwiftSyntax
#endif

extension StringLiteralExprSyntax {

  /// Returns the string value of the literal as the parsed program would see
  /// it: Multiline strings are combined into one string, escape sequences are
  /// resolved.
  ///
  /// Returns nil if the literal contains interpolation segments, or if any
  /// segment contains a `\x{hh}` raw code unit escape -- such an escape may
  /// not represent a valid `Character`, so it cannot be losslessly folded
  /// into a `String`. Use `containsRawCodeUnitEscape` to distinguish that
  /// case from a literal that failed to parse at all, and
  /// `representedUncheckedLiteralCodeUnits(as:)` to decode a literal that
  /// contains raw code unit escapes.
  public var representedLiteralValue: String? {
    // Currently the implementation relies on properly parsed literals.
    guard !hasError else { return nil }
    guard let stringLiteralKind else { return nil }

    // Concatenate unescaped string literal segments. For example multiline
    // strings consist of multiple segments. Abort on finding string
    // interpolation.
    var result = ""
    for segment in segments {
      switch segment {
      case .stringSegment(let stringSegmentSyntax):
        let fullyRepresented = stringSegmentSyntax.appendUnescapedLiteralValue(
          stringLiteralKind: stringLiteralKind,
          delimiterLength: delimiterLength,
          to: &result
        )
        if !fullyRepresented {
          return nil
        }
      case .expressionSegment:
        // Bail out if there are any interpolation segments.
        return nil
      #if RESILIENT_LIBRARIES
      @unknown default:
        fatalError()
      #endif
      }
    }

    return result
  }

  /// Whether any segment of this literal contains a `\x{hh}` raw code unit
  /// escape. Such a literal always parses successfully -- this is not an
  /// error condition -- but `representedLiteralValue` cannot represent it
  /// and returns nil instead; use `representedUncheckedLiteralCodeUnits(as:)`
  /// to decode it.
  @_spi(Compiler)
  public var containsRawCodeUnitEscape: Bool {
    guard !hasError, let stringLiteralKind else { return false }

    for segment in segments {
      switch segment {
      case .stringSegment(let stringSegmentSyntax):
        if stringSegmentSyntax.containsRawCodeUnitEscape(
          stringLiteralKind: stringLiteralKind,
          delimiterLength: delimiterLength
        ) {
          return true
        }
      case .expressionSegment:
        continue
      #if RESILIENT_LIBRARIES
      @unknown default:
        fatalError()
      #endif
      }
    }

    return false
  }

  /// Decodes this literal into an array of raw code units of the requested
  /// width: text content and `\u{hh}` escapes are transcoded to `Element`'s
  /// width (UTF-8 for an 8-bit `Element`, UTF-16 for 16-bit, UCS-4/raw
  /// scalar values for 32-bit), and `\x{hh}` escapes are spliced in as
  /// literal `Element` values.
  ///
  /// Returns nil if the literal contains interpolation segments, failed to
  /// parse, if any `\x{hh}` escape's value doesn't fit in `Element`, or if
  /// `Element`'s width isn't one of the three supported above.
  ///
  /// This deliberately returns a plain array of code units rather than an
  /// `UncheckedString<Element>` -- swift-syntax cannot depend on that (or
  /// any other) target stdlib type.
  @_spi(Compiler)
  public func representedUncheckedLiteralCodeUnits<Element: FixedWidthInteger & UnsignedInteger>(
    as elementType: Element.Type
  ) -> [Element]? {
    guard Element.bitWidth == 8 || Element.bitWidth == 16 || Element.bitWidth == 32 else {
      return nil
    }
    guard !hasError else { return nil }
    guard let stringLiteralKind else { return nil }

    var result: [Element] = []
    for segment in segments {
      switch segment {
      case .stringSegment(let stringSegmentSyntax):
        guard
          stringSegmentSyntax.appendUncheckedLiteralCodeUnits(
            stringLiteralKind: stringLiteralKind,
            delimiterLength: delimiterLength,
            to: &result
          )
        else {
          return nil
        }
      case .expressionSegment:
        return nil
      #if RESILIENT_LIBRARIES
      @unknown default:
        fatalError()
      #endif
      }
    }

    return result
  }

  @_spi(Compiler)
  public func representedUncheckedLiteralCodeUnits() -> [UInt8]? {
    representedUncheckedLiteralCodeUnits(as: UInt8.self)
  }

  @_spi(Compiler)
  public func representedUncheckedLiteralCodeUnits() -> [UInt16]? {
    representedUncheckedLiteralCodeUnits(as: UInt16.self)
  }

  @_spi(Compiler)
  public func representedUncheckedLiteralCodeUnits() -> [UInt32]? {
    representedUncheckedLiteralCodeUnits(as: UInt32.self)
  }

  @_spi(Compiler)
  public var stringLiteralKind: StringLiteralKind? {
    switch openingQuote.tokenKind {
    case .stringQuote:
      return .singleLine
    case .multilineStringQuote:
      return .multiLine
    case .singleQuote:
      return .singleQuote
    default:
      return nil
    }
  }

  @_spi(Compiler)
  public var delimiterLength: Int {
    openingPounds?.text.count ?? 0
  }
}

extension StringSegmentSyntax {
  /// Appends this segment's decoded text to `output`.
  ///
  /// Returns `false` (and leaves `output` in an unspecified, partially
  /// appended state) if this segment contains a `\x{hh}` raw code unit
  /// escape, which cannot be represented as `Character`s.
  @_spi(Compiler)
  @discardableResult
  public func appendUnescapedLiteralValue(
    stringLiteralKind: StringLiteralKind,
    delimiterLength: Int,
    to output: inout String
  ) -> Bool {
    precondition(!hasError, "appendUnescapedLiteralValue relies on properly parsed literals")

    let rawText = content.rawText
    if !rawText.contains(where: { $0 == "\\" || $0 == "\r" }) {
      // Fast path. No escape sequence that need to be interpreted or line endings that need to be normalized to \n.
      output.append(String(syntaxText: rawText))
      return true
    }

    // The lexer's state stack spills into this allocator, so it has to outlive
    // `cursor` below rather than be a temporary of the `perform` call.
    let stateAllocator = BumpPtrAllocator(initialSlabSize: 256)
    return withExtendedLifetime(stateAllocator) {
      rawText.withBuffer { buffer in
        var cursor = Lexer.Cursor(input: buffer, previous: 0)

        // Put the cursor in the string literal lexing state. This is just
        // defensive as it's currently not used by `lexCharacterInStringLiteral`.
        let state = Lexer.Cursor.State.inStringLiteral(delimiterLength: delimiterLength, kind: stringLiteralKind)
        let transition = Lexer.StateTransition.push(newState: state)
        cursor.perform(stateTransition: transition, stateAllocator: stateAllocator)

        while true {
          let lex = cursor.lexCharacterInStringLiteral(
            stringLiteralKind: stringLiteralKind,
            delimiterLength: delimiterLength
          )

          switch lex {
          case .success(Unicode.Scalar("\r")):
            // Line endings in multi-line string literals are normalized to line feeds even if the source file has a
            // different encoding for new lines.
            output.append("\n")
            if cursor.peek() == "\n" {
              // If we have \r\n, eat the \n as well and leave
              let consumed = cursor.lexCharacterInStringLiteral(
                stringLiteralKind: stringLiteralKind,
                delimiterLength: delimiterLength
              )
              assert(consumed == .success(Unicode.Scalar("\n")))
            }
          case .success(let scalar),
            .validatedEscapeSequence(let scalar):
            output.append(Character(scalar))
          case .validatedRawEscapeSequence:
            // A raw code unit isn't necessarily a valid Character -- bail
            // rather than risk producing corrupted/misleading text.
            return false
          case .endOfString, .error:
            // We get an error at the end of the string because
            // `lexCharacterInStringLiteral` expects the closing quote.
            // We can assume the error just signals the end of string
            // because we made sure the token lexed fine before.
            return true
          }
        }
      }
    }
  }

  /// Returns whether this segment contains a `\x{hh}` raw code unit escape.
  @_spi(Compiler)
  public func containsRawCodeUnitEscape(
    stringLiteralKind: StringLiteralKind,
    delimiterLength: Int
  ) -> Bool {
    precondition(!hasError, "containsRawCodeUnitEscape relies on properly parsed literals")

    let rawText = content.rawText
    guard rawText.contains(where: { $0 == "\\" }) else {
      return false
    }

    return rawText.withBuffer { buffer in
      var cursor = Lexer.Cursor(input: buffer, previous: 0)

      let state = Lexer.Cursor.State.inStringLiteral(delimiterLength: delimiterLength, kind: stringLiteralKind)
      let transition = Lexer.StateTransition.push(newState: state)
      cursor.perform(stateTransition: transition, stateAllocator: BumpPtrAllocator(initialSlabSize: 256))

      while true {
        let lex = cursor.lexCharacterInStringLiteral(
          stringLiteralKind: stringLiteralKind,
          delimiterLength: delimiterLength
        )

        switch lex {
        case .validatedRawEscapeSequence:
          return true
        case .endOfString, .error:
          return false
        default:
          continue
        }
      }
    }
  }

  /// Appends this segment's decoded content to `output` as raw code units
  /// of `Element`'s width. See
  /// `StringLiteralExprSyntax.representedUncheckedLiteralCodeUnits(as:)`.
  ///
  /// Returns `false` (and leaves `output` in an unspecified, partially
  /// appended state) if a `\x{hh}` escape's value doesn't fit in `Element`.
  /// `Element`'s width is assumed to already be one of the three supported
  /// widths; the caller is responsible for checking that.
  @_spi(Compiler)
  public func appendUncheckedLiteralCodeUnits<Element: FixedWidthInteger & UnsignedInteger>(
    stringLiteralKind: StringLiteralKind,
    delimiterLength: Int,
    to output: inout [Element]
  ) -> Bool {
    precondition(!hasError, "appendUncheckedLiteralCodeUnits relies on properly parsed literals")

    let rawText = content.rawText
    return rawText.withBuffer { buffer in
      var cursor = Lexer.Cursor(input: buffer, previous: 0)

      let state = Lexer.Cursor.State.inStringLiteral(delimiterLength: delimiterLength, kind: stringLiteralKind)
      let transition = Lexer.StateTransition.push(newState: state)
      cursor.perform(stateTransition: transition, stateAllocator: BumpPtrAllocator(initialSlabSize: 256))

      while true {
        let lex = cursor.lexCharacterInStringLiteral(
          stringLiteralKind: stringLiteralKind,
          delimiterLength: delimiterLength
        )

        switch lex {
        case .success(Unicode.Scalar("\r")):
          // Line endings in multi-line string literals are normalized to line feeds even if the source file has a
          // different encoding for new lines.
          output.append(contentsOf: codeUnits(for: "\n", as: Element.self))
          if cursor.peek() == "\n" {
            // If we have \r\n, eat the \n as well and leave
            let consumed = cursor.lexCharacterInStringLiteral(
              stringLiteralKind: stringLiteralKind,
              delimiterLength: delimiterLength
            )
            assert(consumed == .success(Unicode.Scalar("\n")))
          }
        case .success(let scalar),
          .validatedEscapeSequence(let scalar):
          output.append(contentsOf: codeUnits(for: scalar, as: Element.self))
        case .validatedRawEscapeSequence(let rawValue):
          guard UInt64(rawValue) <= UInt64(Element.max) else {
            return false
          }
          output.append(Element(rawValue))
        case .endOfString, .error:
          // We get an error at the end of the string because
          // `lexCharacterInStringLiteral` expects the closing quote.
          // We can assume the error just signals the end of string
          // because we made sure the token lexed fine before.
          return true
        }
      }
    }
  }

  /// A `\x{hh}` escape found while decoding a segment's escapes into UTF-8
  /// bytes via `appendUnescapedUTF8Value`. Mirrors the C++ lexer's
  /// `Lexer::RawCodeUnitEscape`.
  @_spi(Compiler)
  public struct RawCodeUnitEscape {
    /// The UTF-8 byte offset within the decoded output at which the
    /// placeholder U+FFFD was written.
    public let offset: Int

    /// The byte offset of the escape within this segment's raw source text,
    /// i.e. relative to `content.positionAfterSkippingLeadingTrivia`.
    public let sourceOffset: Int

    /// The escape's raw value.
    public let value: UInt32
  }

  /// Appends this segment's decoded text to `output` as UTF-8 bytes,
  /// writing a U+FFFD replacement character at each `\x{hh}` raw code unit
  /// escape and recording it in `rawEscapes` -- mirroring how the C++
  /// lexer's `getEncodedStringSegmentImpl` handles the same escape, so
  /// splice-oblivious consumers of `output` still see a visible marker
  /// rather than silently wrong or corrupted text. Unlike
  /// `appendUnescapedLiteralValue`, this never bails out on a raw escape.
  @_spi(Compiler)
  public func appendUnescapedUTF8Value(
    stringLiteralKind: StringLiteralKind,
    delimiterLength: Int,
    to output: inout [UInt8],
    rawEscapes: inout [RawCodeUnitEscape]
  ) {
    precondition(!hasError, "appendUnescapedUTF8Value relies on properly parsed literals")

    let rawText = content.rawText
    if !rawText.contains(where: { $0 == "\\" || $0 == "\r" }) {
      output.append(contentsOf: rawText)
      return
    }

    rawText.withBuffer { buffer in
      let bufferStart = Lexer.Cursor(input: buffer, previous: 0)
      var cursor = bufferStart

      let state = Lexer.Cursor.State.inStringLiteral(delimiterLength: delimiterLength, kind: stringLiteralKind)
      let transition = Lexer.StateTransition.push(newState: state)
      cursor.perform(stateTransition: transition, stateAllocator: BumpPtrAllocator(initialSlabSize: 256))

      while true {
        let escapeStart = cursor
        let lex = cursor.lexCharacterInStringLiteral(
          stringLiteralKind: stringLiteralKind,
          delimiterLength: delimiterLength
        )

        switch lex {
        case .success(Unicode.Scalar("\r")):
          // Line endings in multi-line string literals are normalized to line feeds even if the source file has a
          // different encoding for new lines.
          output.append(contentsOf: "\n".utf8)
          if cursor.peek() == "\n" {
            // If we have \r\n, eat the \n as well and leave
            let consumed = cursor.lexCharacterInStringLiteral(
              stringLiteralKind: stringLiteralKind,
              delimiterLength: delimiterLength
            )
            assert(consumed == .success(Unicode.Scalar("\n")))
          }
        case .success(let scalar),
          .validatedEscapeSequence(let scalar):
          output.append(contentsOf: String(scalar).utf8)
        case .validatedRawEscapeSequence(let rawValue):
          rawEscapes.append(
            RawCodeUnitEscape(
              offset: output.count,
              sourceOffset: bufferStart.distance(to: escapeStart),
              value: rawValue
            )
          )
          // U+FFFD, encoded as UTF-8: EF BF BD.
          output.append(contentsOf: [0xEF, 0xBF, 0xBD])
        case .endOfString, .error:
          // We get an error at the end of the string because
          // `lexCharacterInStringLiteral` expects the closing quote.
          // We can assume the error just signals the end of string
          // because we made sure the token lexed fine before.
          return
        }
      }
    }
  }
}

/// Encodes `scalar` as code units of `Element`'s width: UTF-8 for an 8-bit
/// `Element`, UTF-16 for 16-bit, or the scalar's raw value for 32-bit
/// (UCS-4). `Element`'s width is assumed to already be one of these three;
/// the caller is responsible for checking that.
private func codeUnits<Element: FixedWidthInteger & UnsignedInteger>(
  for scalar: Unicode.Scalar,
  as elementType: Element.Type
) -> [Element] {
  switch Element.bitWidth {
  case 8:
    return String(scalar).utf8.map { Element($0) }
  case 16:
    return String(scalar).utf16.map { Element($0) }
  default:
    return [Element(scalar.value)]
  }
}
