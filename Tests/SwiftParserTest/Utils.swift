@_spi(Testing) import SwiftParser

func withParser<T>(source: String, _ body: (inout Parser) throws -> T) rethrows -> T {
  var source = source
  return try source.withUTF8 { buffer in
    var parser = Parser(buffer)
    return try body(&parser)
  }
}

