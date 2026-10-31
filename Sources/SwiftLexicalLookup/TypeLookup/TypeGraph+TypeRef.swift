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

// MARK: GlobalTypeName

extension TypeGraph {
  /// A global type name, `Swift::Int._(MyFileA.swift)::MyType`.
  /// Used by `TypeGraph` as unique identifier for types.
  ///
  /// ### File-Name Specifier
  ///
  /// We use the '_(FileName.swift)::MyType' notation to describe
  /// an internal type declared in 'FileName.swift'. This notation
  /// gives us an unambiguous way to refer to types of the same name
  /// in our module. Types exposed as public/usable-from-inline
  /// from an external module should have a unique name. Also, types
  /// of the same name within the same file are invalid redeclarations.
  @_spi(_QualifiedLookupTests)
  public struct GlobalTypeName: Sendable, Hashable {
    public enum Qualifier: Sendable, Hashable {
      // E.g. 'File.swift' or 'Subdirectory/OtherFile.swift'
      case `internal`(fileID: String)
      case external(moduleName: String)
    }
    /// A component of a qualified type name, external or internal. For instance,
    /// `Swift::Int` (external) and `_(FileA.swift)::MyType` (internal).
    public struct Component: Sendable, Hashable {
      private let qualifier: Qualifier
      private let name: String

      fileprivate init(qualifier: TypeGraph.GlobalTypeName.Qualifier, name: String) {
        self.qualifier = qualifier
        self.name = name
      }
    }

    /// The type's components.
    /// Invariant: `components.count >= 1`
    public private(set) var components: [Component]

    /// Creates a a global type with the given components; returns `nil` if no
    /// components are provided
    private init?(_components: [Component]) {
      guard !_components.isEmpty else { return nil }
      self.components = _components
    }

    var base: GlobalTypeName? {
      GlobalTypeName(_components: components.dropLast())
    }
  }
}

// MARK: Name Construction

extension TypeGraph.GlobalTypeName.Qualifier {
  fileprivate init(file: SourceFileSyntax, fileInfo: FileInfo, internalModule: Identifier) {
    if fileInfo.module == internalModule {
      self = .internal(fileID: fileInfo.name)
    } else {
      self = .external(moduleName: fileInfo.module.name)
    }
  }
}

extension TypeGraph.GlobalTypeName.Component {
  /// Creates a component named `name` in the file `file` in the module `module`
  /// with respect to the given symbol table.
  ///
  /// Important: The file and module must be mapped as such in the symbol table.
  init(
    name: Identifier,
    file: SourceFileSyntax,
    fileInfo: FileInfo,
    symbolTable: borrowing SymbolTable
  ) {
    assert(
      symbolTable.getFileInfo(file)?.module == fileInfo.module,
      "[SwiftLexicalLookup] Internal error: File registered under '\(String(describing: symbolTable.getFileInfo(file)))', and not the given file info '\(fileInfo)'"
    )

    self.init(
      qualifier: TypeGraph.GlobalTypeName.Qualifier(
        file: file,
        fileInfo: fileInfo,
        internalModule: symbolTable.moduleName
      ),
      name: name.name
    )
  }
}

extension TypeGraph.GlobalTypeName {
  /// Creates a a global type with the given component.
  init(component: Component) {
    // Upholds the invariant because we provide exactly one component
    self.components = [component]
  }

  /// Creates a mock name for types declared in the internal file `fileID`
  /// without checking it against a `SymbolTable`; only use for tests.
  ///
  /// E.g. `["A", "B"]` gives `_(fileID)::A._(fileID)::B`.
  ///
  /// Precondition: `names` isn't empty.
  @_spi(_QualifiedLookupTests)
  public init(_uncheckedInternalNames names: [String], fileID: String) {
    self.init(
      _components: names.map({ Component(qualifier: .internal(fileID: fileID), name: $0) })
    )!
  }

  /// Adds the given component to a type name to get the name of a nested type.
  public func addingComponent(_ tailComponent: Component) -> TypeGraph.GlobalTypeName {
    var copy = self
    // Maintains the invariant, as we're just adding a component.
    copy.components.append(tailComponent)
    return copy
  }
}

// MARK: Type Ref

