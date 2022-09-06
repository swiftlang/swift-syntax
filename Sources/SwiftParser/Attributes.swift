//===------------------------ Attributes.swift ----------------------------===//
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

@_spi(RawSyntax) import SwiftSyntax

extension Parser {
  mutating func parseAttributeList() -> RawAttributeListSyntax? {
    guard self.at(.atSign) else {
      return nil
    }

    var elements = [RawSyntax]()
    var loopProgress = LoopProgressCondition()
    repeat {
      let attribute = self.parseAttribute()
      elements.append(attribute)
    } while self.at(.atSign) && loopProgress.evaluate(currentToken)
    return RawAttributeListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  // FIXME: This should be gyb'ed. Go refactor include/AST/Attr.def to use
  // swift-syntax's definition of these attributes instead.
  enum DeclarationAttribute: SyntaxText {
    case _silgen_name = "_silgen_name"
    case available = "available"
    case final = "final"
    case objc = "objc"
    case required = "required"
    case optional = "optional"
    case dynamicCallable = "dynamicCallable"
    case main = "main"
    case _exported = "_exported"
    case dynamicMemberLookup = "dynamicMemberLookup"
    case NSCopying = "NSCopying"
    case IBAction = "IBAction"
    case IBDesignable = "IBDesignable"
    case IBInspectable = "IBInspectable"
    case IBOutlet = "IBOutlet"
    case NSManaged = "NSManaged"
    case lazy = "lazy"
    case LLDBDebuggerFunction = "LLDBDebuggerFunction"
    case UIApplicationMain = "UIApplicationMain"
    case unsafe_no_objc_tagged_pointer = "unsafe_no_objc_tagged_pointer"
    case inline = "inline"
    case _semantics = "_semantics"
    case dynamic = "dynamic"
    case infix = "infix"
    case prefix = "prefix"
    case postfix = "postfix"
    case _transparent = "_transparent"
    case requires_stored_property_inits = "requires_stored_property_inits"
    case nonobjc = "nonobjc"
    case _fixed_layout = "_fixed_layout"
    case inlinable = "inlinable"
    case _specialize = "_specialize"
    case objcMembers = "objcMembers"
    case _compilerInitialized = "_compilerInitialized"
    case __consuming = "__consuming"
    case mutating = "mutating"
    case nonmutating = "nonmutating"
    case convenience = "convenience"
    case override = "override"
    case _hasStorage = "_hasStorage"
    case `private` = "private"
    case `fileprivate` = "fileprivate"
    case `internal` = "internal"
    case `public` = "public"
    case open = "open"
    case __setter_access = "__setter_access"
    case __raw_doc_comment = "__raw_doc_comment"
    case weak = "weak"
    case unowned = "unowned"
    case _effects = "_effects"
    case __objc_bridged = "__objc_bridged"
    case NSApplicationMain = "NSApplicationMain"
    case _objc_non_lazy_realization = "_objc_non_lazy_realization"
    case __synthesized_protocol = "__synthesized_protocol"
    case testable = "testable"
    case _alignment = "_alignment"
    case `rethrows` = "rethrows"
    case _swift_native_objc_runtime_base = "_swift_native_objc_runtime_base"
    case indirect = "indirect"
    case warn_unqualified_access = "warn_unqualified_access"
    case _show_in_interface = "_show_in_interface"
    case _cdecl = "_cdecl"
    case usableFromInline = "usableFromInline"
    case discardableResult = "discardableResult"
    case GKInspectable = "GKInspectable"
    case _implements = "_implements"
    case _objcRuntimeName = "_objcRuntimeName"
    case _staticInitializeObjCMetadata = "_staticInitializeObjCMetadata"
    case _restatedObjCConformance = "_restatedObjCConformance"
    case _typeSequence = "_typeSequence"
    case _optimize = "_optimize"
    case _clangImporterSynthesizedType = "_clangImporterSynthesizedType"
    case _weakLinked = "_weakLinked"
    case frozen = "frozen"
    case _frozen = "_frozen"
    case _forbidSerializingReference = "_forbidSerializingReference"
    case _hasInitialValue = "_hasInitialValue"
    case _nonoverride = "_nonoverride"
    case _dynamicReplacement = "_dynamicReplacement"
    case _borrowed = "_borrowed"
    case _private = "_private"
    case _alwaysEmitIntoClient = "_alwaysEmitIntoClient"
    case _implementationOnly = "_implementationOnly"
    case _custom = "_custom"
    case propertyWrapper = "propertyWrapper"
    case _disfavoredOverload = "_disfavoredOverload"
    case resultBuilder = "resultBuilder"
    case _projectedValueProperty = "_projectedValueProperty"
    case _nonEphemeral = "_nonEphemeral"
    case differentiable = "differentiable"
    case _hasMissingDesignatedInitializers = "_hasMissingDesignatedInitializers"
    case _inheritsConvenienceInitializers = "_inheritsConvenienceInitializers"
    case _typeEraser = "_typeEraser"
    case IBSegueAction = "IBSegueAction"
    case _originallyDefinedIn = "_originallyDefinedIn"
    case derivative = "derivative"
    case _spi = "_spi"
    case transpose = "transpose"
    case noDerivative = "noDerivative"
    case actor = "actor"
    case isolated = "isolated"
    case globalActor = "globalActor"
    case _specializeExtension = "_specializeExtension"
    case async = "async"
    case Sendable = "Sendable"
    case _marker = "_marker"
    case reasync = "reasync"
    case nonisolated = "nonisolated"
    case _unsafeInheritExecutor = "_unsafeInheritExecutor"
    case _implicitSelfCapture = "_implicitSelfCapture"
    case _inheritActorContext = "_inheritActorContext"
    case distributed = "distributed"
    case _assemblyVision = "_assemblyVision"
    case _nonSendable = "_nonSendable"
    case _noImplicitCopy = "_noImplicitCopy"
    case _noLocks = "_noLocks"
    case _noAllocation = "_noAllocation"
    case preconcurrency = "preconcurrency"
    case _const = "_const"
    case _unavailableFromAsync = "_unavailableFromAsync"
    case exclusivity = "exclusivity"
    case _backDeploy = "_backDeploy"
    case _local = "_local"
  }

  mutating func parseAttribute() -> RawSyntax {
    guard let declAttr = DeclarationAttribute(rawValue: self.peek().tokenText) else {
      return RawSyntax(self.parseCustomAttribute())
    }

    switch declAttr {
    case .available:
      return RawSyntax(self.parseAvailabilityAttribute())
    case .differentiable:
      return RawSyntax(self.parseDifferentiableAttribute())
    case .objc:
      return RawSyntax(self.parseObjectiveCAttribute())
    case ._specialize:
      return RawSyntax(self.parseSpecializeAttribute())
    case ._private:
      return RawSyntax(self.parsePrivateImportAttribute())
    case ._dynamicReplacement:
      return RawSyntax(self.parseDynamicReplacementAttribute())
    case ._spi:
      return RawSyntax(self.parseSPIAttribute())
    default:
      break
    }


    let atSign = self.eat(.atSign)
    let ident = self.consumeIdentifier()
    let leftParen: RawTokenSyntax?
    let arg: RawSyntax?
    let unexpectedBeforeRightParen: RawUnexpectedNodesSyntax?
    let rightParen: RawTokenSyntax?
    if self.at(.leftParen) {
      var args = [RawTokenSyntax]()
      leftParen = self.eat(.leftParen)
      var loopProgress = LoopProgressCondition()
      while !self.at(.eof) && !self.at(.rightParen) && loopProgress.evaluate(currentToken) {
        args.append(self.consumeAnyToken())
      }
      arg = RawSyntax(RawTokenListSyntax(elements: args, arena: self.arena))
      (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    } else {
      leftParen = nil
      arg = nil
      unexpectedBeforeRightParen = nil
      rightParen = nil
    }
    return RawSyntax(RawAttributeSyntax(
      atSignToken: atSign,
      attributeName: ident,
      leftParen: leftParen,
      argument: arg,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena))
  }

  mutating func parseCustomAttribute() -> RawCustomAttributeSyntax {
    let atSign = self.eat(.atSign)
    let attrName = self.parseType()

    // Custom attributes are stricter than normal attributes about their
    // argument lists "immediately" following the attribute name.
    guard self.at(.leftParen) && !self.currentToken.isAtStartOfLine && self.lookahead().isCustomAttributeArgument() else {
      return RawCustomAttributeSyntax(
        atSignToken: atSign, attributeName: attrName,
        leftParen: nil, argumentList: nil, rightParen: nil,
        arena: self.arena)
    }
    let leftParen = self.eat(.leftParen)
    let arguments = self.parseArgumentListElements()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawCustomAttributeSyntax(
      atSignToken: atSign, attributeName: attrName,
      leftParen: leftParen,
      argumentList: RawTupleExprElementListSyntax(elements: arguments, arena: self.arena),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena)
  }
}

extension Parser {
  mutating func parseAvailabilityAttribute() -> RawAttributeSyntax {
    let atSign = self.eat(.atSign)
    assert(self.currentToken.tokenText == "available")
    let available = self.consumeAnyToken()
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)

    let argument: RawSyntax
    do {
      if self.peek().tokenKind == .integerLiteral {
        argument = RawSyntax(self.parseAvailabilitySpecList(from: .available))
      } else if self.peek().tokenKind  == .floatingLiteral {
        argument = RawSyntax(self.parseAvailabilitySpecList(from: .available))
      } else {
        argument = RawSyntax(self.parseExtendedAvailabilitySpecList())
      }
    }
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      atSignToken: atSign,
      attributeName: available,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: argument,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena)
  }
}

