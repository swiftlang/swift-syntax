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

extension ActorDeclHeaderSyntax {
  public var introducer: TokenSyntax {
    get {
      return actorKeyword
    }
    set {
      actorKeyword = newValue
    }
  }
}

extension ActorDeclSyntax {
  public var header: DeclGroupHeaderSyntax {
    get {
      return DeclGroupHeaderSyntax(actorHeader)
    }
    set {
      actorHeader = newValue.cast(ActorDeclHeaderSyntax.self)
    }
  }
}

extension ClassDeclHeaderSyntax {
  public var introducer: TokenSyntax {
    get {
      return classKeyword
    }
    set {
      classKeyword = newValue
    }
  }
}

extension ClassDeclSyntax {
  public var header: DeclGroupHeaderSyntax {
    get {
      return DeclGroupHeaderSyntax(classHeader)
    }
    set {
      classHeader = newValue.cast(ClassDeclHeaderSyntax.self)
    }
  }
}

extension EnumDeclHeaderSyntax {
  public var introducer: TokenSyntax {
    get {
      return enumKeyword
    }
    set {
      enumKeyword = newValue
    }
  }
}

extension EnumDeclSyntax {
  public var header: DeclGroupHeaderSyntax {
    get {
      return DeclGroupHeaderSyntax(enumHeader)
    }
    set {
      enumHeader = newValue.cast(EnumDeclHeaderSyntax.self)
    }
  }
}

extension ExtensionDeclHeaderSyntax {
  public var introducer: TokenSyntax {
    get {
      return extensionKeyword
    }
    set {
      extensionKeyword = newValue
    }
  }
}

extension ExtensionDeclSyntax {
  public var header: DeclGroupHeaderSyntax {
    get {
      return DeclGroupHeaderSyntax(extensionHeader)
    }
    set {
      extensionHeader = newValue.cast(ExtensionDeclHeaderSyntax.self)
    }
  }
}

extension MissingDeclHeaderSyntax {
  public var introducer: TokenSyntax {
    get {
      return placeholder
    }
    set {
      placeholder = newValue
    }
  }
}

extension ProtocolDeclHeaderSyntax {
  public var introducer: TokenSyntax {
    get {
      return protocolKeyword
    }
    set {
      protocolKeyword = newValue
    }
  }
}

extension ProtocolDeclSyntax {
  public var header: DeclGroupHeaderSyntax {
    get {
      return DeclGroupHeaderSyntax(protocolHeader)
    }
    set {
      protocolHeader = newValue.cast(ProtocolDeclHeaderSyntax.self)
    }
  }
}

extension StructDeclHeaderSyntax {
  public var introducer: TokenSyntax {
    get {
      return structKeyword
    }
    set {
      structKeyword = newValue
    }
  }
}

extension StructDeclSyntax {
  public var header: DeclGroupHeaderSyntax {
    get {
      return DeclGroupHeaderSyntax(structHeader)
    }
    set {
      structHeader = newValue.cast(StructDeclHeaderSyntax.self)
    }
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add an extension here, please insert    //
// it in alphabetical order above                                           //
//==========================================================================//
