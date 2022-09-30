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
    guard let baseURL = try self.findEnclosingTestBundle() else {
      XCTFail("Unable to determine path to enclosing xctest bundle")
      return
    }

    try assertLinkage(of: "SwiftSyntax", in: baseURL, assertions: [
      .library("-lobjc"),
      .library("-lswiftCompatibility51", condition: .mayBeAbsent("Starting in Xcode 14 this library is not always autolinked")),
      .library("-lswiftCompatibility56", condition: .mayBeAbsent("Starting in Xcode 14 this library is not always autolinked")),
      .library("-lswiftCompatibilityConcurrency"),
      .library("-lswiftCore"),
      .library("-lswiftDarwin"),
      .library("-lswiftSwiftOnoneSupport", condition: .when(configuration: .debug)),
      .library("-lswift_Concurrency"),
      .library("-lswift_StringProcessing", condition: .mayBeAbsent("Starting in Xcode 14 this library is not always autolinked")),
    ])

    try assertLinkage(of: "SwiftParser", in: baseURL, assertions: [
      .library("-lobjc"),
      .library("-lswiftCompatibility51", condition: .mayBeAbsent("Starting in Xcode 14 this library is not always autolinked")),
      .library("-lswiftCompatibility56", condition: .mayBeAbsent("Starting in Xcode 14 this library is not always autolinked")),
      .library("-lswiftCompatibilityConcurrency"),
      .library("-lswiftCore"),
      .library("-lswiftSwiftOnoneSupport", condition: .when(configuration: .debug)),
      .library("-lswift_Concurrency"),
      .library("-lswift_StringProcessing", condition: .mayBeAbsent("Starting in Xcode 14 this library is not always autolinked")),
    ])
  }
}

extension LinkageTest {
  public struct MachHeader {
    var magic: UInt32
    var cputype: UInt32
    var cpusubtype: UInt32
    var filetype: UInt32
    var ncmds: UInt32
    var sizeofcmds: UInt32
    var flags: UInt32
    var reserved: UInt32

    public struct LoadCommand: OptionSet {
      public var rawValue: UInt32

      public init(rawValue: UInt32) {
        self.rawValue = rawValue
      }

      /// A load command that defines a list of linker options strings embedded
      /// directly into this file.
      public static let linkerOption = Self(rawValue: 0x2D)
    }
  }

  struct LoadCommand {
    var cmd: MachHeader.LoadCommand
    var cmdsize: UInt32
  }

  struct LinkerOptionCommand {
    var cmd: MachHeader.LoadCommand
    var cmdsize: UInt32
    var count: UInt32
    /* concatenation of zero terminated UTF8 strings.
     Zero filled at end to align */
  }
}

extension LinkageTest {
  private func assertLinkage(
    of library: String,
    in bundle: EnclosingTestBundle,
    assertions: [Linkage.Assertion]
  ) throws {
    let linkages = try bundle.objectFiles(for: library).reduce(into: []) { acc, next in
      acc += try self.extractAutolinkingHints(in: next)
    }

    let sortedLinkages = Set(linkages).sorted()
    var expectedLinkagesIdx = sortedLinkages.startIndex
    var assertions = assertions.makeIterator()
    while let assert = assertions.next() {
      // Evaluate the condition first, if any.
      if let condition = assert.condition, !condition.evaluate() {
        continue
      }

      // Make sure there's a linkage to even assert against. If not, then we've
      // got too many assertions and not enough link libraries. This isn't
      // always a bad thing, but it's worth calling out so we document this
      // with `.mayBeAbsent(...)`.
      guard expectedLinkagesIdx < sortedLinkages.endIndex else {
        // Skip flaky linkages if they're absent.
        if case .flaky = assert.condition {
          continue
        }

        XCTFail("Expected linkage was not present: \(assert.linkage)",
                file: assert.file, line: assert.line)
        continue
      }

      let linkage = sortedLinkages[expectedLinkagesIdx]

      // Check the linkage assertion. If it doesn't hold, the real fun begins.
      guard !assert.matches(linkage) else {
        expectedLinkagesIdx += 1
        continue
      }

      // Skip flaky linkages if they're absent.
      if case .flaky = assert.condition {
        continue
      }

      XCTFail("Expected linkage to \(assert.linkage), but recieved linkage to \(linkage.linkage); Perhaps linkage assertions are out of order?",
              file: assert.file, line: assert.line)
      expectedLinkagesIdx += 1
    }

    for superfluousLinkage in sortedLinkages[expectedLinkagesIdx..<sortedLinkages.endIndex] {
      XCTFail("Found unasserted link-time dependency: \(superfluousLinkage.linkage)")
    }
  }

  private enum EnclosingTestBundle {
    case incremental(URL)
    case unified(URL)

    func objectFiles(for library: String) throws -> [URL] {
      switch self {
      case .incremental(let baseURL):
        return [baseURL.appendingPathComponent(library + ".o")]
      case .unified(let baseURL):
        return try FileManager.default
          .contentsOfDirectory(at: baseURL.appendingPathComponent(library + ".build"),
                               includingPropertiesForKeys: nil)
          .filter({ $0.pathExtension == "o" })
      }
    }
  }

