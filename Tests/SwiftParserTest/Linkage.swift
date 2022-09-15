#if canImport(Darwin)
import Darwin
import XCTest

final class LinkageTest: XCTestCase {
  // Assert that SwiftSyntax and SwiftParser do not introduce more link-time
  // dependencies than are strictly necessary. We want to minimize our link-time
  // dependencies. If this set changes - in particular, if it grows - consult
  // a SwiftSyntax maintainer to see if there's a way to avoid adding the
  // dependency.
  func testLinkage() throws {
    for i in 0..<_dyld_image_count() {
      let name = try XCTUnwrap(_dyld_get_image_name(i))
      let path = String(cString: name)
      guard path.hasSuffix("SwiftParserTest") else {
        continue
      }

      var baseURL = URL(fileURLWithPath: path)
      while !baseURL.pathComponents.isEmpty, baseURL.pathExtension != "xctest" {
        baseURL = baseURL.deletingLastPathComponent()
      }

      if baseURL.pathComponents.isEmpty {
        XCTFail("Unable to determine path to enclosing xctest bundle")
        return
      }

      baseURL = baseURL.deletingLastPathComponent()
      let swiftSyntaxURL = baseURL.appendingPathComponent("SwiftSyntax.o")
      try assertLinkage(of: swiftSyntaxURL) { linkages in
        XCTAssertEqual(linkages, [
          .library("-lobjc"),
          .library("-lswiftCompatibilityConcurrency"),
          .library("-lswiftCore"),
          .library("-lswiftDarwin"),
          .library("-lswiftSwiftOnoneSupport"),
          .library("-lswift_Concurrency"),
        ])
      }
      let swiftParserURL = baseURL.appendingPathComponent("SwiftParser.o")
      try assertLinkage(of: swiftParserURL) { linkages in
        XCTAssertEqual(linkages, [
          .library("-lobjc"),
          .library("-lswiftCompatibilityConcurrency"),
          .library("-lswiftCore"),
          .library("-lswiftDarwin"),
          .library("-lswiftSwiftOnoneSupport"),
          .library("-lswift_Concurrency"),
        ])
      }
    }
  }

  private enum Linkage: Comparable {
    case library(String)
    case framework(String)
  }

  private func readLoadCommands(in object: URL) throws -> [String] {
    let result = Process()
    result.executableURL = try XCTUnwrap(URL(fileURLWithPath: "/usr/bin/xcrun"))
    result.arguments = [
      "otool", "-l", object.path,
    ]
    let outputPipe = Pipe()
    let errorPipe = Pipe()

    result.standardOutput = outputPipe
    result.standardError = errorPipe
    try result.run()
    result.waitUntilExit()
    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(decoding: outputData, as: UTF8.self)
    return output.components(separatedBy: .newlines)
  }

  private func assertLinkage(of object: URL, assertion: ([Linkage]) throws -> Void) throws {
    var linkages = [Linkage]()
    var lines = try self.readLoadCommands(in: object).makeIterator()
    while let line = lines.next() {
      guard line.starts(with: "Load command") else {
        continue
      }

      guard
        let command = lines.next(),
        command.hasSuffix("LC_LINKER_OPTION"),
        let _ = lines.next(),
        let count = lines.next()
      else {
        continue
      }

      let countString = count.trimmingCharacters(in: .whitespaces)
        .suffix(from: count.index(count.startIndex, offsetBy: "count ".count))
      guard let count = Int(countString), count == 1 || count == 2 else {
        XCTFail("Malformed load command: \(line)")
        return
      }

      if count == 1 {
        guard let library = lines.next() else {
          XCTFail("No load command payload: \(line)")
          return
        }

        let linkLibrary = library.trimmingCharacters(in: .whitespaces)
          .suffix(from: library.index(library.startIndex, offsetBy: "string #1 ".count))
        linkages.append(.library(String(linkLibrary)))
      } else {
        assert(count == 2)
        guard
          let frameworkArg = lines.next(),
          frameworkArg.trimmingCharacters(in: .whitespaces) == "string #1 -framework",
          let framework = lines.next()
        else {
          XCTFail("No load command payload: \(line)")
          return
        }

        let linkedFramework = framework.trimmingCharacters(in: .whitespaces)
          .suffix(from: framework.index(framework.startIndex, offsetBy: "string #2 ".count))
        linkages.append(.framework(String(linkedFramework)))
      }
    }
    return try assertion(linkages.sorted())
  }
}
#endif