extension TypeGraph {
  /// A reference to a resolved global nominal type vended by `TypeGraph`.
  /// Contains the unique name and resolved main declaration.
  @_spi(_QualifiedLookupTests)
  public struct GlobalTypeRef: Hashable, Sendable {
    let name: GlobalTypeName
    let mainDecl: Attached<NominalTypeDeclSyntax>
    let _version: Int

    @_spi(_QualifiedLookupTests)
    public init(name: GlobalTypeName, mainDecl: Attached<NominalTypeDeclSyntax>, _version: Int) {
      self.name = name
      self.mainDecl = mainDecl
      self._version = _version
    }
  }
}

extension TypeGraph {
  /// A reference to a resolved nominal type (global or local) vended by
  /// `TypeGraph`. Contains the unique name and resolved main declaration.
  @_spi(_QualifiedLookupTests)
  public enum TypeRef: Hashable, Sendable {
    /// Local nominal types cannot be extended
    case local(Attached<NominalTypeDeclSyntax>)
    case global(TypeGraph.GlobalTypeRef)

    /// The main declaration of this nominal reference
    ///
    /// Note: The main declaration helps in three ways:
    /// 1. To detect if we have a class/protocol for compositions
    /// 2. To find generic parameters
    /// 3. Testing if the resovled type match the expected main decl
    public var mainDecl: Attached<NominalTypeDeclSyntax> {
      switch self {
      case .global(let globalReference):
        return globalReference.mainDecl
      case .local(let localDecl):
        return localDecl
      }
    }
  }
}

// MARK: Debug

extension TypeGraph.GlobalTypeName.Qualifier: CustomDebugStringConvertible {
  public var debugDescription: String {
    switch self {
    case .internal(let fileID):
      "_(\(fileID))"
    case .external(let moduleName):
      "\(moduleName)"
    }
  }
}

extension TypeGraph.GlobalTypeName.Component: CustomDebugStringConvertible {
  /// E.g. '_(MyFile.swift)::MyType', 'ExternalModule::OtherType'
  public var debugDescription: String {
    "\(qualifier.debugDescription)::\(name)"
  }
}

extension TypeGraph.GlobalTypeName: CustomDebugStringConvertible {
  /// E.g. '_(MyFile.swift)::MyType.ExternalModule::OtherType'
  public var debugDescription: String {
    return components.map(\.debugDescription).joined(separator: ".")
  }
}

extension TypeGraph.GlobalTypeRef: CustomDebugStringConvertible {
  /// E.g. '_(InternalFile.swift)::MyType.ExternalModule::OtherType (v0, structDecl)'
  public var debugDescription: String {
    return "\(name.debugDescription) (v\(_version), \(mainDecl.kind))"
  }
  public var _succinctDescription: String {
    return name.debugDescription
  }
}

extension CodeBlockItemListSyntax {
  /// The scope decl/stmt/expr enclosing this code-block item list, such as
  /// `do` or `func`. Returns this scope syntax and an error description if
  /// no such scope exists.
  @_spi(_QualifiedLookupTests)
  public var _prettyScope: (scope: Syntax, prettyDescription: String) {
    let actualScope = self.parent?.parent

    // A `WithCodeBlockSyntax` like `do` or `WithOptionalCodeBlockSyntax` like `func`
    if let actualScope, let withCodeBlock = actualScope.asProtocol((any WithCodeBlockSyntax).self) {
      return (actualScope, withCodeBlock.with(\.body, CodeBlockSyntax(statements: [])).trimmedDescription)
    } else if let actualScope, let withCodeBlock = actualScope.asProtocol((any WithOptionalCodeBlockSyntax).self) {
      return (actualScope, withCodeBlock.with(\.body, nil).trimmedDescription)
    } else {
      // Fallback descriptions
      return (Syntax(self), "<CodeBlockItemListSyntax has no grandparent>")
    }
  }
}

