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

extension ActorDeclSyntax {
  public var introducer: TokenSyntax {
    get {
      return actorKeyword
    }
    set {
      actorKeyword = newValue
    }
  }
}

extension ClassDeclSyntax {
  public var introducer: TokenSyntax {
    get {
      return classKeyword
    }
    set {
      classKeyword = newValue
    }
  }
}

extension EnumDeclSyntax {
  public var introducer: TokenSyntax {
    get {
      return enumKeyword
    }
    set {
      enumKeyword = newValue
    }
  }
}

extension ExtensionDeclSyntax {
  public var introducer: TokenSyntax {
    get {
      return extensionKeyword
    }
    set {
      extensionKeyword = newValue
    }
  }
}

extension ProtocolDeclSyntax {
  public var introducer: TokenSyntax {
    get {
      return protocolKeyword
    }
    set {
      protocolKeyword = newValue
    }
  }
}

extension StructDeclSyntax {
  public var introducer: TokenSyntax {
    get {
      return structKeyword
    }
    set {
      structKeyword = newValue
    }
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add an extension here, please insert    //
// it in alphabetical order above                                           //
//==========================================================================//
