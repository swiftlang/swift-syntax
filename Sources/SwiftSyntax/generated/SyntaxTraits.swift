

// MARK: - DeclGroupSyntax

public protocol DeclGroupSyntax: SyntaxProtocol {
  var attributes: AttributeListSyntax? { get }
  
  func withAttributes(_ newChild: AttributeListSyntax?) -> Self
  
  var modifiers: ModifierListSyntax? { get }
  
  func withModifiers(_ newChild: ModifierListSyntax?) -> Self
  
  var members: MemberDeclBlockSyntax { get }
  
  func withMembers(_ newChild: MemberDeclBlockSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// `DeclGroupSyntax`.
  /// Note that this will incur an existential conversion.
  func isProtocol(_ : DeclGroupSyntax.Protocol) -> Bool {
    return self.asProtocol(DeclGroupSyntax.self) != nil
  }
  
  /// Return the non-type erased version of this syntax node if it conforms to
  /// `DeclGroupSyntax`. Otherwise return `nil`.
  /// Note that this will incur an existential conversion.
  func asProtocol(_ : DeclGroupSyntax.Protocol) -> DeclGroupSyntax? {
    return Syntax(self).asProtocol(SyntaxProtocol.self) as? DeclGroupSyntax
  }
}

// MARK: - BracedSyntax

public protocol BracedSyntax: SyntaxProtocol {
  var leftBrace: TokenSyntax { get }
  
  func withLeftBrace(_ newChild: TokenSyntax?) -> Self
  
  var rightBrace: TokenSyntax { get }
  
  func withRightBrace(_ newChild: TokenSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// `BracedSyntax`.
  /// Note that this will incur an existential conversion.
  func isProtocol(_ : BracedSyntax.Protocol) -> Bool {
    return self.asProtocol(BracedSyntax.self) != nil
  }
  
  /// Return the non-type erased version of this syntax node if it conforms to
  /// `BracedSyntax`. Otherwise return `nil`.
  /// Note that this will incur an existential conversion.
  func asProtocol(_ : BracedSyntax.Protocol) -> BracedSyntax? {
    return Syntax(self).asProtocol(SyntaxProtocol.self) as? BracedSyntax
  }
}

// MARK: - IdentifiedDeclSyntax

public protocol IdentifiedDeclSyntax: SyntaxProtocol {
  var identifier: TokenSyntax { get }
  
  func withIdentifier(_ newChild: TokenSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// `IdentifiedDeclSyntax`.
  /// Note that this will incur an existential conversion.
  func isProtocol(_ : IdentifiedDeclSyntax.Protocol) -> Bool {
    return self.asProtocol(IdentifiedDeclSyntax.self) != nil
  }
  
  /// Return the non-type erased version of this syntax node if it conforms to
  /// `IdentifiedDeclSyntax`. Otherwise return `nil`.
  /// Note that this will incur an existential conversion.
  func asProtocol(_ : IdentifiedDeclSyntax.Protocol) -> IdentifiedDeclSyntax? {
    return Syntax(self).asProtocol(SyntaxProtocol.self) as? IdentifiedDeclSyntax
  }
}

// MARK: - WithCodeBlockSyntax

public protocol WithCodeBlockSyntax: SyntaxProtocol {
  var body: CodeBlockSyntax { get }
  
  func withBody(_ newChild: CodeBlockSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// `WithCodeBlockSyntax`.
  /// Note that this will incur an existential conversion.
  func isProtocol(_ : WithCodeBlockSyntax.Protocol) -> Bool {
    return self.asProtocol(WithCodeBlockSyntax.self) != nil
  }
  
  /// Return the non-type erased version of this syntax node if it conforms to
  /// `WithCodeBlockSyntax`. Otherwise return `nil`.
  /// Note that this will incur an existential conversion.
  func asProtocol(_ : WithCodeBlockSyntax.Protocol) -> WithCodeBlockSyntax? {
    return Syntax(self).asProtocol(SyntaxProtocol.self) as? WithCodeBlockSyntax
  }
}

// MARK: - ParenthesizedSyntax

public protocol ParenthesizedSyntax: SyntaxProtocol {
  var leftParen: TokenSyntax { get }
  
  func withLeftParen(_ newChild: TokenSyntax?) -> Self
  
  var rightParen: TokenSyntax { get }
  
  func withRightParen(_ newChild: TokenSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// `ParenthesizedSyntax`.
  /// Note that this will incur an existential conversion.
  func isProtocol(_ : ParenthesizedSyntax.Protocol) -> Bool {
    return self.asProtocol(ParenthesizedSyntax.self) != nil
  }
  
  /// Return the non-type erased version of this syntax node if it conforms to
  /// `ParenthesizedSyntax`. Otherwise return `nil`.
  /// Note that this will incur an existential conversion.
  func asProtocol(_ : ParenthesizedSyntax.Protocol) -> ParenthesizedSyntax? {
    return Syntax(self).asProtocol(SyntaxProtocol.self) as? ParenthesizedSyntax
  }
}

// MARK: - WithTrailingCommaSyntax

public protocol WithTrailingCommaSyntax: SyntaxProtocol {
  var trailingComma: TokenSyntax? { get }
  
  func withTrailingComma(_ newChild: TokenSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// `WithTrailingCommaSyntax`.
  /// Note that this will incur an existential conversion.
  func isProtocol(_ : WithTrailingCommaSyntax.Protocol) -> Bool {
    return self.asProtocol(WithTrailingCommaSyntax.self) != nil
  }
  
  /// Return the non-type erased version of this syntax node if it conforms to
  /// `WithTrailingCommaSyntax`. Otherwise return `nil`.
  /// Note that this will incur an existential conversion.
  func asProtocol(_ : WithTrailingCommaSyntax.Protocol) -> WithTrailingCommaSyntax? {
    return Syntax(self).asProtocol(SyntaxProtocol.self) as? WithTrailingCommaSyntax
  }
}

// MARK: - WithStatementsSyntax

public protocol WithStatementsSyntax: SyntaxProtocol {
  var statements: CodeBlockItemListSyntax { get }
  
