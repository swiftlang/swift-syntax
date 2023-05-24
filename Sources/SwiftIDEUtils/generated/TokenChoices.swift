
import SwiftSyntax

public extension KeyPath where Root: SyntaxProtocol {
  var tokenChoices: [TokenKind] {
    switch self {
    case \AccessPathComponentSyntax.name:
      return [
          .identifier(""), 
          .binaryOperator(""), 
          .prefixOperator(""), 
          .postfixOperator("")
        ]
    case \AccessPathComponentSyntax.trailingDot:
      return [.period]
    case \AccessorBlockSyntax.leftBrace:
      return [.leftBrace]
    case \AccessorBlockSyntax.rightBrace:
      return [.rightBrace]
    case \AccessorDeclSyntax.accessorKind:
      return [
          .keyword(.get), 
          .keyword(.set), 
          .keyword(.didSet), 
          .keyword(.willSet), 
          .keyword(.unsafeAddress), 
          .keyword(.addressWithOwner), 
          .keyword(.addressWithNativeOwner), 
          .keyword(.unsafeMutableAddress), 
          .keyword(.mutableAddressWithOwner), 
          .keyword(.mutableAddressWithNativeOwner), 
          .keyword(._read), 
          .keyword(._modify)
        ]
    case \AccessorEffectSpecifiersSyntax.asyncSpecifier:
      return [.keyword(.async)]
    case \AccessorEffectSpecifiersSyntax.throwsSpecifier:
      return [.keyword(.throws)]
    case \AccessorParameterSyntax.leftParen:
      return [.leftParen]
    case \AccessorParameterSyntax.name:
      return [.identifier("")]
    case \AccessorParameterSyntax.rightParen:
      return [.rightParen]
    case \ActorDeclSyntax.actorKeyword:
      return [.keyword(.actor)]
    case \ActorDeclSyntax.identifier:
      return [.identifier("")]
    case \ArrayElementSyntax.trailingComma:
      return [.comma]
    case \ArrayExprSyntax.leftSquare:
      return [.leftSquareBracket]
    case \ArrayExprSyntax.rightSquare:
      return [.rightSquareBracket]
    case \ArrayTypeSyntax.leftSquareBracket:
      return [.leftSquareBracket]
    case \ArrayTypeSyntax.rightSquareBracket:
      return [.rightSquareBracket]
    case \ArrowExprSyntax.arrowToken:
      return [.arrow]
    case \AsExprSyntax.asTok:
      return [.keyword(.as)]
    case \AsExprSyntax.questionOrExclamationMark:
      return [.postfixQuestionMark, .exclamationMark]
    case \AssignmentExprSyntax.assignToken:
      return [.equal]
    case \AssociatedtypeDeclSyntax.associatedtypeKeyword:
      return [.keyword(.associatedtype)]
    case \AssociatedtypeDeclSyntax.identifier:
      return [.identifier("")]
    case \AttributeSyntax.atSignToken:
      return [.atSign]
    case \AttributeSyntax.leftParen:
      return [.leftParen]
    case \AttributeSyntax.rightParen:
      return [.rightParen]
    case \AttributedTypeSyntax.specifier:
      return [
          .keyword(.inout), 
          .keyword(.__shared), 
          .keyword(.__owned), 
          .keyword(.isolated), 
          .keyword(._const), 
          .keyword(.borrowing), 
          .keyword(.consuming)
        ]
    case \AvailabilityArgumentSyntax.trailingComma:
      return [.comma]
    case \AvailabilityConditionSyntax.availabilityKeyword:
      return [.poundAvailableKeyword, .poundUnavailableKeyword]
    case \AvailabilityConditionSyntax.leftParen:
      return [.leftParen]
    case \AvailabilityConditionSyntax.rightParen:
      return [.rightParen]
    case \AvailabilityEntrySyntax.label:
      return [.keyword(.availability)]
    case \AvailabilityEntrySyntax.colon:
      return [.colon]
    case \AvailabilityEntrySyntax.semicolon:
      return [.semicolon]
    case \AvailabilityLabeledArgumentSyntax.label:
      return [
          .keyword(.message), 
          .keyword(.renamed), 
          .keyword(.introduced), 
          .keyword(.obsoleted), 
          .keyword(.deprecated)
        ]
    case \AvailabilityLabeledArgumentSyntax.colon:
      return [.colon]
    case \AvailabilityVersionRestrictionListEntrySyntax.trailingComma:
      return [.comma]
    case \AvailabilityVersionRestrictionSyntax.platform:
      return [.identifier("")]
    case \AwaitExprSyntax.awaitKeyword:
      return [.keyword(.await)]
    case \BackDeployedAttributeSpecListSyntax.beforeLabel:
      return [.keyword(.before)]
    case \BackDeployedAttributeSpecListSyntax.colon:
      return [.colon]
    case \BinaryOperatorExprSyntax.operatorToken:
      return [.binaryOperator("")]
    case \BooleanLiteralExprSyntax.booleanLiteral:
      return [.keyword(.true), .keyword(.false)]
    case \BorrowExprSyntax.borrowKeyword:
      return [.keyword(._borrow)]
    case \BreakStmtSyntax.breakKeyword:
      return [.keyword(.break)]
    case \BreakStmtSyntax.label:
      return [.identifier("")]
    case \CaseItemSyntax.trailingComma:
      return [.comma]
    case \CatchClauseSyntax.catchKeyword:
      return [.keyword(.catch)]
    case \CatchItemSyntax.trailingComma:
      return [.comma]
    case \ClassDeclSyntax.classKeyword:
      return [.keyword(.class)]
    case \ClassDeclSyntax.identifier:
      return [.identifier("")]
    case \ClassRestrictionTypeSyntax.classKeyword:
      return [.keyword(.class)]
    case \ClosureCaptureItemSpecifierSyntax.specifier:
      return [.keyword(.weak), .keyword(.unowned)]
    case \ClosureCaptureItemSpecifierSyntax.leftParen:
      return [.leftParen]
    case \ClosureCaptureItemSpecifierSyntax.detail:
      return [.keyword(.safe), .keyword(.unsafe)]
    case \ClosureCaptureItemSpecifierSyntax.rightParen:
      return [.rightParen]
    case \ClosureCaptureItemSyntax.name:
      return [.identifier("")]
    case \ClosureCaptureItemSyntax.assignToken:
      return [.equal]
    case \ClosureCaptureItemSyntax.trailingComma:
      return [.comma]
    case \ClosureCaptureSignatureSyntax.leftSquare:
      return [.leftSquareBracket]
    case \ClosureCaptureSignatureSyntax.rightSquare:
      return [.rightSquareBracket]
    case \ClosureExprSyntax.leftBrace:
      return [.leftBrace]
    case \ClosureExprSyntax.rightBrace:
      return [.rightBrace]
    case \ClosureParamSyntax.name:
      return [.identifier(""), .wildcard]
    case \ClosureParamSyntax.trailingComma:
      return [.comma]
    case \ClosureParameterClauseSyntax.leftParen:
      return [.leftParen]
    case \ClosureParameterClauseSyntax.rightParen:
      return [.rightParen]
    case \ClosureParameterSyntax.firstName:
      return [.identifier(""), .wildcard]
    case \ClosureParameterSyntax.secondName:
      return [.identifier(""), .wildcard]
    case \ClosureParameterSyntax.colon:
      return [.colon]
    case \ClosureParameterSyntax.ellipsis:
      return [.ellipsis]
    case \ClosureParameterSyntax.trailingComma:
      return [.comma]
    case \ClosureSignatureSyntax.inTok:
      return [.keyword(.in)]
    case \CodeBlockItemSyntax.semicolon:
      return [.semicolon]
    case \CodeBlockSyntax.leftBrace:
      return [.leftBrace]
    case \CodeBlockSyntax.rightBrace:
      return [.rightBrace]
    case \ConditionElementSyntax.trailingComma:
      return [.comma]
    case \ConformanceRequirementSyntax.colon:
      return [.colon]
    case \ConstrainedSugarTypeSyntax.someOrAnySpecifier:
      return [.keyword(.some), .keyword(.any)]
    case \ContinueStmtSyntax.continueKeyword:
      return [.keyword(.continue)]
    case \ContinueStmtSyntax.label:
      return [.identifier("")]
    case \ConventionAttributeArgumentsSyntax.conventionLabel:
      return [.identifier("")]
    case \ConventionAttributeArgumentsSyntax.comma:
      return [.comma]
    case \ConventionAttributeArgumentsSyntax.cTypeLabel:
      return [.keyword(.cType)]
    case \ConventionAttributeArgumentsSyntax.colon:
      return [.colon]
    case \ConventionWitnessMethodAttributeArgumentsSyntax.witnessMethodLabel:
      return [.keyword(.witness_method)]
    case \ConventionWitnessMethodAttributeArgumentsSyntax.colon:
      return [.colon]
    case \ConventionWitnessMethodAttributeArgumentsSyntax.protocolName:
      return [.identifier("")]
    case \DeclModifierDetailSyntax.leftParen:
      return [.leftParen]
    case \DeclModifierDetailSyntax.detail:
      return [.identifier("")]
    case \DeclModifierDetailSyntax.rightParen:
      return [.rightParen]
    case \DeclModifierSyntax.name:
      return [
          .keyword(.__consuming), 
          .keyword(.__setter_access), 
          .keyword(._const), 
          .keyword(._local), 
          .keyword(.actor), 
          .keyword(.async), 
          .keyword(.borrowing), 
          .keyword(.class), 
          .keyword(.consuming), 
          .keyword(.convenience), 
          .keyword(.distributed), 
          .keyword(.dynamic), 
          .keyword(.fileprivate), 
          .keyword(.final), 
          .keyword(.indirect), 
          .keyword(.infix), 
          .keyword(.internal), 
          .keyword(.isolated), 
          .keyword(.lazy), 
          .keyword(.mutating), 
          .keyword(.nonisolated), 
          .keyword(.nonmutating), 
          .keyword(.open), 
          .keyword(.optional), 
          .keyword(.override), 
          .keyword(.package), 
          .keyword(.postfix), 
          .keyword(.prefix), 
          .keyword(.private), 
          .keyword(.public), 
          .keyword(.reasync), 
          .keyword(.required), 
//          .keyword(.setter_access), 
          .keyword(.static), 
          .keyword(.unowned), 
          .keyword(.weak)
        ]
    case \DeclNameArgumentSyntax.colon:
      return [.colon]
    case \DeclNameArgumentsSyntax.leftParen:
      return [.leftParen]
    case \DeclNameArgumentsSyntax.rightParen:
      return [.rightParen]
    case \DeclNameSyntax.declBaseName:
      return [
          .identifier(""), 
          .binaryOperator(""), 
          .keyword(.`init`), 
          .keyword(.self), 
          .keyword(.Self)
        ]
    case \DeferStmtSyntax.deferKeyword:
      return [.keyword(.defer)]
    case \DeinitializerDeclSyntax.deinitKeyword:
      return [.keyword(.deinit)]
    case \DerivativeRegistrationAttributeArgumentsSyntax.ofLabel:
      return [.keyword(.of)]
    case \DerivativeRegistrationAttributeArgumentsSyntax.colon:
      return [.colon]
    case \DerivativeRegistrationAttributeArgumentsSyntax.period:
      return [.period]
    case \DerivativeRegistrationAttributeArgumentsSyntax.accessorKind:
      return [.keyword(.get), .keyword(.set)]
    case \DerivativeRegistrationAttributeArgumentsSyntax.comma:
      return [.comma]
    case \DesignatedTypeElementSyntax.leadingComma:
      return [.comma]
    case \DictionaryElementSyntax.colon:
      return [.colon]
    case \DictionaryElementSyntax.trailingComma:
      return [.comma]
    case \DictionaryExprSyntax.leftSquare:
      return [.leftSquareBracket]
    case \DictionaryExprSyntax.rightSquare:
      return [.rightSquareBracket]
    case \DictionaryTypeSyntax.leftSquareBracket:
      return [.leftSquareBracket]
    case \DictionaryTypeSyntax.colon:
      return [.colon]
    case \DictionaryTypeSyntax.rightSquareBracket:
      return [.rightSquareBracket]
    case \DifferentiabilityParamSyntax.parameter:
      return [.identifier(""), .integerLiteral(""), .keyword(.self)]
    case \DifferentiabilityParamSyntax.trailingComma:
      return [.comma]
    case \DifferentiabilityParamsClauseSyntax.wrtLabel:
      return [.keyword(.wrt)]
    case \DifferentiabilityParamsClauseSyntax.colon:
      return [.colon]
    case \DifferentiabilityParamsSyntax.leftParen:
      return [.leftParen]
    case \DifferentiabilityParamsSyntax.rightParen:
      return [.rightParen]
    case \DifferentiableAttributeArgumentsSyntax.diffKind:
      return [.keyword(._forward), .keyword(.reverse), .keyword(._linear)]
    case \DifferentiableAttributeArgumentsSyntax.diffKindComma:
      return [.comma]
    case \DifferentiableAttributeArgumentsSyntax.diffParamsComma:
      return [.comma]
    case \DiscardAssignmentExprSyntax.wildcard:
      return [.wildcard]
    case \DoStmtSyntax.doKeyword:
      return [.keyword(.do)]
    case \DocumentationAttributeArgumentSyntax.label:
      return [.keyword(.visibility), .keyword(.metadata)]
    case \DocumentationAttributeArgumentSyntax.colon:
      return [.colon]
    case \DocumentationAttributeArgumentSyntax.trailingComma:
      return [.comma]
    case \DynamicReplacementArgumentsSyntax.forLabel:
      return [.keyword(.for)]
    case \DynamicReplacementArgumentsSyntax.colon:
      return [.colon]
    case \EditorPlaceholderDeclSyntax.identifier:
      return [.identifier("")]
    case \EditorPlaceholderExprSyntax.identifier:
      return [.identifier("")]
    case \EnumCaseDeclSyntax.caseKeyword:
      return [.keyword(.case)]
    case \EnumCaseElementSyntax.identifier:
      return [.identifier("")]
    case \EnumCaseElementSyntax.trailingComma:
      return [.comma]
    case \EnumCaseParameterClauseSyntax.leftParen:
      return [.leftParen]
    case \EnumCaseParameterClauseSyntax.rightParen:
      return [.rightParen]
    case \EnumCaseParameterSyntax.firstName:
      return [.identifier(""), .wildcard]
    case \EnumCaseParameterSyntax.secondName:
      return [.identifier(""), .wildcard]
    case \EnumCaseParameterSyntax.colon:
      return [.colon]
    case \EnumCaseParameterSyntax.trailingComma:
      return [.comma]
    case \EnumDeclSyntax.enumKeyword:
      return [.keyword(.enum)]
    case \EnumDeclSyntax.identifier:
      return [.identifier("")]
    case \ExposeAttributeArgumentsSyntax.comma:
      return [.comma]
    case \ExpressionSegmentSyntax.backslash:
      return [.backslash]
    case \ExpressionSegmentSyntax.delimiter:
      return [.rawStringDelimiter("")]
    case \ExpressionSegmentSyntax.leftParen:
      return [.leftParen]
    case \ExpressionSegmentSyntax.rightParen:
      return [.rightParen]
    case \ExtensionDeclSyntax.extensionKeyword:
      return [.keyword(.extension)]
    case \FallthroughStmtSyntax.fallthroughKeyword:
      return [.keyword(.fallthrough)]
    case \FloatLiteralExprSyntax.floatingDigits:
      return [.floatingLiteral("")]
    case \ForInStmtSyntax.forKeyword:
      return [.keyword(.for)]
    case \ForInStmtSyntax.tryKeyword:
      return [.keyword(.try)]
    case \ForInStmtSyntax.awaitKeyword:
      return [.keyword(.await)]
    case \ForInStmtSyntax.caseKeyword:
      return [.keyword(.case)]
    case \ForInStmtSyntax.inKeyword:
      return [.keyword(.in)]
    case \ForcedValueExprSyntax.exclamationMark:
      return [.exclamationMark]
    case \ForgetStmtSyntax.forgetKeyword:
      return [.keyword(._forget)]
    case \FunctionCallExprSyntax.leftParen:
      return [.leftParen]
    case \FunctionCallExprSyntax.rightParen:
      return [.rightParen]
    case \FunctionDeclSyntax.funcKeyword:
      return [.keyword(.func)]
    case \FunctionDeclSyntax.identifier:
      return [
          .identifier(""), 
          .binaryOperator(""), 
          .prefixOperator(""), 
          .postfixOperator("")
        ]
    case \FunctionEffectSpecifiersSyntax.asyncSpecifier:
      return [.keyword(.async), .keyword(.reasync)]
    case \FunctionEffectSpecifiersSyntax.throwsSpecifier:
      return [.keyword(.throws), .keyword(.rethrows)]
    case \FunctionParameterSyntax.firstName:
      return [.identifier(""), .wildcard]
    case \FunctionParameterSyntax.secondName:
      return [.identifier(""), .wildcard]
    case \FunctionParameterSyntax.colon:
      return [.colon]
    case \FunctionParameterSyntax.ellipsis:
      return [.ellipsis]
    case \FunctionParameterSyntax.trailingComma:
      return [.comma]
    case \FunctionTypeSyntax.leftParen:
      return [.leftParen]
    case \FunctionTypeSyntax.rightParen:
      return [.rightParen]
    case \GenericArgumentClauseSyntax.leftAngleBracket:
      return [.leftAngle]
    case \GenericArgumentClauseSyntax.rightAngleBracket:
      return [.rightAngle]
    case \GenericArgumentSyntax.trailingComma:
      return [.comma]
    case \GenericParameterClauseSyntax.leftAngleBracket:
      return [.leftAngle]
    case \GenericParameterClauseSyntax.rightAngleBracket:
      return [.rightAngle]
    case \GenericParameterSyntax.each:
      return [.keyword(.each)]
    case \GenericParameterSyntax.name:
      return [.identifier("")]
    case \GenericParameterSyntax.colon:
      return [.colon]
    case \GenericParameterSyntax.trailingComma:
      return [.comma]
    case \GenericRequirementSyntax.trailingComma:
      return [.comma]
    case \GenericWhereClauseSyntax.whereKeyword:
      return [.keyword(.where)]
    case \GuardStmtSyntax.guardKeyword:
      return [.keyword(.guard)]
    case \GuardStmtSyntax.elseKeyword:
      return [.keyword(.else)]
    case \IdentifierExprSyntax.identifier:
      return [
          .identifier(""), 
          .keyword(.self), 
          .keyword(.Self), 
          .keyword(.`init`), 
          .dollarIdentifier(""), 
          .binaryOperator("")
        ]
    case \IdentifierPatternSyntax.identifier:
      return [.identifier(""), .keyword(.self), .keyword(.`init`)]
    case \IfConfigClauseSyntax.poundKeyword:
      return [.poundIfKeyword, .poundElseifKeyword, .poundElseKeyword]
    case \IfConfigDeclSyntax.poundEndif:
      return [.poundEndifKeyword]
    case \IfExprSyntax.ifKeyword:
      return [.keyword(.if)]
    case \ImplementsAttributeArgumentsSyntax.comma:
      return [.comma]
    case \ImplicitlyUnwrappedOptionalTypeSyntax.exclamationMark:
      return [.exclamationMark]
    case \ImportDeclSyntax.importTok:
      return [.keyword(.import)]
    case \ImportDeclSyntax.importKind:
      return [
          .keyword(.typealias), 
          .keyword(.struct), 
          .keyword(.class), 
          .keyword(.enum), 
          .keyword(.protocol), 
          .keyword(.var), 
          .keyword(.let), 
          .keyword(.func), 
          .keyword(.inout)
        ]
    case \InOutExprSyntax.ampersand:
      return [.prefixAmpersand]
    case \InheritedTypeSyntax.trailingComma:
      return [.comma]
    case \InitializerClauseSyntax.equal:
      return [.equal]
    case \InitializerDeclSyntax.initKeyword:
      return [.keyword(.`init`)]
    case \InitializerDeclSyntax.optionalMark:
      return [.postfixQuestionMark, .infixQuestionMark, .exclamationMark]
    case \IntegerLiteralExprSyntax.digits:
      return [.integerLiteral("")]
    case \IsExprSyntax.isTok:
      return [.keyword(.is)]
    case \IsTypePatternSyntax.isKeyword:
      return [.keyword(.is)]
    case \KeyPathComponentSyntax.period:
      return [.period]
    case \KeyPathExprSyntax.backslash:
      return [.backslash]
    case \KeyPathOptionalComponentSyntax.questionOrExclamationMark:
      return [.postfixQuestionMark, .exclamationMark]
    case \KeyPathPropertyComponentSyntax.identifier:
      return [
          .identifier(""), 
          .keyword(.self), 
          .keyword(.Self), 
          .keyword(.`init`), 
          .dollarIdentifier(""), 
          .binaryOperator(""), 
          .integerLiteral("")
        ]
    case \KeyPathSubscriptComponentSyntax.leftBracket:
      return [.leftSquareBracket]
    case \KeyPathSubscriptComponentSyntax.rightBracket:
      return [.rightSquareBracket]
    case \LabeledSpecializeEntrySyntax.colon:
      return [.colon]
    case \LabeledSpecializeEntrySyntax.trailingComma:
      return [.comma]
    case \LabeledStmtSyntax.labelName:
      return [.identifier("")]
    case \LabeledStmtSyntax.labelColon:
      return [.colon]
    case \LayoutRequirementSyntax.colon:
      return [.colon]
    case \LayoutRequirementSyntax.layoutConstraint:
      return [
          .keyword(._Trivial), 
          .keyword(._TrivialAtMost), 
          .keyword(._UnknownLayout), 
          .keyword(._RefCountedObject), 
          .keyword(._NativeRefCountedObject), 
          .keyword(._Class), 
          .keyword(._NativeClass)
        ]
    case \LayoutRequirementSyntax.leftParen:
      return [.leftParen]
    case \LayoutRequirementSyntax.size:
      return [.integerLiteral("")]
    case \LayoutRequirementSyntax.comma:
      return [.comma]
    case \LayoutRequirementSyntax.alignment:
      return [.integerLiteral("")]
    case \LayoutRequirementSyntax.rightParen:
      return [.rightParen]
    case \MacroDeclSyntax.macroKeyword:
      return [.keyword(.macro)]
    case \MacroDeclSyntax.identifier:
      return [.identifier("")]
    case \MacroExpansionDeclSyntax.poundToken:
      return [.pound]
    case \MacroExpansionDeclSyntax.macro:
      return [.identifier("")]
    case \MacroExpansionDeclSyntax.leftParen:
      return [.leftParen]
    case \MacroExpansionDeclSyntax.rightParen:
      return [.rightParen]
    case \MacroExpansionExprSyntax.poundToken:
      return [.pound]
    case \MacroExpansionExprSyntax.macro:
      return [.identifier("")]
    case \MacroExpansionExprSyntax.leftParen:
      return [.leftParen]
    case \MacroExpansionExprSyntax.rightParen:
      return [.rightParen]
    case \MatchingPatternConditionSyntax.caseKeyword:
      return [.keyword(.case)]
    case \MemberAccessExprSyntax.dot:
      return [.period]
    case \MemberDeclBlockSyntax.leftBrace:
      return [.leftBrace]
    case \MemberDeclBlockSyntax.rightBrace:
      return [.rightBrace]
    case \MemberDeclListItemSyntax.semicolon:
      return [.semicolon]
    case \MemberTypeIdentifierSyntax.period:
      return [.period]
    case \MemberTypeIdentifierSyntax.name:
      return [.identifier(""), .keyword(.self), .keyword(.Self)]
    case \MetatypeTypeSyntax.period:
      return [.period]
    case \MetatypeTypeSyntax.typeOrProtocol:
      return [.keyword(.Type), .keyword(.Protocol)]
    case \MissingDeclSyntax.placeholder:
      return [.identifier("")]
    case \MissingExprSyntax.placeholder:
      return [.identifier("")]
    case \MissingPatternSyntax.placeholder:
      return [.identifier("")]
    case \MissingStmtSyntax.placeholder:
      return [.identifier("")]
    case \MissingSyntax.placeholder:
      return [.identifier("")]
    case \MissingTypeSyntax.placeholder:
      return [.identifier("")]
    case \MoveExprSyntax.moveKeyword:
      return [.keyword(._move), .keyword(.consume)]
    case \MultipleTrailingClosureElementSyntax.label:
      return [.identifier(""), .wildcard]
    case \MultipleTrailingClosureElementSyntax.colon:
      return [.colon]
    case \NilLiteralExprSyntax.nilKeyword:
      return [.keyword(.nil)]
    case \ObjCSelectorPieceSyntax.colon:
      return [.colon]
    case \OpaqueReturnTypeOfAttributeArgumentsSyntax.comma:
      return [.comma]
    case \OpaqueReturnTypeOfAttributeArgumentsSyntax.ordinal:
      return [.integerLiteral("")]
    case \OperatorDeclSyntax.operatorKeyword:
      return [.keyword(.operator)]
    case \OperatorDeclSyntax.identifier:
      return [.binaryOperator(""), .prefixOperator(""), .postfixOperator("")]
    case \OperatorPrecedenceAndTypesSyntax.colon:
      return [.colon]
    case \OperatorPrecedenceAndTypesSyntax.precedenceGroup:
      return [.identifier("")]
    case \OptionalBindingConditionSyntax.bindingKeyword:
      return [.keyword(.let), .keyword(.var), .keyword(.inout)]
    case \OptionalChainingExprSyntax.questionMark:
      return [.postfixQuestionMark]
    case \OptionalTypeSyntax.questionMark:
      return [.postfixQuestionMark]
    case \OriginallyDefinedInArgumentsSyntax.moduleLabel:
      return [.keyword(.module)]
    case \OriginallyDefinedInArgumentsSyntax.colon:
      return [.colon]
    case \OriginallyDefinedInArgumentsSyntax.comma:
      return [.comma]
    case \PackElementExprSyntax.eachKeyword:
      return [.keyword(.each)]
    case \PackExpansionExprSyntax.repeatKeyword:
      return [.keyword(.repeat)]
    case \PackExpansionTypeSyntax.repeatKeyword:
      return [.keyword(.repeat)]
    case \PackReferenceTypeSyntax.eachKeyword:
      return [.keyword(.each)]
    case \ParameterClauseSyntax.leftParen:
      return [.leftParen]
    case \ParameterClauseSyntax.rightParen:
      return [.rightParen]
    case \PatternBindingSyntax.trailingComma:
      return [.comma]
    case \PostfixUnaryExprSyntax.operatorToken:
      return [.postfixOperator("")]
    case \PoundSourceLocationArgsSyntax.fileArgLabel:
      return [.keyword(.file)]
    case \PoundSourceLocationArgsSyntax.fileArgColon:
      return [.colon]
    case \PoundSourceLocationArgsSyntax.comma:
      return [.comma]
    case \PoundSourceLocationArgsSyntax.lineArgLabel:
      return [.keyword(.line)]
    case \PoundSourceLocationArgsSyntax.lineArgColon:
      return [.colon]
    case \PoundSourceLocationArgsSyntax.lineNumber:
      return [.integerLiteral("")]
    case \PoundSourceLocationSyntax.poundSourceLocation:
      return [.poundSourceLocationKeyword]
    case \PoundSourceLocationSyntax.leftParen:
      return [.leftParen]
    case \PoundSourceLocationSyntax.rightParen:
      return [.rightParen]
    case \PrecedenceGroupAssignmentSyntax.assignmentKeyword:
      return [.keyword(.assignment)]
    case \PrecedenceGroupAssignmentSyntax.colon:
      return [.colon]
    case \PrecedenceGroupAssignmentSyntax.flag:
      return [.keyword(.true), .keyword(.false)]
    case \PrecedenceGroupAssociativitySyntax.associativityKeyword:
      return [.keyword(.associativity)]
    case \PrecedenceGroupAssociativitySyntax.colon:
      return [.colon]
    case \PrecedenceGroupAssociativitySyntax.value:
      return [.keyword(.left), .keyword(.right), .keyword(.none)]
    case \PrecedenceGroupDeclSyntax.precedencegroupKeyword:
      return [.keyword(.precedencegroup)]
    case \PrecedenceGroupDeclSyntax.identifier:
      return [.identifier("")]
    case \PrecedenceGroupDeclSyntax.leftBrace:
      return [.leftBrace]
    case \PrecedenceGroupDeclSyntax.rightBrace:
      return [.rightBrace]
    case \PrecedenceGroupNameElementSyntax.name:
      return [.identifier("")]
    case \PrecedenceGroupNameElementSyntax.trailingComma:
      return [.comma]
    case \PrecedenceGroupRelationSyntax.higherThanOrLowerThan:
      return [.keyword(.higherThan), .keyword(.lowerThan)]
    case \PrecedenceGroupRelationSyntax.colon:
      return [.colon]
    case \PrefixOperatorExprSyntax.operatorToken:
      return [.prefixOperator("")]
    case \PrimaryAssociatedTypeClauseSyntax.leftAngleBracket:
      return [.leftAngle]
    case \PrimaryAssociatedTypeClauseSyntax.rightAngleBracket:
      return [.rightAngle]
    case \PrimaryAssociatedTypeSyntax.name:
      return [.identifier("")]
    case \PrimaryAssociatedTypeSyntax.trailingComma:
      return [.comma]
    case \ProtocolDeclSyntax.protocolKeyword:
      return [.keyword(.protocol)]
    case \ProtocolDeclSyntax.identifier:
      return [.identifier("")]
    case \QualifiedDeclNameSyntax.dot:
      return [.period]
    case \QualifiedDeclNameSyntax.name:
      return [
          .identifier(""), 
          .keyword(.self), 
          .keyword(.Self), 
          .keyword(.`init`), 
          .binaryOperator("")
        ]
    case \RegexLiteralExprSyntax.openingPounds:
      return [.extendedRegexDelimiter("")]
    case \RegexLiteralExprSyntax.openSlash:
      return [.regexSlash]
    case \RegexLiteralExprSyntax.regexPattern:
      return [.regexLiteralPattern("")]
    case \RegexLiteralExprSyntax.closeSlash:
      return [.regexSlash]
    case \RegexLiteralExprSyntax.closingPounds:
      return [.extendedRegexDelimiter("")]
    case \RepeatWhileStmtSyntax.repeatKeyword:
      return [.keyword(.repeat)]
    case \RepeatWhileStmtSyntax.whileKeyword:
      return [.keyword(.while)]
    case \ReturnClauseSyntax.arrow:
      return [.arrow]
    case \ReturnStmtSyntax.returnKeyword:
      return [.keyword(.return)]
    case \SameTypeRequirementSyntax.equalityToken:
      return [.binaryOperator(""), .prefixOperator(""), .postfixOperator("")]
    case \SimpleTypeIdentifierSyntax.name:
      return [
          .identifier(""), 
          .keyword(.self), 
          .keyword(.Self), 
          .keyword(.Any), 
//          .keyword(""), 
          .wildcard
        ]
    case \StringLiteralExprSyntax.openDelimiter:
      return [.rawStringDelimiter("")]
    case \StringLiteralExprSyntax.openQuote:
      return [.stringQuote, .multilineStringQuote, .singleQuote]
    case \StringLiteralExprSyntax.closeQuote:
      return [.stringQuote, .multilineStringQuote, .singleQuote]
    case \StringLiteralExprSyntax.closeDelimiter:
      return [.rawStringDelimiter("")]
    case \StringSegmentSyntax.content:
      return [.stringSegment("")]
    case \StructDeclSyntax.structKeyword:
      return [.keyword(.struct)]
    case \StructDeclSyntax.identifier:
      return [.identifier("")]
    case \SubscriptDeclSyntax.subscriptKeyword:
      return [.keyword(.subscript)]
    case \SubscriptExprSyntax.leftBracket:
      return [.leftSquareBracket]
    case \SubscriptExprSyntax.rightBracket:
      return [.rightSquareBracket]
    case \SuperRefExprSyntax.superKeyword:
      return [.keyword(.super)]
    case \SuppressedTypeSyntax.withoutTilde:
      return [.prefixOperator("")]
    case \SwitchCaseLabelSyntax.caseKeyword:
      return [.keyword(.case)]
    case \SwitchCaseLabelSyntax.colon:
      return [.colon]
    case \SwitchDefaultLabelSyntax.defaultKeyword:
      return [.keyword(.default)]
    case \SwitchDefaultLabelSyntax.colon:
      return [.colon]
    case \SwitchExprSyntax.switchKeyword:
      return [.keyword(.switch)]
    case \SwitchExprSyntax.leftBrace:
      return [.leftBrace]
    case \SwitchExprSyntax.rightBrace:
      return [.rightBrace]
    case \TargetFunctionEntrySyntax.label:
      return [.keyword(.target)]
    case \TargetFunctionEntrySyntax.colon:
      return [.colon]
    case \TargetFunctionEntrySyntax.trailingComma:
      return [.comma]
    case \TernaryExprSyntax.questionMark:
      return [.infixQuestionMark]
    case \TernaryExprSyntax.colonMark:
      return [.colon]
    case \ThrowStmtSyntax.throwKeyword:
      return [.keyword(.throw)]
    case \TryExprSyntax.tryKeyword:
      return [.keyword(.try)]
    case \TryExprSyntax.questionOrExclamationMark:
      return [.postfixQuestionMark, .exclamationMark]
    case \TupleExprElementSyntax.label:
      return [.identifier(""), .wildcard]
    case \TupleExprElementSyntax.colon:
      return [.colon]
    case \TupleExprElementSyntax.trailingComma:
      return [.comma]
    case \TupleExprSyntax.leftParen:
      return [.leftParen]
    case \TupleExprSyntax.rightParen:
      return [.rightParen]
    case \TuplePatternElementSyntax.labelName:
      return [.identifier("")]
    case \TuplePatternElementSyntax.labelColon:
      return [.colon]
    case \TuplePatternElementSyntax.trailingComma:
      return [.comma]
    case \TuplePatternSyntax.leftParen:
      return [.leftParen]
    case \TuplePatternSyntax.rightParen:
      return [.rightParen]
    case \TupleTypeElementSyntax.name:
      return [.identifier(""), .wildcard]
    case \TupleTypeElementSyntax.secondName:
      return [.identifier(""), .wildcard]
    case \TupleTypeElementSyntax.colon:
      return [.colon]
    case \TupleTypeElementSyntax.ellipsis:
      return [.ellipsis]
    case \TupleTypeElementSyntax.trailingComma:
      return [.comma]
    case \TupleTypeSyntax.leftParen:
      return [.leftParen]
    case \TupleTypeSyntax.rightParen:
      return [.rightParen]
    case \TypeAnnotationSyntax.colon:
      return [.colon]
    case \TypeEffectSpecifiersSyntax.asyncSpecifier:
      return [.keyword(.async)]
    case \TypeEffectSpecifiersSyntax.throwsSpecifier:
      return [.keyword(.throws)]
    case \TypeInheritanceClauseSyntax.colon:
      return [.colon]
    case \TypeInitializerClauseSyntax.equal:
      return [.equal]
    case \TypealiasDeclSyntax.typealiasKeyword:
      return [.keyword(.typealias)]
    case \TypealiasDeclSyntax.identifier:
      return [.identifier("")]
    case \UnavailableFromAsyncArgumentsSyntax.messageLabel:
      return [.keyword(.message)]
    case \UnavailableFromAsyncArgumentsSyntax.colon:
      return [.colon]
    case \UnderscorePrivateAttributeArgumentsSyntax.sourceFileLabel:
      return [.keyword(.sourceFile)]
    case \UnderscorePrivateAttributeArgumentsSyntax.colon:
      return [.colon]
    case \UnresolvedAsExprSyntax.asTok:
      return [.keyword(.as)]
    case \UnresolvedAsExprSyntax.questionOrExclamationMark:
      return [.postfixQuestionMark, .exclamationMark]
    case \UnresolvedIsExprSyntax.isTok:
      return [.keyword(.is)]
    case \UnresolvedTernaryExprSyntax.questionMark:
      return [.infixQuestionMark]
    case \UnresolvedTernaryExprSyntax.colonMark:
      return [.colon]
    case \ValueBindingPatternSyntax.bindingKeyword:
      return [.keyword(.let), .keyword(.var), .keyword(.inout)]
    case \VariableDeclSyntax.bindingKeyword:
      return [.keyword(.let), .keyword(.var), .keyword(.inout)]
    case \VersionTupleSyntax.major:
      return [.integerLiteral("")]
    case \VersionTupleSyntax.minorPeriod:
      return [.period]
    case \VersionTupleSyntax.minor:
      return [.integerLiteral("")]
    case \VersionTupleSyntax.patchPeriod:
      return [.period]
    case \VersionTupleSyntax.patch:
      return [.integerLiteral("")]
    case \WhereClauseSyntax.whereKeyword:
      return [.keyword(.where)]
    case \WhileStmtSyntax.whileKeyword:
      return [.keyword(.while)]
    case \WildcardPatternSyntax.wildcard:
      return [.wildcard]
    case \YieldExprListElementSyntax.comma:
      return [.comma]
    case \YieldListSyntax.leftParen:
      return [.leftParen]
    case \YieldListSyntax.rightParen:
      return [.rightParen]
    case \YieldStmtSyntax.yieldKeyword:
      return [.keyword(.yield)]
    default:
      return []
    }
  }
}