extension Parser {
  mutating func parseDifferentiableAttribute() -> RawAttributeSyntax {
    let atSign = self.eat(.atSign)
    assert(self.currentToken.tokenText == "differentiable")
    let differentiable = self.consumeAnyToken()
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)

    let argument = self.parseDifferentiableAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      atSignToken: atSign,
      attributeName: differentiable,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: RawSyntax(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena)
  }

  enum DifferentiabilityKind: SyntaxText {
    case reverse = "reverse"
    case linear = "_linear"
    case forward = "_forward"
  }

  mutating func parseDifferentiableAttributeArguments() -> RawDifferentiableAttributeArgumentsSyntax {
    let diffKind: RawTokenSyntax?
    let diffKindComma: RawTokenSyntax?
    if
      .identifier == self.currentToken.tokenKind,
      DifferentiabilityKind(rawValue: self.currentToken.tokenText) != nil
    {
      diffKind = self.consumeIdentifier()
      diffKindComma = self.consume(if: .comma)
    } else {
      diffKind = nil
      diffKindComma = nil
    }

    let diffParams: RawDifferentiabilityParamsClauseSyntax?
    let diffParamsComma: RawTokenSyntax?
    if self.currentToken.tokenText == "wrt" {
      diffParams = self.parseDifferentiabilityParameters()
      diffParamsComma = self.consume(if: .comma)
    } else {
      diffParams = nil
      diffParamsComma = nil
    }

    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.whereKeyword) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }
    return RawDifferentiableAttributeArgumentsSyntax(
      diffKind: diffKind,
      diffKindComma: diffKindComma,
      diffParams: diffParams,
      diffParamsComma: diffParamsComma,
      whereClause: whereClause,
      arena: self.arena)
  }

  mutating func parseDifferentiabilityParameters() -> RawDifferentiabilityParamsClauseSyntax {
    let wrt = self.consumeIdentifier()
    let (unexpectedBeforeColon, colon) = self.expect(.colon)

    guard self.at(.leftParen) else {
      // If no opening '(' for parameter list, parse a single parameter.
      let param = self.parseDifferentiabilityParameter().map(RawSyntax.init(_:))
                  ?? RawSyntax(RawMissingSyntax(arena: self.arena))
      return RawDifferentiabilityParamsClauseSyntax(
        wrtLabel: wrt,
        unexpectedBeforeColon,
        colon: colon,
        parameters: param,
        arena: self.arena
      )
    }

    let leftParen = self.eat(.leftParen)
    var elements = [RawDifferentiabilityParamSyntax]()
    var loopProgress = LoopProgressCondition()
    while !self.at(.eof) && !self.at(.rightParen) && loopProgress.evaluate(currentToken) {
      guard let param = self.parseDifferentiabilityParameter() else {
        break
      }
      elements.append(param)
    }
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    let parameters = RawDifferentiabilityParamListSyntax(elements: elements, arena: self.arena)
    let list = RawDifferentiabilityParamsSyntax(
      leftParen: leftParen,
      diffParams: parameters,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
    return RawDifferentiabilityParamsClauseSyntax(
      wrtLabel: wrt,
      unexpectedBeforeColon,
      colon: colon,
      parameters: RawSyntax(list),
      arena: self.arena
    )
  }

  mutating func parseDifferentiabilityParameter() -> RawDifferentiabilityParamSyntax? {
    switch self.currentToken.tokenKind {
    case .identifier:
      let token = self.consumeIdentifier()
      let comma = self.consume(if: .comma)
      return RawDifferentiabilityParamSyntax(
        parameter: RawSyntax(token), trailingComma: comma, arena: self.arena)
    case .integerLiteral:
      let token = self.consumeAnyToken()
      let comma = self.consume(if: .comma)
      return RawDifferentiabilityParamSyntax(
        parameter: RawSyntax(token), trailingComma: comma, arena: self.arena)
    case .selfKeyword:
      let token = self.eat(.selfKeyword)
      let comma = self.consume(if: .comma)
      return RawDifferentiabilityParamSyntax(
        parameter: RawSyntax(token), trailingComma: comma, arena: self.arena)
    default:
      return nil
    }
  }
}

