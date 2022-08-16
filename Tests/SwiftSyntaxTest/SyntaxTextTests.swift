import XCTest
@_spi(RawSyntax) import SwiftSyntax

final class SyntaxTextTests: XCTestCase {
  func testLiteral() throws {
    let strBasic: SyntaxText = "foobar"
    let strASCII: SyntaxText = "A"
    let strHiragana: SyntaxText = "ら"
    let strEmojiSingle: SyntaxText = "🤖"
    let strUTF8: SyntaxText = "こんにちは世界！"

    XCTAssertEqual(String(syntaxText: strBasic), String("foobar"))
    XCTAssertEqual(String(syntaxText: strASCII), String("A"))
    XCTAssertEqual(String(syntaxText: strHiragana), String("ら"))
    XCTAssertEqual(String(syntaxText: strEmojiSingle), String("🤖"))
    XCTAssertEqual(String(syntaxText: strUTF8), String("こんにちは世界！"))
  }

  func testInvalid() throws {
    let invalidUTF8: [UInt8] = [0x43, 0x61, 0x66, 0xC3]
    invalidUTF8.withUnsafeBufferPointer { buffer in
      let fromData = SyntaxText(baseAddress: buffer.baseAddress, count: buffer.count)
      XCTAssertEqual(String(syntaxText: fromData), "Caf\u{FFFD}")
    }
  }

  func testSlice() throws {
    let text: SyntaxText = "0123456789"

    let slice1 = SyntaxText(rebasing: text[0..<4])
    let slice2 = SyntaxText(rebasing: text[0..<text.count])
    let slice3 = SyntaxText(rebasing: text[3..<text.count])
    XCTAssert(slice1.isSlice(of: text))
    XCTAssert(slice2.isSlice(of: text))
    XCTAssert(slice3.isSlice(of: text))
    XCTAssertNotNil(text.firstRange(of: slice1))
    XCTAssertNotNil(text.firstRange(of: slice2))
    XCTAssertNotNil(text.firstRange(of: slice3))

    let empty: SyntaxText = ""
    let emptySlice: SyntaxText = SyntaxText(rebasing: empty[...])
    XCTAssertTrue(emptySlice.isSlice(of: empty))
    XCTAssertEqual(emptySlice, "")

    XCTAssertEqual(SyntaxText(rebasing: text[2..<2]), SyntaxText(rebasing: text[3..<3]))
  }

  func testEmptyCompare() throws {
    let text: SyntaxText = "0123456789"

    let emptyDefault = SyntaxText()
    let emptyStatic: SyntaxText = ""
    let emptySlice1 = SyntaxText(rebasing: text[1..<1])
    let emptySlice2 =  SyntaxText(rebasing: text[6..<6])

    XCTAssertTrue(emptyDefault.baseAddress == nil && emptyDefault.isEmpty)
    XCTAssertTrue(emptyStatic.baseAddress != nil && emptyStatic.isEmpty)
    XCTAssertTrue(emptySlice1.baseAddress != nil && emptySlice1.isEmpty)
    XCTAssertTrue(emptySlice2.baseAddress != nil && emptySlice2.isEmpty)

    XCTAssertTrue(emptyDefault == emptyDefault)
    XCTAssertTrue(emptyDefault == emptyStatic)
    XCTAssertTrue(emptyDefault == emptySlice1)
    XCTAssertTrue(emptyDefault == emptySlice2)

    XCTAssertTrue(emptyStatic == emptyDefault)
    XCTAssertTrue(emptyStatic == emptyStatic)
    XCTAssertTrue(emptyStatic == emptySlice1)
    XCTAssertTrue(emptyStatic == emptySlice2)

    XCTAssertTrue(emptySlice1 == emptyDefault)
    XCTAssertTrue(emptySlice1 == emptyStatic)
    XCTAssertTrue(emptySlice1 == emptySlice1)
    XCTAssertTrue(emptySlice1 == emptySlice2)

    XCTAssertTrue(emptySlice2 == emptyDefault)
    XCTAssertTrue(emptySlice2 == emptyStatic)
    XCTAssertTrue(emptySlice2 == emptySlice1)
    XCTAssertTrue(emptySlice2 == emptySlice2)
  }

  func testFirstRange() throws {
    let text: SyntaxText = "0123456789012345"

    XCTAssertEqual(text.firstRange(of: ""), nil)
    XCTAssertEqual(text.firstRange(of: SyntaxText(rebasing: SyntaxText("012")[1..<1])), nil)
    XCTAssertEqual(text.firstRange(of: "abc"), nil)
    XCTAssertEqual(text.firstRange(of: "01234567890123456"), nil)

    XCTAssertEqual(text.firstRange(of: "0"), 0 ..< 1)
    XCTAssertEqual(text.firstRange(of: "1"), 1 ..< 2)
    XCTAssertEqual(text.firstRange(of: "5"), 5 ..< 6)
    XCTAssertEqual(text.firstRange(of: "012"), 0 ..< 3)
    XCTAssertEqual(text.firstRange(of: "234"), 2 ..< 5)
    XCTAssertEqual(text.firstRange(of: "9012345"), 9 ..< 16)

    XCTAssertEqual(SyntaxText(rebasing: text[2..<12]).firstRange(of: "123"), nil)
    XCTAssertEqual(SyntaxText(rebasing: text[5...]).firstRange(of: "5"), 0 ..< 1)
    XCTAssertEqual(SyntaxText(rebasing: text[5...]).firstRange(of: "0"), 5 ..< 6)
  }

  func testContains() throws {
    let text: SyntaxText = "0123456789012345"
    XCTAssertTrue(text.contains("123"))
    XCTAssertTrue(text.contains("0123456789012345"))
    XCTAssertTrue(text.contains("9012345"))

    XCTAssertFalse(text.contains(""))
    XCTAssertFalse(text.contains("foo"))
    XCTAssertFalse(text.contains("01234567890123456"))
  }

  func testHasPrefixSuffix() throws {
    let text: SyntaxText = "0123456789012345"

    XCTAssertTrue(text.hasPrefix(""))
    XCTAssertTrue(text.hasPrefix("0"))
    XCTAssertTrue(text.hasPrefix("0123"))
    XCTAssertTrue(text.hasPrefix("0123456789012345"))
    XCTAssertFalse(text.hasPrefix("345"))
    XCTAssertFalse(text.hasPrefix("abc"))

    XCTAssertTrue(text.hasSuffix(""))
    XCTAssertTrue(text.hasSuffix("5"))
    XCTAssertTrue(text.hasSuffix("12345"))
    XCTAssertTrue(text.hasSuffix("0123456789012345"))
    XCTAssertFalse(text.hasSuffix("012"))
    XCTAssertFalse(text.hasSuffix("abc"))
  }

  func testWithSyntaxText() throws {
    var str = "Lorem ipsum"
    str.withSyntaxText { text in
      XCTAssertEqual(SyntaxText(rebasing: text[0..<5]), "Lorem")
      XCTAssertEqual(SyntaxText(rebasing: text[6..<9]), "ips")
    }
  }
}