  func withStatements(_ newChild: CodeBlockItemListSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// `WithStatementsSyntax`.
  /// Note that this will incur an existential conversion.
  func isProtocol(_ : WithStatementsSyntax.Protocol) -> Bool {
    return self.asProtocol(WithStatementsSyntax.self) != nil
  }
  
  /// Return the non-type erased version of this syntax node if it conforms to
  /// `WithStatementsSyntax`. Otherwise return `nil`.
  /// Note that this will incur an existential conversion.
  func asProtocol(_ : WithStatementsSyntax.Protocol) -> WithStatementsSyntax? {
    return Syntax(self).asProtocol(SyntaxProtocol.self) as? WithStatementsSyntax
  }
}

extension AccessorBlockSyntax: BracedSyntax {
}

extension AccessorParameterSyntax: ParenthesizedSyntax {
}

extension ActorDeclSyntax: DeclGroupSyntax, IdentifiedDeclSyntax {
}

extension ArrayElementSyntax: WithTrailingCommaSyntax {
}

extension AssociatedtypeDeclSyntax: IdentifiedDeclSyntax {
}

extension CaseItemSyntax: WithTrailingCommaSyntax {
}

extension CatchClauseSyntax: WithCodeBlockSyntax {
}

extension CatchItemSyntax: WithTrailingCommaSyntax {
}

extension ClassDeclSyntax: DeclGroupSyntax, IdentifiedDeclSyntax {
}

extension ClosureCaptureItemSyntax: WithTrailingCommaSyntax {
}

extension ClosureExprSyntax: BracedSyntax, WithStatementsSyntax {
}

extension ClosureParamSyntax: WithTrailingCommaSyntax {
}

extension CodeBlockSyntax: BracedSyntax, WithStatementsSyntax {
}

extension ConditionElementSyntax: WithTrailingCommaSyntax {
}

extension DeclModifierDetailSyntax: ParenthesizedSyntax {
}

extension DeclNameArgumentsSyntax: ParenthesizedSyntax {
}

extension DeferStmtSyntax: WithCodeBlockSyntax {
}

extension DictionaryElementSyntax: WithTrailingCommaSyntax {
}

extension DifferentiabilityParamSyntax: WithTrailingCommaSyntax {
}

extension DoStmtSyntax: WithCodeBlockSyntax {
}

extension EnumCaseElementSyntax: WithTrailingCommaSyntax {
}

extension EnumDeclSyntax: IdentifiedDeclSyntax {
}

extension ExpressionSegmentSyntax: ParenthesizedSyntax {
}

extension ExtensionDeclSyntax: DeclGroupSyntax {
}

extension ForInStmtSyntax: WithCodeBlockSyntax {
}

extension FunctionDeclSyntax: IdentifiedDeclSyntax {
}

extension FunctionParameterSyntax: WithTrailingCommaSyntax {
}

extension FunctionTypeSyntax: ParenthesizedSyntax {
}

extension GenericArgumentSyntax: WithTrailingCommaSyntax {
}

extension GenericParameterSyntax: WithTrailingCommaSyntax {
}

extension GenericRequirementSyntax: WithTrailingCommaSyntax {
}

extension GuardStmtSyntax: WithCodeBlockSyntax {
}

extension IfStmtSyntax: WithCodeBlockSyntax {
}

extension InheritedTypeSyntax: WithTrailingCommaSyntax {
}

extension LabeledSpecializeEntrySyntax: WithTrailingCommaSyntax {
}

extension MacroDeclSyntax: IdentifiedDeclSyntax {
}

extension MemberDeclBlockSyntax: BracedSyntax {
}

extension OperatorDeclSyntax: IdentifiedDeclSyntax {
}

extension ParameterClauseSyntax: ParenthesizedSyntax {
}

extension PatternBindingSyntax: WithTrailingCommaSyntax {
}

extension PoundErrorDeclSyntax: ParenthesizedSyntax {
}

extension PoundSourceLocationSyntax: ParenthesizedSyntax {
}

extension PoundWarningDeclSyntax: ParenthesizedSyntax {
}

extension PrecedenceGroupDeclSyntax: IdentifiedDeclSyntax {
}

extension PrimaryAssociatedTypeSyntax: WithTrailingCommaSyntax {
}

extension ProtocolDeclSyntax: DeclGroupSyntax, IdentifiedDeclSyntax {
}

extension RepeatWhileStmtSyntax: WithCodeBlockSyntax {
}

extension SourceFileSyntax: WithStatementsSyntax {
}

extension StructDeclSyntax: DeclGroupSyntax, IdentifiedDeclSyntax {
}

extension SwitchCaseSyntax: WithStatementsSyntax {
}

extension SwitchStmtSyntax: BracedSyntax {
}

extension TargetFunctionEntrySyntax: WithTrailingCommaSyntax {
}

extension TupleExprElementSyntax: WithTrailingCommaSyntax {
}

extension TupleExprSyntax: ParenthesizedSyntax {
}

extension TuplePatternElementSyntax: WithTrailingCommaSyntax {
}

extension TuplePatternSyntax: ParenthesizedSyntax {
}

extension TupleTypeElementSyntax: WithTrailingCommaSyntax {
}

extension TupleTypeSyntax: ParenthesizedSyntax {
}

extension TypealiasDeclSyntax: IdentifiedDeclSyntax {
}

extension WhileStmtSyntax: WithCodeBlockSyntax {
}