extension Parser {
  mutating func parseObjectiveCAttribute() -> RawAttributeSyntax {
    let atSign = self.eat(.atSign)
    assert(self.currentToken.tokenText == "objc")
    let objc = self.consumeAnyToken()

    let leftParen: RawTokenSyntax?
    let argument: RawObjCSelectorSyntax?
    let unexpectedBeforeRightParen: RawUnexpectedNodesSyntax?
    let rightParen: RawTokenSyntax?
    if self.at(.leftParen) {
      leftParen = self.eat(.leftParen)
      argument = self.parseObjectiveCSelector()
      (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    } else {
      leftParen = nil
      argument = nil
      unexpectedBeforeRightParen = nil
      rightParen = nil
    }

    return RawAttributeSyntax(
      atSignToken: atSign, attributeName: objc,
      leftParen: leftParen,
      argument: argument.map(RawSyntax.init),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena)
  }

  mutating func parseObjectiveCSelector() -> RawObjCSelectorSyntax {
    var elements = [RawObjCSelectorPieceSyntax]()
    var loopProgress = LoopProgressCondition()
    while !self.at(.eof) && !self.at(.rightParen) && loopProgress.evaluate(currentToken) {
      // Empty selector piece.
      if self.at(.colon) {
        let colon = self.eat(.colon)
        elements.append(RawObjCSelectorPieceSyntax(
          name: nil, colon: colon, arena: self.arena))
        continue
      }

      if self.currentToken.isIdentifier || self.currentToken.isKeyword {
        let name = self.consumeAnyToken()
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        elements.append(RawObjCSelectorPieceSyntax(
          name: name,
          unexpectedBeforeColon,
          colon: colon,
          arena: self.arena))
      }
    }
    return RawObjCSelectorSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  mutating func parseSpecializeAttribute() -> RawAttributeSyntax {
    let atSign = self.eat(.atSign)
    assert(self.currentToken.tokenText == "_specialize")
    let specializeToken = self.consumeAnyToken()
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let argument = self.parseSpecializeAttributeSpecList()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawAttributeSyntax(
      atSignToken: atSign,
      attributeName: specializeToken,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: RawSyntax(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena)
  }

  enum SpecializeParameter: SyntaxText {
    case target
    case availability
    case exported
    case kind
    case spi
    case spiModule
    case available
  }
  mutating func parseSpecializeAttributeSpecList() -> RawSpecializeAttributeSpecListSyntax {
    var elements = [RawSyntax]()
    // Parse optional "exported" and "kind" labeled parameters.
    var loopProgress = LoopProgressCondition()
    while !self.at(.eof) && !self.at(.rightParen) && !self.at(.whereKeyword) && loopProgress.evaluate(currentToken) {
      let ident = self.parseAnyIdentifier()
      let knownParameter = SpecializeParameter(rawValue: ident.tokenText)
      let (unexpectedBeforeColon, colon) = self.expect(.colon)

      switch knownParameter {
      case .target:
        let (targetFunction, args) = self.parseDeclNameRef([ .zeroArgCompoundNames, .keywordsUsingSpecialNames, .operators ])
        let declName = RawDeclNameSyntax(
          declBaseName: RawSyntax(targetFunction),
          declNameArguments: args,
          arena: self.arena)
        let comma = self.consume(if: .comma)
        elements.append(RawSyntax(RawTargetFunctionEntrySyntax(
          label: ident,
          unexpectedBeforeColon,
          colon: colon,
          declname: declName,
          trailingComma: comma,
          arena: self.arena
        )))
      case .availability:
        let availability = self.parseAvailabilitySpecList(from: .available)
        // FIXME: This is modeled incorrectly in libSyntax.
        let semi = RawTokenSyntax(missing: .semicolon, arena: self.arena)
        elements.append(RawSyntax(RawAvailabilityEntrySyntax(
          label: ident,
          unexpectedBeforeColon,
          colon: colon,
          availabilityList: availability,
          semicolon: semi,
          arena: self.arena
        )))
      case .available:
        // FIXME: I have no idea what this is supposed to be, but the Syntax
        // tree only allows us to insert a token so we'll take anything.
        let available = self.consumeAnyToken()
        let comma = self.consume(if: .comma)
        elements.append(RawSyntax(RawLabeledSpecializeEntrySyntax(
          label: ident,
          unexpectedBeforeColon,
          colon: colon,
          value: available,
          trailingComma: comma,
          arena: self.arena
        )))
      case .exported:
        let (unexpectedBeforeValue, value) = self.expectAny([.trueKeyword, .falseKeyword], default: .falseKeyword)
        let comma = self.consume(if: .comma)
        elements.append(RawSyntax(RawLabeledSpecializeEntrySyntax(
          label: ident,
          unexpectedBeforeColon,
          colon: colon,
          unexpectedBeforeValue,
          value: value,
          trailingComma: comma,
          arena: self.arena
        )))
      case .kind:
        let valueLabel = self.parseAnyIdentifier()
        let comma = self.consume(if: .comma)
        elements.append(RawSyntax(RawLabeledSpecializeEntrySyntax(
          label: ident,
          unexpectedBeforeColon,
          colon: colon,
          value: valueLabel,
          trailingComma: comma,
          arena: self.arena
        )))
      case .spiModule, .spi:
        let valueLabel = self.consumeAnyToken()
        let comma = self.consume(if: .comma)
        elements.append(RawSyntax(RawLabeledSpecializeEntrySyntax(
          label: ident,
          unexpectedBeforeColon,
          colon: colon,
          value: valueLabel,
          trailingComma: comma,
          arena: self.arena
        )))
      case nil:
        let valueLabel = self.consumeAnyToken()
        let comma = self.consume(if: .comma)
        elements.append(RawSyntax(RawLabeledSpecializeEntrySyntax(
          label: ident,
          unexpectedBeforeColon,
          colon: colon,
          value: valueLabel,
          trailingComma: comma,
          arena: self.arena
        )))
      }
    }

    // Parse the where clause.
    if self.at(.whereKeyword) {
      let whereClause = self.parseGenericWhereClause()
      elements.append(RawSyntax(whereClause))
    }
    return RawSpecializeAttributeSpecListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  // FIXME: This should be gyb'ed. Go refactor include/AST/Attr.def to use
  // swift-syntax's infrastructure.
  enum TypeAttribute: SyntaxText {
    case autoclosure = "autoclosure"
    case convention = "convention"
    case noescape = "noescape"
    case escaping = "escaping"
    case differentiable = "differentiable"
    case noDerivative = "noDerivative"
    case async = "async"
    case Sendable = "Sendable"
    case unchecked = "unchecked"
    case _typeSequence = "_typeSequence"
    case _local = "_local"
    case blockStorage = "block_storage"
    case box = "box"
    case dynamicSelf = "dynamic_self"
    case silWeak = "sil_weak"
    case silUnowned = "sil_unowned"
    case silUnmanaged = "sil_unmanaged"
    case error = "error"
    case out = "out"
    case `in` = "in"
    case `inout` = "inout"
    case inoutAliasable = "inout_aliasable"
    case inGuaranteed = "in_guaranteed"
    case inConstant = "in_constant"
    case owned = "owned"
    case unownedInnerPointer = "unowned_inner_pointer"
    case guaranteed = "guaranteed"
    case autoreleased = "autoreleased"
    case calleeOwned = "callee_owned"
    case calleeGuaranteed = "callee_guaranteed"
    case objcMetatype = "objc_metatype"
    case opened = "opened"
    case pseudogeneric = "pseudogeneric"
    case yields = "yields"
    case yieldOnce = "yield_once"
    case yieldMany = "yield_many"
    case capturesGenerics = "captures_generics"
    case moveOnly = "moveOnly"
    case thin = "thin"
    case thick = "thick"
    case _opaqueReturnTypeOf = "_opaqueReturnTypeOf"
  }
}

extension Parser {
  mutating func parsePrivateImportAttribute() -> RawAttributeSyntax {
    let atSign = self.eat(.atSign)
    assert(self.currentToken.tokenText == "_private")
    let privateToken = self.consumeAnyToken()
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let label = self.consumeIdentifier()
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    let filename = self.consumeAnyToken()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawAttributeSyntax(
      atSignToken: atSign,
      attributeName: privateToken,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: RawSyntax(RawNamedAttributeStringArgumentSyntax(
        nameTok: label,
        unexpectedBeforeColon,
        colon: colon,
        stringOrDeclname: RawSyntax(filename),
        arena: self.arena
      )),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena)
  }
}

extension Parser {
  mutating func parseDynamicReplacementAttribute() -> RawAttributeSyntax {
    let atSign = self.eat(.atSign)
    assert(self.currentToken.tokenText == "_dynamicReplacement")
    let dynamicReplacementToken = self.consumeAnyToken()
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let label: RawTokenSyntax
    if self.currentToken.tokenText == "for" {
      label = self.consumeAnyToken()
    } else {
      label = RawTokenSyntax(missing: .forKeyword, arena: self.arena)
    }
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    let (base, args) = self.parseDeclNameRef([
      .zeroArgCompoundNames, .keywordsUsingSpecialNames, .operators,
    ])
    let method = RawDeclNameSyntax(declBaseName: RawSyntax(base), declNameArguments: args, arena: self.arena)
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawAttributeSyntax(
      atSignToken: atSign,
      attributeName: dynamicReplacementToken,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: RawSyntax(RawNamedAttributeStringArgumentSyntax(
        nameTok: label,
        unexpectedBeforeColon,
        colon: colon,
        stringOrDeclname: RawSyntax(method),
        arena: self.arena
      )),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: arena)
  }
}

extension Parser {
  mutating func parseSPIAttribute() -> RawAttributeSyntax {
    let atSign = self.eat(.atSign)
    assert(self.currentToken.tokenText == "_spi")
    let spiToken = self.consumeAnyToken()
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let label = self.consumeAnyToken()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawAttributeSyntax(
      atSignToken: atSign,
      attributeName: spiToken,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: RawSyntax(label),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena)
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  func isCustomAttributeArgument() -> Bool {
    var lookahead = self.lookahead()
    lookahead.skipSingle()

    // If we have any keyword, identifier, or token that follows a function
    // type's parameter list, this is a parameter list and not an attribute.
    // Alternatively, we might have a token that illustrates we're not going to
    // get anything following the attribute, which means the parentheses describe
    // what follows the attribute.
    switch lookahead.currentToken.tokenKind {
    case .arrow,
        .throwKeyword,
        .throwsKeyword,
        .rethrowsKeyword,
        .rightParen,
        .rightBrace,
        .rightSquareBracket,
        .rightAngle:
      return false
    case _ where lookahead.currentToken.isContextualKeyword("async"):
      return false
    case _ where lookahead.currentToken.isContextualKeyword("reasync"):
      return false
    default:
      return true
    }
  }

  mutating func canParseCustomAttribute() -> Bool {
    guard self.canParseType() else {
      return false
    }

    if self.at(.leftParen) && !self.currentToken.isAtStartOfLine && self.lookahead().isCustomAttributeArgument() {
      self.skipSingle()
    }

    return true
  }
}
