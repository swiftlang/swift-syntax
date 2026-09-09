//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftIfConfig
import SwiftSyntax

/// The symbol table drives lookup. Given a collection of files, their modules,
/// and the build configuration, it can resolve type syntax by correctly
/// tracking types and their extensions.
@_spi(_QualifiedLookupTests)
public final class SymbolTable {
  /// The "internal" module.
  public let moduleName: ModuleName
  /// Invariants:
  /// 1. moduleToSources[moduleName] != nil
  /// 2. Each `SourceFileSyntax` is unique (across modules)
  public let moduleToSources: [ModuleName: [String: SourceFileSyntax]]
  /// The build configuration used for lookups in the symbol table's files.
  public let buildConfiguration: any BuildConfiguration
  /// Useful map for finding a file's name, configured regions and module in constant time.
  private let fileToInfo: [SourceFileSyntax: FileInfo]

  /// Tracks requested extensions for extension binding.
  var requestedExtensions: RequestedExtensions

  // TODO: Setter should be private
  /// A graph that keeps tracks of types and their extensions.
  public internal(set) var typeGraph = TypeGraph()

  // Logging/debug properties
  let _verbose: Bool = false
  let _logNestingLimit: Int? = nil
  var logPrefix = [String]()

  private init(
    moduleName: ModuleName,
    moduleToSources: [ModuleName: [String: SourceFileSyntax]],
    buildConfiguration: any BuildConfiguration,
    fileToInfo: [SourceFileSyntax: FileInfo]
  ) {
    self.moduleName = moduleName
    self.moduleToSources = moduleToSources
    self.buildConfiguration = buildConfiguration
    self.fileToInfo = fileToInfo
    self.requestedExtensions = RequestedExtensions(fileToInfo: fileToInfo)
  }
}

extension SymbolTable {
  public convenience init?(
    moduleName: ModuleName,
    moduleToSources: [ModuleName: [String: SourceFileSyntax]],
    buildConfiguration: any BuildConfiguration
  ) {
    // Uphold invariant that `moduleToSources[moduleName] != nil`
    guard moduleToSources[moduleName] != nil else { return nil }

    var fileToInfo = [SourceFileSyntax: FileInfo]()
    for (module, sources) in moduleToSources {
      for (fileName, fileSyntax) in sources {
        let configuredRegions = fileSyntax.configuredRegions(in: buildConfiguration)
        let oldFileInfo = fileToInfo.updateValue(
          FileInfo(name: fileName, configuredRegions: configuredRegions, module: module),
          forKey: fileSyntax
        )
        // We can't have duplicate files
        if oldFileInfo != nil { return nil }
      }
    }

    self.init(
      moduleName: moduleName,
      moduleToSources: moduleToSources,
      buildConfiguration: buildConfiguration,
      fileToInfo: fileToInfo
    )
  }
}

// MARK: File Info

/// Useful information about a file registered in the symbol table:
/// the file name, its configured regions based on the symbol table's
/// `buildConfiguration`, and the module name.
internal struct FileInfo {
  let name: String
  let configuredRegions: ConfiguredRegions
  let module: ModuleName
}

extension SymbolTable {
  func getFileInfo(
    _ fileSyntax: SourceFileSyntax
  ) -> FileInfo? {
    fileToInfo[fileSyntax]
  }
}

// MARK: Type Resolution

extension SymbolTable {
  public func resolve(
    typeSyntax: Attached<TypeSyntax>
  ) -> TypeResolver.TypeResult {
    var typeResolver = TypeResolver(symbolTable: self)
    return typeResolver.resolve(typeSyntax: typeSyntax)
  }
}

// MARK: Logging

extension SymbolTable {
  func log(_ component: Any, file: StaticString = #file, line: UInt = #line) {
    #if DEBUG
    guard _verbose else { return }
    // Calculate log text
    let newLine = "\(logPrefix.map({ "[\($0)]" }).joined()) \(component)\n"
    // Print new line
    print(newLine)
    #endif
  }

  func withLogging<T>(
    request: String,
    describe: (T) -> String,
    perform action: (_ mutableSelf: borrowing SymbolTable) -> T,
    file: StaticString = #file,
    line: UInt = #line
  ) -> T {
    if let nestingLimit = self._logNestingLimit, logPrefix.count >= nestingLimit {
      fatalError(
        "Exceeded log nesting limit of \(nestingLimit), suggesting there's an infinite loop. If you think this is a mistake, you may change the limit in `TypeQualifier`."
      )
    }
    logPrefix.append(request)
    log("Resolving...", file: file, line: line)
    let result = action(self)
    log("Resolved \(describe(result))", file: file, line: line)
    logPrefix.removeLast()
    return result
  }
}