extension Attached where Node == NominalTypeDeclSyntax {
  /// Returns the name of this local declaration or `nil` if global.
  var localNameDescription: String? {
    var result = "\(node.name.trimmedDescription)"
    var ancestor = node.parent

    while let currentAncestor = ancestor {
      if let nominalParent = currentAncestor.as(NominalTypeDeclSyntax.self) {
        // We could be nested in local nominal decls
        result = "\(nominalParent.name.trimmedDescription).\(result)"
      }
      // Once we get the local scope, we're done
      else if let scope = currentAncestor.as(CodeBlockItemListSyntax.self),
        let parentScope = scope.parent,
        // Source files and `#if` aren't local scopes
        !parentScope.is(SourceFileSyntax.self), !parentScope.is(IfConfigClauseSyntax.self)
      {
        result = "`\(scope._prettyScope.prettyDescription)`.\(result)"
        break
      }
      // Return `nil` for globals
      else if let scope = currentAncestor.as(CodeBlockItemListSyntax.self),
        scope.parent?.is(SourceFileSyntax.self) == true
      {
        return nil
      }

      // Keep going up scopes
      ancestor = currentAncestor.parent
    }

    return result
  }
}

@_spi(_QualifiedLookupTests)
extension TypeGraph.TypeRef: CustomDebugStringConvertible {
  /// E.g. 'struct LocalDecl {} (local)' or global
  /// '_(InternalFile.swift)::MyType.ExternalModule::OtherType (v0, structDecl)'
  public var debugDescription: String {
    switch self {
    case .global(let globalReference):
      return globalReference.debugDescription
    case .local(let nominalDecl):
      return "\(nominalDecl.localNameDescription ?? "<unexpectedly global>") (local)"
    }
  }

  /// A shorter description solely with information used for testing/
  /// important logs.
  ///
  /// E.g. a local 'struct LocalDecl {}' or global
  /// '_(InternalFile.swift)::MyType.ExternalModule::OtherType'
  public var _succinctDescription: String {
    switch self {
    case .global(let globalReference):
      return globalReference._succinctDescription
    case .local(let nominalDecl):
      return nominalDecl._memberlessDescription
    }
  }

  /// Extracts the global-type name if a global reference. Useful for testing.
  public var globalName: TypeGraph.GlobalTypeName? {
    switch self {
    case .global(let globalReference):
      return globalReference.name
    case .local:
      return nil
    }
  }
}

// MARK: Test Hooks

extension TypeGraph.GlobalTypeName {
  /// Construct a `GlobalTypeName` whose `debugDescription` is the given string
  /// for testing.
  ///
  /// Important: Any use outside of testing is unchecked and may result in
  /// crashes. Namely, the resulting `GlobalTypeName` has a single mock
  /// component responsible for generating the --potentially multi-component--
  /// debug description.
  @_spi(_QualifiedLookupTests)
  public static func _mock(nameDescription string: String, file: StaticString = #file, line: UInt = #line) -> Self {
    // This is very hacky but basically an external module + a type name will
    // print verbatim with a '::' between them. So, split the string at '::'
    // (which every global name has), and use the first part as the qualifier
    // and the tail as the "name".
    //
    // Also, the following is basically `string.firstRange(of: "::")`, but we
    // implement it from scratch because it's unavailable during
    // the compiler's bootstrapping step.
    let firstQualifierSeparatorIndex = string.indices.first(where: { i in
      string.index(after: i) < string.endIndex && string[i] == ":" && string[string.index(after: i)] == ":"
    })
    guard let firstQualifierSeparatorIndex else {
      fatalError("GlobalTypeName '\(string)' must have at least one qualifier separator '::'.", file: file, line: line)
    }
    let (firstQualifier, tail) = (
      string[..<firstQualifierSeparatorIndex].description,
      string[string.index(firstQualifierSeparatorIndex, offsetBy: 2)...].description
    )
    let instance = Self(
      component: Component(qualifier: Qualifier.external(moduleName: firstQualifier), name: tail)
    )

    // Ensure we round-trip correctly
    precondition(
      instance.debugDescription == string,
      "Unexpectedly parsed global type name '\(string)' wrong (got '\(instance.debugDescription)' instead).",
      file: file,
      line: line
    )

    return instance
  }
}

extension TypeGraph.GlobalTypeRef {
  /// Creates a mock `ResolvedTypeSyntax` where `unusedNominalDecl` can be any
  /// `Attached<NominalTypeDeclSyntax>` instance and isn't used to produce a
  /// description.
  @_spi(_QualifiedLookupTests)
  public static func _mock(
    globalName: TypeGraph.GlobalTypeName,
    unusedNominalDecl: Attached<NominalTypeDeclSyntax>
  ) -> TypeGraph.GlobalTypeRef {
    TypeGraph.GlobalTypeRef(name: globalName, mainDecl: unusedNominalDecl, _version: -1)
  }
}