  private func findEnclosingTestBundle() throws -> EnclosingTestBundle? {
    for i in 0..<_dyld_image_count() {
      let name = try XCTUnwrap(_dyld_get_image_name(i))
      let path = String(cString: name)
      // We can wind up in SwiftParserTest.xctest when built via the IDE or
      // in SwiftSyntaxPackageTests.xctest when built at the command line
      // via the package manager.
      guard path.hasSuffix("SwiftParserTest") || path.hasSuffix("SwiftSyntaxPackageTests") else {
        continue
      }

      var baseURL = URL(fileURLWithPath: path)
      while !baseURL.pathComponents.isEmpty, baseURL.pathExtension != "xctest" {
        baseURL = baseURL.deletingLastPathComponent()
      }

      if baseURL.pathComponents.isEmpty {
        continue
      }

      let url = baseURL.deletingLastPathComponent()
      if path.hasSuffix("SwiftParserTest") {
        return .incremental(url)
      } else {
        return .unified(url)
      }
    }
    return nil
  }

  private func extractAutolinkingHints(in object: URL) throws -> [Linkage] {
    let data = try Data(contentsOf: object, options: .mappedIfSafe)
    assert(data.starts(with: [0xcf,0xfa,0xed,0xfe]), "Not a mach object file?")
    return data.withUnsafeBytes { (buf: UnsafeRawBufferPointer) -> [Linkage] in
      var result = [Linkage]()
      guard let base = buf.baseAddress else {
        return []
      }

      let hdr = base.bindMemory(to: MachHeader.self, capacity: 1)

      var commandStart = base + MemoryLayout<MachHeader>.size
      for _ in 0..<Int(hdr.pointee.ncmds) {
        let command = commandStart.load(as: LoadCommand.self)
        defer {
          commandStart = commandStart.advanced(by: Int(command.cmdsize))
        }

        switch command.cmd {
        case .linkerOption:
          let cmd = commandStart.bindMemory(to: LinkerOptionCommand.self, capacity: 1)
          let cmdCount = Int(cmd.pointee.count)
          let namePtr = commandStart.advanced(by: MemoryLayout<LinkerOptionCommand>.size).assumingMemoryBound(to: CChar.self)
          if cmdCount == 1 {
            result.append(.library(String(cString: namePtr)))
          } else if cmdCount == 2 {
            guard String(cString: namePtr) == "-framework" else {
              continue
            }

            let frameworkName = String(cString: namePtr.advanced(by: "-framework".utf8.count + 1))
            result.append(.framework(frameworkName))
          } else {
            XCTFail("Unexpected number of linker options: \(cmdCount)")
          }
        default:
          continue
        }
      }
      return result
    }
  }
}
#endif

fileprivate enum Linkage: Comparable, Hashable {
  case library(String)
  case framework(String)

  var linkage: String {
    switch self {
    case .library(let s): return s
    case .framework(let s): return s
    }
  }

  func hasPrefix(_ prefix: String) -> Bool {
    return self.linkage.hasPrefix(prefix)
  }
}

extension Linkage {
  fileprivate struct Assertion {
    var linkage: Linkage
    var condition: Condition?
    var file: StaticString
    var line: UInt

    func matches(_ linkage: Linkage) -> Bool {
      return self.linkage == linkage
    }

    static func library(_ linkage: String, condition: Condition? = nil, file: StaticString = #file, line: UInt = #line) -> Assertion {
      return Linkage.Assertion(linkage: .library(linkage), condition: condition, file: file, line: line)
    }

    static func framework(_ linkage: String, condition: Condition? = nil, file: StaticString = #file, line: UInt = #line) -> Assertion {
      return Linkage.Assertion(linkage: .framework(linkage), condition: condition, file: file, line: line)
    }
  }
}

extension Linkage.Assertion {
  fileprivate enum Condition {
    case swiftVersionAtLeast(versionBound: SwiftVersion)
    case configuration(ProductConfiguration)
    case flaky

    enum SwiftVersion: Comparable {
      case v5_5
      case v5_6
      case v5_7
      // We don't support compiling with <=5.4
    }

    enum ProductConfiguration: Equatable {
      case debug
      case release
    }

    fileprivate static func when(swiftVersionAtLeast version: SwiftVersion) -> Condition {
      return .swiftVersionAtLeast(versionBound: version)
    }

    fileprivate static func when(configuration: ProductConfiguration) -> Condition {
      return .configuration(configuration)
    }

    fileprivate static func mayBeAbsent(_ reason: StaticString) -> Condition {
      return .flaky
    }

    fileprivate func evaluate() -> Bool {
      switch self {
      case let .swiftVersionAtLeast(versionBound: bound):
#if swift(>=5.7)
        let version: SwiftVersion = .v5_7
#elseif swift(>=5.6)
        let version: SwiftVersion = .v5_6
#elseif swift(>=5.5)
        let version: SwiftVersion = .v5_5
#else
        #error("Swift version is too old!")
#endif
        return version >= bound
      case let .configuration(expectation):
#if DEBUG
        let config: ProductConfiguration = .debug
#else
        let config: ProductConfiguration = .release
#endif
        return config == expectation
      case .flaky:
        return true
      }
    }
  }
}
