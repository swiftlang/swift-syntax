//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if swift(>=6)
import SwiftDiagnostics
import SwiftOperators
@_spi(MacroExpansion) import SwiftParser
public import SwiftSyntax
import SwiftSyntaxBuilder
@_spi(MacroExpansion) @_spi(ExperimentalLanguageFeature) public import SwiftSyntaxMacros
#else
import SwiftDiagnostics
import SwiftOperators
@_spi(MacroExpansion) import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder
@_spi(MacroExpansion) @_spi(ExperimentalLanguageFeature) import SwiftSyntaxMacros
#endif

// MARK: - Public entry function

extension SyntaxProtocol {
  /// Expand all uses of the given set of macros within this syntax node.
  @available(*, deprecated, message: "Use contextGenerator form to produce a specific context for each expansion node")
  public func expand(
    macros: [String: Macro.Type],
    in context: some MacroExpansionContext,
    indentationWidth: Trivia? = nil
  ) -> Syntax {
    return expand(
      macros: macros,
      contextGenerator: { _ in context },
      indentationWidth: indentationWidth
    )
  }

  /// Expand all uses of the given set of macros within this syntax node.
  /// - SeeAlso: ``expand(macroSpecs:contextGenerator:indentationWidth:)``
  ///   to also specify the list of conformances passed to the macro expansion.
  public func expand<Context: MacroExpansionContext>(
    macros: [String: Macro.Type],
    contextGenerator: @escaping (Syntax) -> Context,
    indentationWidth: Trivia? = nil
  ) -> Syntax {
    return expand(
      macroSpecs: macros.mapValues { MacroSpec(type: $0) },
      contextGenerator: contextGenerator,
      indentationWidth: indentationWidth
    )
  }

  /// Expand all uses of the given set of macros with specifications within this syntax node.
  public func expand<Context: MacroExpansionContext>(
    macroSpecs: [String: MacroSpec],
    contextGenerator: @escaping (Syntax) -> Context,
    indentationWidth: Trivia? = nil
  ) -> Syntax {
    // Build the macro system.
    var system = MacroSystem()
    for (macroName, macroSpec) in macroSpecs {
      try! system.add(macroSpec, name: macroName)
    }

    let applier = MacroApplication(
      macroSystem: system,
      contextGenerator: contextGenerator,
      indentationWidth: indentationWidth
    )

    return applier.rewrite(self)
  }
}

// MARK: - Expand macros

/// Expand the given freestanding macro and parse the resulting text into a
/// syntax tree.
private func expandFreestandingMemberDeclList(
  definition: Macro.Type,
  node: some FreestandingMacroExpansionSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> MemberBlockItemListSyntax? {
  guard
    let expanded = try expandFreestandingMacro(
      definition: definition,
      macroRole: inferFreestandingMacroRole(definition: definition),
      node: node.detach(in: context, foldingWith: .standardOperators),
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  let indentedSource = adjustIndentationOfFreestandingMacro(expandedCode: expanded, node: node)

  return "\(raw: indentedSource)"
}

private func expandFreestandingCodeItemList(
  definition: Macro.Type,
  node: some FreestandingMacroExpansionSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> CodeBlockItemListSyntax? {
  guard
    let expanded = try expandFreestandingMacro(
      definition: definition,
      macroRole: inferFreestandingMacroRole(definition: definition),
      node: node.detach(in: context, foldingWith: .standardOperators),
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  let indentedSource = adjustIndentationOfFreestandingMacro(expandedCode: expanded, node: node)

  return "\(raw: indentedSource)"
}

private func expandFreestandingExpr(
  definition: Macro.Type,
  node: some FreestandingMacroExpansionSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> ExprSyntax? {
  guard
    let expanded = expandFreestandingMacro(
      definition: definition,
      macroRole: .expression,
      node: node.detach(in: context, foldingWith: .standardOperators),
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  let indentedSource = adjustIndentationOfFreestandingMacro(expandedCode: expanded, node: node)

  return "\(raw: indentedSource)"
}

/// Adds the appropriate indentation on expanded code even if it's multi line.
/// Makes sure original macro expression's trivia is maintained by adding it to expanded code.
private func adjustIndentationOfFreestandingMacro(expandedCode: String, node: some FreestandingMacroExpansionSyntax) -> String {

  if expandedCode.isEmpty {
    return expandedCode.wrappingInTrivia(from: node)
  }

  let indentationOfFirstLine = node.indentationOfFirstLine
  let indentLength = indentationOfFirstLine.sourceLength.utf8Length

  // we are doing 3 step adjustment here
  // step 1: add indentation to each line of expanded code
  // step 2: remove indentation from first line of expaned code
  // step 3: wrap the expanded code into macro expression's trivia. This trivia will contain appropriate existing
  // indentation. Note that if macro expression occurs in middle of the line then there will be no indentation or extra space.
  // Hence we are doing step 2

  var indentedSource = expandedCode.indented(by: indentationOfFirstLine)
  indentedSource.removeFirst(indentLength)
  indentedSource = indentedSource.wrappingInTrivia(from: node)

  return indentedSource
}

private func expandMemberMacro(
  definition: MemberMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  conformanceList: InheritedTypeListSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> MemberBlockItemListSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .member,
      attributeNode: attributeNode.detach(in: context, foldingWith: .standardOperators),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: conformanceList,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // Separate new members from exisiting members by two newlines
  let indentedSource = "\n\n" + expanded.indented(by: attachedTo.indentationOfFirstLine + indentationWidth)
  return "\(raw: indentedSource)"
}

private func expandMemberAttributeMacro(
  definition: MemberAttributeMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo declaration: DeclSyntax,
  providingAttributeFor member: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> AttributeListSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .memberAttribute,
      attributeNode: attributeNode.detach(in: context, foldingWith: .standardOperators),
      declarationNode: member.detach(in: context),
      parentDeclNode: declaration.detach(in: context),
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // The added attributes should be on their own line, so prepend them with a newline.
  let indentedSource = "\n" + expanded.indented(by: member.indentationOfFirstLine)
  return "\(raw: indentedSource)"
}

private func expandPeerMacroMember(
  definition: PeerMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> MemberBlockItemListSyntax? {
  if let variable = attachedTo.as(VariableDeclSyntax.self), variable.bindings.count > 1 {
    throw MacroApplicationError.peerMacroOnVariableWithMultipleBindings
  }

  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .peer,
      attributeNode: attributeNode.detach(in: context, foldingWith: .standardOperators),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // Separate the peers and the declaration by two newlines.
  let indentedSource = "\n\n" + expanded.indented(by: attachedTo.indentationOfFirstLine)
  return "\(raw: indentedSource)"
}

private func expandPeerMacroCodeItem(
  definition: PeerMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> CodeBlockItemListSyntax? {
  if let variable = attachedTo.as(VariableDeclSyntax.self), variable.bindings.count > 1 {
    throw MacroApplicationError.peerMacroOnVariableWithMultipleBindings
  }

  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .peer,
      attributeNode: attributeNode.detach(in: context, foldingWith: .standardOperators),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // Separate the peers and the declaration by two newlines.
  let indentedSource = "\n\n" + expanded.indented(by: attachedTo.indentationOfFirstLine)
  return "\(raw: indentedSource)"
}

/// Expand an accessor macro of a declaration that does not have existing
/// accessors.
///
/// See comment in `expandAccessors` for an explanation why we need this.
private func expandAccessorMacroWithoutExistingAccessors(
  definition: AccessorMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> AccessorBlockSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .accessor,
      attributeNode: attributeNode.detach(in: context, foldingWith: .standardOperators),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    ),
    !expanded.isEmpty
  else {
    return nil
  }

  // `expandAttachedMacro` adds the `{` and `}` to wrap the accessor block and
  // then indents it.
  // Remove any indentation from the first line using `drop(while:)` and then
  // prepend a space to separate it from the variable declaration
  let indentedSource = " " + expanded.indented(by: attachedTo.indentationOfFirstLine).drop(while: { $0.isWhitespace })
  return "\(raw: indentedSource)"
}

/// Expand an accessor macro of a declaration that already has an accessor.
///
/// See comment in `expandAccessors` for an explanation why we need this.
private func expandAccessorMacroWithExistingAccessors(
  definition: AccessorMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> AccessorDeclListSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .accessor,
      attributeNode: attributeNode.detach(in: context, foldingWith: .standardOperators),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // Separate the accessor from any existing accessors by an empty line
  let indentedSource = "\n" + expanded.indented(by: attachedTo.indentationOfFirstLine + indentationWidth)
  return "\(raw: indentedSource)"
}

private func expandExtensionMacro(
  definition: ExtensionMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  conformanceList: InheritedTypeListSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> CodeBlockItemListSyntax? {
  guard attachedTo.isProtocol(DeclGroupSyntax.self) else {
    return nil
  }

  guard let extendedType = attachedTo.syntacticQualifiedTypeContext else {
    return nil
  }

  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .extension,
      attributeNode: attributeNode.detach(in: context, foldingWith: .standardOperators),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: extendedType.detach(in: context),
      conformanceList: conformanceList,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // Separate the extension from other declarations in the source file by two newlines.
  let indentedSource = "\n\n" + expanded
  return "\(raw: indentedSource)"
}

/// Expand a preamble macro into a list of code items.
private func expandPreambleMacro(
  definition: PreambleMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo decl: some DeclSyntaxProtocol & WithOptionalCodeBlockSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) -> CodeBlockItemListSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .preamble,
      attributeNode: attributeNode.detach(
        in: context,
        foldingWith: .standardOperators
      ),
      declarationNode: DeclSyntax(decl.detach(in: context)),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return []
  }

  // Match the indentation of the statements if we can, and put newlines around
  // the preamble to separate it from the rest of the body.
  let indentation = decl.body?.statements.indentationOfFirstLine ?? (decl.indentationOfFirstLine + indentationWidth)
  let indentedSource = "\n" + expanded.indented(by: indentation) + "\n"
  return "\(raw: indentedSource)"
}

private func expandBodyMacro(
  definition: BodyMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo decl: some DeclSyntaxProtocol & WithOptionalCodeBlockSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) -> CodeBlockSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .body,
      attributeNode: attributeNode.detach(
        in: context,
        foldingWith: .standardOperators
      ),
      declarationNode: DeclSyntax(decl.detach(in: context)),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // `expandAttachedMacro` adds the `{` and `}` to wrap the body and then
  // indents it.
  // Remove any indentation from the first line using `drop(while:)` and then
  // prepend a space when it's being introduced on a declaration that has no
  // body yet.
  let leadingWhitespace = decl.body == nil ? " " : ""
  let indentedSource = leadingWhitespace + expanded.indented(by: decl.indentationOfFirstLine).drop(while: { $0.isWhitespace })
  return "\(raw: indentedSource)"
}

// MARK: - MacroSystem

/// Describes the kinds of errors that can occur within a macro system.
enum MacroSystemError: Error {
  /// Indicates that a macro with the given name has already been defined.
  case alreadyDefined(new: Macro.Type, existing: Macro.Type)
}

/// A system of known macros that can be expanded syntactically
struct MacroSystem {
  var macros: [String: MacroSpec] = [:]

  /// Create an empty macro system.
  init() {}

  /// Add a macro specification to the system.
  ///
  /// Throws an error if there is already a macro with this name.
  mutating func add(_ macroSpec: MacroSpec, name: String) throws {
    if let knownMacroSpec = macros[name] {
      throw MacroSystemError.alreadyDefined(new: macroSpec.type, existing: knownMacroSpec.type)
    }

    macros[name] = macroSpec
  }

  /// Look for a macro specification with the given name.
  func lookup(_ macroName: String) -> MacroSpec? {
    return macros[macroName]
  }
}

// MARK: - MacroApplication

/// Removes attributes from a syntax tree while maintaining their surrounding trivia.
@_spi(Testing)
public class AttributeRemover: SyntaxRewriter {
  let predicate: (AttributeSyntax) -> Bool

  var triviaToAttachToNextToken: Trivia = Trivia()

  /// Initializes an attribute remover with a given predicate to determine which attributes to remove.
  ///
  /// - Parameter predicate: A closure that determines whether a given `AttributeSyntax` should be removed.
  ///   If this closure returns `true` for an attribute, that attribute will be removed.
  public init(removingWhere predicate: @escaping (AttributeSyntax) -> Bool) {
    self.predicate = predicate
  }

  public override func visit(_ node: AttributeListSyntax) -> AttributeListSyntax {
    var filteredAttributes: [AttributeListSyntax.Element] = []
    for case .attribute(let attribute) in node {
      if self.predicate(attribute) {
        var leadingTrivia = attribute.leadingTrivia

        // Don't leave behind an empty line when the attribute being removed is on its own line,
        // based on the following conditions:
        //  - Leading trivia ends with a newline followed by arbitrary number of spaces or tabs
        //  - All leading trivia pieces after the last newline are just whitespace, ensuring
        //    there are no comments or other non-whitespace characters on the same line
        //    preceding the attribute.
        //  - There is no trailing trivia and the next token has leading trivia.
        if let lastNewline = leadingTrivia.pieces.lastIndex(where: \.isNewline),
          leadingTrivia.pieces[lastNewline...].allSatisfy(\.isWhitespace),
          attribute.trailingTrivia.isEmpty,
          let nextToken = attribute.nextToken(viewMode: .sourceAccurate),
          !nextToken.leadingTrivia.isEmpty
        {
          leadingTrivia = Trivia(pieces: leadingTrivia.pieces[..<lastNewline])
        }

        // Drop any spaces or tabs from the trailing trivia because there’s no
        // more attribute they need to separate.
        let trailingTrivia = attribute.trailingTrivia.trimmingPrefix(while: \.isSpaceOrTab)
        triviaToAttachToNextToken += leadingTrivia + trailingTrivia

        // If the attribute is not separated from the previous attribute by trivia, as in
        // `@First@Second var x: Int` (yes, that's valid Swift), removing the `@Second`
        // attribute and dropping all its trivia would cause `@First` and `var` to join
        // without any trivia in between, which is invalid. In such cases, the trailing trivia
        // of the attribute is significant and must be retained.
        if triviaToAttachToNextToken.isEmpty,
          let previousToken = attribute.previousToken(viewMode: .sourceAccurate),
          previousToken.trailingTrivia.isEmpty
        {
          triviaToAttachToNextToken = attribute.trailingTrivia
        }
      } else {
        filteredAttributes.append(.attribute(prependAndClearAccumulatedTrivia(to: attribute)))
      }
    }

    // Ensure that any horizontal whitespace trailing the attributes list is trimmed if the next
    // token starts a new line.
    if let nextToken = node.nextToken(viewMode: .sourceAccurate),
      nextToken.leadingTrivia.startsWithNewline
    {
      if !triviaToAttachToNextToken.isEmpty {
        triviaToAttachToNextToken = triviaToAttachToNextToken.trimmingSuffix(while: \.isSpaceOrTab)
      } else if let lastAttribute = filteredAttributes.last {
        filteredAttributes[filteredAttributes.count - 1].trailingTrivia = lastAttribute.trailingTrivia.trimmingSuffix(while: \.isSpaceOrTab)
      }
    }
    return AttributeListSyntax(filteredAttributes)
  }

  public override func visit(_ token: TokenSyntax) -> TokenSyntax {
    return prependAndClearAccumulatedTrivia(to: token)
  }

  /// Prepends the accumulated trivia to the given node's leading trivia.
  ///
  /// To preserve correct formatting after attribute removal, this function reassigns
  /// significant trivia accumulated from removed attributes to the provided subsequent node.
  /// Once attached, the accumulated trivia is cleared.
  ///
  /// - Parameter node: The syntax node receiving the accumulated trivia.
  /// - Returns: The modified syntax node with the prepended trivia.
  private func prependAndClearAccumulatedTrivia<T: SyntaxProtocol>(to syntaxNode: T) -> T {
    defer { triviaToAttachToNextToken = Trivia() }
    return syntaxNode.with(\.leadingTrivia, triviaToAttachToNextToken + syntaxNode.leadingTrivia)
  }
}

private extension Trivia {
  func trimmingPrefix(
    while predicate: (TriviaPiece) -> Bool
  ) -> Trivia {
    Trivia(pieces: self.drop(while: predicate))
  }

  func trimmingSuffix(
    while predicate: (TriviaPiece) -> Bool
  ) -> Trivia {
    Trivia(
      pieces: self[...]
        .reversed()
        .drop(while: predicate)
        .reversed()
    )
  }

  var startsWithNewline: Bool {
    self.first?.isNewline ?? false
  }
}

let diagnosticDomain: String = "SwiftSyntaxMacroExpansion"

private enum MacroApplicationError: DiagnosticMessage, Error {
  case accessorMacroOnVariableWithMultipleBindings
  case peerMacroOnVariableWithMultipleBindings
  case malformedAccessor

  var diagnosticID: MessageID {
    return MessageID(domain: diagnosticDomain, id: "\(self)")
  }

  var severity: DiagnosticSeverity { return .error }

  var message: String {
    switch self {
    case .accessorMacroOnVariableWithMultipleBindings:
      return "accessor macro can only be applied to a single variable"
    case .peerMacroOnVariableWithMultipleBindings:
      return "peer macro can only be applied to a single variable"
    case .malformedAccessor:
      return """
        macro returned a malformed accessor. Accessors should start with an introducer like 'get' or 'set'.
        """
    }
  }
}

/// Syntax rewriter that evaluates any macros encountered along the way.
private class MacroApplication<Context: MacroExpansionContext>: SyntaxRewriter {
  let macroSystem: MacroSystem
  var contextGenerator: (Syntax) -> Context
  var indentationWidth: Trivia
  /// Nodes that we are currently handling in `visitAny` and that should be
  /// visited using the node-specific handling function.
  var skipVisitAnyHandling: Set<Syntax> = []

  /// Store expanded extension while visiting member decls. This should be
  /// added to top-level 'CodeBlockItemList'.
  var extensions: [CodeBlockItemSyntax] = []

  init(
    macroSystem: MacroSystem,
    contextGenerator: @escaping (Syntax) -> Context,
    indentationWidth: Trivia?
  ) {
    self.macroSystem = macroSystem
    self.contextGenerator = contextGenerator

    // Default to 4 spaces if no indentation was passed.
    // In the future, we could consider inferring the indentation width from the
    // source file in which we expand the macros.
    self.indentationWidth = indentationWidth ?? .spaces(4)
    super.init(viewMode: .sourceAccurate)
  }

  override func visitAny(_ node: Syntax) -> Syntax? {
    if skipVisitAnyHandling.contains(node) {
      return nil
    }

    // Expand 'MacroExpansionExpr'.
    // Note that 'MacroExpansionExpr'/'MacroExpansionExprDecl' at code item
    // position are handled by 'visit(_:CodeBlockItemListSyntax)'.
    // Only expression expansions inside other syntax nodes is handled here.
    switch expandExpr(node: node) {
    case .success(let expanded):
      return Syntax(visit(expanded))
    case .failure:
      return Syntax(node)
    case .notAMacro:
      break
    }
    if var declSyntax = node.as(DeclSyntax.self),
      let attributedNode = node.asProtocol(WithAttributesSyntax.self),
      !attributedNode.attributes.isEmpty
    {
      // Apply body and preamble macros.
      if let nodeWithBody = node.asProtocol(WithOptionalCodeBlockSyntax.self),
        let declNodeWithBody = nodeWithBody as? any DeclSyntaxProtocol & WithOptionalCodeBlockSyntax
      {
        declSyntax = DeclSyntax(visitBodyAndPreambleMacros(declNodeWithBody))
      }

      // Visit the node, disabling the `visitAny` handling.
      skipVisitAnyHandling.insert(Syntax(declSyntax))
      let visitedNode = self.visit(declSyntax)
      skipVisitAnyHandling.remove(Syntax(declSyntax))

      let attributesToRemove = self.macroAttributes(attachedTo: visitedNode).map(\.attributeNode)

      return AttributeRemover(removingWhere: { attributesToRemove.contains($0) }).rewrite(visitedNode)
    }

    return nil
  }

  /// Visit for both the body and preamble macros.
  func visitBodyAndPreambleMacros<Node: DeclSyntaxProtocol & WithOptionalCodeBlockSyntax>(
    _ node: Node
  ) -> Node {
    // Expand preamble macros into a set of code items.
    let preamble = expandMacros(attachedTo: DeclSyntax(node), ofType: PreambleMacro.Type.self) { attributeNode, definition, _ in
      expandPreambleMacro(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: node,
        in: contextGenerator(Syntax(node)),
        indentationWidth: indentationWidth
      )
    }

    // Expand body macro.
    let expandedBodies = expandMacros(attachedTo: DeclSyntax(node), ofType: BodyMacro.Type.self) { attributeNode, definition, _ in
      expandBodyMacro(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: node,
        in: contextGenerator(Syntax(node)),
        indentationWidth: indentationWidth
      ).map { [$0] }
    }

    // Dig out the body.
    let body: CodeBlockSyntax
    switch expandedBodies.count {
    case 0 where preamble.isEmpty:
      // Nothing changes
      return node

    case 0:
      guard let existingBody = node.body else {
        // Any leftover preamble statements have nowhere to go, complain and
        // exit.
        contextGenerator(Syntax(node)).addDiagnostics(from: MacroExpansionError.preambleWithoutBody, node: node)

        return node
      }

      body = existingBody

    case 1:
      body = expandedBodies[0]

    default:
      contextGenerator(Syntax(node)).addDiagnostics(from: MacroExpansionError.moreThanOneBodyMacro, node: node)
      body = expandedBodies[0]
    }

    // If there's no preamble, swap in the new body.
    if preamble.isEmpty {
      return node.with(\.body, body)
    }

    return node.with(\.body, body.with(\.statements, preamble + body.statements))
  }

  override func visit(_ node: CodeBlockItemListSyntax) -> CodeBlockItemListSyntax {
    var newItems: [CodeBlockItemSyntax] = []
    func addResult(_ node: CodeBlockItemSyntax) {
      // Expand freestanding macro.
      switch expandCodeBlockItem(node: node) {
      case .success(let expanded):
        for item in expanded {
          addResult(item)
        }
        return
      case .failure:
        // Expanding the macro threw an error. We don't have an expanded source.
        // Retain the macro node as-is.
        newItems.append(node)
      case .notAMacro:
        // Recurse on the child node
        newItems.append(visit(node))
      }

      // Expand any peer macro on this item.
      if case .decl(let decl) = node.item {
        for peer in expandCodeBlockPeers(of: decl) {
          addResult(peer)
        }
        extensions += expandExtensions(of: decl)
      }
    }

    for item in node {
      addResult(item)
    }

    // If this is the top-level code block item list, add the expanded extensions
    // at its end.
    if node.parent?.is(SourceFileSyntax.self) ?? false {
      newItems += extensions
    }

    return CodeBlockItemListSyntax(newItems)
  }

  override func visit(_ node: MemberBlockSyntax) -> MemberBlockSyntax {
    let parentDeclGroup = node
      .parent?
      .as(DeclSyntax.self)
    var newItems: [MemberBlockItemSyntax] = []

    func addResult(_ node: MemberBlockItemSyntax) {
      // Expand freestanding macro.
      switch expandMemberDecl(node: node) {
      case .success(let expanded):
        for item in expanded {
          addResult(item)
        }
        return
      case .failure:
        newItems.append(node)
      case .notAMacro:
        // Recurse on the child node.
        newItems.append(visit(node))
      }

      // Expand any peer macro on this member.
      for peer in expandMemberDeclPeers(of: node.decl) {
        addResult(peer)
      }
      extensions += expandExtensions(of: node.decl)
    }

    for var item in node.members {
      // Expand member attribute members attached to the declaration context.
      // Note that MemberAttribute macros are _not_ applied to generated members
      if let parentDeclGroup, let decl = item.decl.asProtocol(WithAttributesSyntax.self) {
        var newAttributes = AttributeListSyntax(
          expandAttributesFromMemberAttributeMacros(
            of: item.decl,
            parentDecl: parentDeclGroup
          )
          .map { visit($0) }
        )
        if !newAttributes.isEmpty {
          // Transfer the trailing trivia from the old attributes to the new attributes.
          // This way, we essentially insert the new attributes right after the last attribute in source
          // but before its trailing trivia, keeping the trivia that separates the attribute block
          // from the variable itself.
          newAttributes.trailingTrivia = newAttributes.trailingTrivia + decl.attributes.trailingTrivia
          newAttributes.insert(contentsOf: decl.attributes.with(\.trailingTrivia, []), at: newAttributes.startIndex)
          item.decl = decl.with(\.attributes, newAttributes).cast(DeclSyntax.self)
        }
      }

      // Recurse on the child node.
      addResult(item)
    }

    // Expand any member macros of parent.
    if let parentDeclGroup {
      for member in expandMembers(of: parentDeclGroup) {
        addResult(member)
      }
    }

    /// Returns an leading trivia for the member blocks closing brace.
    /// It will add a leading newline, if there is none.
    var leadingTriviaForClosingBrace: Trivia {
      if newItems.isEmpty {
        return node.rightBrace.leadingTrivia
      }

      if node.rightBrace.leadingTrivia.contains(where: { $0.isNewline }) {
        return node.rightBrace.leadingTrivia
      }

      if newItems.last?.trailingTrivia.pieces.last?.isNewline ?? false {
        return node.rightBrace.leadingTrivia
      } else {
        return .newline + node.rightBrace.leadingTrivia
      }
    }

    return MemberBlockSyntax(
      leftBrace: node.leftBrace,
      members: MemberBlockItemListSyntax(newItems),
      rightBrace: node.rightBrace.with(\.leadingTrivia, leadingTriviaForClosingBrace)
    )
  }

  override func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
    var node = super.visit(node).cast(VariableDeclSyntax.self)

    guard !macroAttributes(attachedTo: DeclSyntax(node), ofType: AccessorMacro.Type.self).isEmpty else {
      return DeclSyntax(node)
    }

    guard node.bindings.count == 1, let binding = node.bindings.first else {
      contextGenerator(Syntax(node)).addDiagnostics(from: MacroApplicationError.accessorMacroOnVariableWithMultipleBindings, node: node)
      return DeclSyntax(node)
    }

    let expansion = expandAccessors(of: node, existingAccessors: binding.accessorBlock)
    if expansion.accessors != binding.accessorBlock {
      if binding.initializer != nil, expansion.expandsGetSet {
        // The accessor block will have a leading space, but there will already be a
        // space between the variable and the to-be-removed initializer. Remove the
        // leading trivia on the accessor block so we don't double up.
        node.bindings[node.bindings.startIndex].accessorBlock = expansion.accessors?.with(\.leadingTrivia, [])
        node.bindings[node.bindings.startIndex].initializer = nil
      } else {
        node.bindings[node.bindings.startIndex].accessorBlock = expansion.accessors
      }
    }

    return DeclSyntax(node)
  }

  override func visit(_ node: SubscriptDeclSyntax) -> DeclSyntax {
    var node = super.visit(node).cast(SubscriptDeclSyntax.self)
    node.accessorBlock = expandAccessors(of: node, existingAccessors: node.accessorBlock).accessors
    return DeclSyntax(node)
  }
}

// MARK:  Attached macro expansions.

extension MacroApplication {
  /// Get pairs of a macro attribute and the macro specification attached to `decl`.
  ///
  /// The macros must be registered in `macroSystem`.
  private func macroAttributes(
    attachedTo decl: DeclSyntax
  ) -> [(attributeNode: AttributeSyntax, spec: MacroSpec)] {
    guard let attributedNode = decl.asProtocol(WithAttributesSyntax.self) else {
      return []
    }

    return attributedNode.attributes.compactMap {
      guard case let .attribute(attribute) = $0,
        let attributeName = attribute.attributeName.as(IdentifierTypeSyntax.self)?.name.text,
        let macroSpec = macroSystem.lookup(attributeName)
      else {
        return nil
      }

      return (attribute, macroSpec)
    }
  }

  /// Get a list of the macro attribute, the macro definition and the conformance
  /// protocols list attached to `decl` matching `ofType` macro type.
  ///
  /// The macros must be registered in `macroSystem`.
  private func macroAttributes<MacroType>(
    attachedTo decl: DeclSyntax,
    ofType: MacroType.Type
  ) -> [(attributeNode: AttributeSyntax, definition: MacroType, conformanceList: InheritedTypeListSyntax)] {
    return macroAttributes(attachedTo: decl)
      .compactMap { (attributeNode: AttributeSyntax, spec: MacroSpec) in
        if let macroType = spec.type as? MacroType {
          return (attributeNode, macroType, spec.inheritedTypeList)
        } else {
          return nil
        }
      }
  }

  /// Call `expandMacro` for every macro of type `ofType` attached to `decl` and
  /// return the list of all expaned nodes.
  private func expandMacros<
    ExpandedNode: SyntaxProtocol,
    ExpanedNodeCollection: Sequence<ExpandedNode>,
    MacroType
  >(
    attachedTo decl: DeclSyntax,
    ofType: MacroType.Type,
    expandMacro: (_ attributeNode: AttributeSyntax, _ definition: MacroType, _ conformanceList: InheritedTypeListSyntax) throws -> ExpanedNodeCollection?
  ) -> [ExpandedNode] {
    var result: [ExpandedNode] = []

    for macroAttribute in macroAttributes(attachedTo: decl, ofType: ofType) {
      do {
        if let expanded = try expandMacro(macroAttribute.attributeNode, macroAttribute.definition, macroAttribute.conformanceList) {
          result += expanded
        }
      } catch {
        contextGenerator(Syntax(decl)).addDiagnostics(from: error, node: macroAttribute.attributeNode)
      }
    }
    return result
  }

  /// Expand all the 'peer' macros attached to `decl`.
  ///
  /// - Note: This overload returns the list of peers as `MemberDeclListItemSyntax`
  ///   while `expandCodeBlockPeers` returns them as `CodeBlockItemSyntax`. The
  ///   overload is chosen based on the context in which the peers are expanded.
  ///
  /// - Returns: The macro-synthesized peers
  private func expandMemberDeclPeers(of decl: DeclSyntax) -> [MemberBlockItemSyntax] {
    return expandMacros(attachedTo: decl, ofType: PeerMacro.Type.self) { attributeNode, definition, conformanceList in
      return try expandPeerMacroMember(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: decl,
        in: contextGenerator(Syntax(decl)),
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand all the 'peer' macros attached to `decl`.
  ///
  /// - Note: This overload returns the list of peers as `MemberDeclListItemSyntax`
  ///   while `expandMemberDeclPeers` returns them as `MemberDeclListItemSyntax`.
  ///   The overload is chosen based on the context in which the peers are
  ///   expanded.
  ///
  /// - Returns: The macro-synthesized peers
  private func expandCodeBlockPeers(of decl: DeclSyntax) -> [CodeBlockItemSyntax] {
    return expandMacros(attachedTo: decl, ofType: PeerMacro.Type.self) { attributeNode, definition, conformanceList in
      return try expandPeerMacroCodeItem(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: decl,
        in: contextGenerator(Syntax(decl)),
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand all 'extension' macros attached to `decl`.
  ///
  /// - Returns: The macro-synthesized extensions
  private func expandExtensions(of decl: DeclSyntax) -> [CodeBlockItemSyntax] {
    return expandMacros(attachedTo: decl, ofType: ExtensionMacro.Type.self) { attributeNode, definition, conformanceList in
      return try expandExtensionMacro(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: decl,
        conformanceList: conformanceList,
        in: contextGenerator(Syntax(decl)),
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand all 'member' macros attached to `decl`.
  private func expandMembers(of decl: DeclSyntax) -> [MemberBlockItemSyntax] {
    return expandMacros(attachedTo: decl, ofType: MemberMacro.Type.self) { attributeNode, definition, conformanceList in
      return try expandMemberMacro(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: decl,
        conformanceList: conformanceList,
        in: contextGenerator(Syntax(decl)),
        indentationWidth: indentationWidth
      )
    }
  }

  /// Return the attributes on `decl` that are synthesized from member attribute
  /// macros on `parentDecl`.
  ///
  /// - Note: This only returns synthesized attributes from member attribute
  ///   macros, not the attributes that are attached to `decl` in the source code.
  private func expandAttributesFromMemberAttributeMacros(
    of decl: DeclSyntax,
    parentDecl: DeclSyntax
  ) -> [AttributeListSyntax.Element] {
    return expandMacros(attachedTo: parentDecl, ofType: MemberAttributeMacro.Type.self) { attributeNode, definition, conformanceList in
      return try expandMemberAttributeMacro(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: parentDecl,
        providingAttributeFor: decl,
        in: contextGenerator(Syntax(decl)),
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand all 'accessor' macros attached to `storage`.
  ///
  /// - Returns: The final accessors block that includes both the existing
  ///   and expanded accessors, as well as whether any `get`/`set` were
  ///   expanded (in which case any initializer on `storage` should be
  ///   removed).
  private func expandAccessors(of storage: some DeclSyntaxProtocol, existingAccessors: AccessorBlockSyntax?) -> (
    accessors: AccessorBlockSyntax?, expandsGetSet: Bool
  ) {
    let accessorMacros = macroAttributes(attachedTo: DeclSyntax(storage), ofType: AccessorMacro.Type.self)

    var newAccessorsBlock = existingAccessors
    var expandsGetSet = false
    func checkExpansions(_ accessors: AccessorDeclListSyntax?) {
      guard let accessors else { return }
      expandsGetSet = expandsGetSet || accessors.contains(where: \.isGetOrSet)
    }

    for macro in accessorMacros {
      do {
        // Accessor macros get expanded differently depending on whether the
        // variable already had an accessor. If not, '{' and '}' to wrap the
        // accessor block are added. If an accessor block already exists, only
        // the new accessors are returned.
        // We need to parse the result from the macro invocation differently
        // based on these cases.
        if existingAccessors != nil {
          if let newAccessors = try expandAccessorMacroWithExistingAccessors(
            definition: macro.definition,
            attributeNode: macro.attributeNode,
            attachedTo: DeclSyntax(storage),
            in: contextGenerator(Syntax(storage)),
            indentationWidth: indentationWidth
          ) {
            checkExpansions(newAccessors)

            // If existingAccessors is not `nil`, then we also set
            // `newAccessorBlock` above to a a non-nil value, so
            // `newAccessorsBlock` also isn’t `nil`.
            newAccessorsBlock = newAccessorsBlock!.addingAccessors(
              from: newAccessors,
              indentationWidth: self.indentationWidth
            )
          }
        } else if let newAccessors = try expandAccessorMacroWithoutExistingAccessors(
          definition: macro.definition,
          attributeNode: macro.attributeNode,
          attachedTo: DeclSyntax(storage),
          in: contextGenerator(Syntax(storage)),
          indentationWidth: indentationWidth
        ) {
          guard case .accessors(let accessorList) = newAccessors.accessors else {
            throw MacroApplicationError.malformedAccessor
          }

          checkExpansions(accessorList)

          if let oldBlock = newAccessorsBlock {
            newAccessorsBlock = oldBlock.addingAccessors(
              from: accessorList,
              indentationWidth: self.indentationWidth
            )
          } else {
            newAccessorsBlock = newAccessors
          }
        }
      } catch {
        contextGenerator(Syntax(storage)).addDiagnostics(from: error, node: macro.attributeNode)
      }
    }
    return (newAccessorsBlock, expandsGetSet)
  }
}

// MARK: Freestanding macro expansion

extension MacroApplication {
  enum MacroExpansionResult<ResultType> {
    /// Expansion of the macro succeeded.
    case success(ResultType)

    /// Macro system found the macro to expand but running the expansion threw
    /// an error and thus no expansion result exists.
    case failure

    /// The node that should be expanded was not a macro known to the macro system.
    case notAMacro
  }

  private func expandFreestandingMacro<ExpandedMacroType: SyntaxProtocol>(
    _ node: (any FreestandingMacroExpansionSyntax)?,
    expandMacro: (_ macro: Macro.Type, _ node: any FreestandingMacroExpansionSyntax) throws -> ExpandedMacroType?
  ) -> MacroExpansionResult<ExpandedMacroType> {
    guard let node,
      let macro = macroSystem.lookup(node.macroName.text)?.type
    else {
      return .notAMacro
    }
    do {
      if let expanded = try expandMacro(macro, node) {
        return .success(expanded)
      } else {
        return .failure
      }
    } catch {
      contextGenerator(Syntax(node)).addDiagnostics(from: error, node: node)
      return .failure
    }
  }

  /// Expand a freestanding macro expansion syntax in a code block item position.
  ///
  /// For example
  /// ```swift
  /// function test() {
  ///   #foo
  /// }
  /// ```
  func expandCodeBlockItem(node: CodeBlockItemSyntax) -> MacroExpansionResult<CodeBlockItemListSyntax> {
    return expandFreestandingMacro(node.item.asProtocol(FreestandingMacroExpansionSyntax.self)) { macro, node in
      return try expandFreestandingCodeItemList(
        definition: macro,
        node: node,
        in: contextGenerator(Syntax(node)),
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand a freestanding macro expansion syntax in a member decl position.
  ///
  /// For exmple
  /// ```swift
  /// struct S {
  ///   #foo
  /// }
  /// ```
  func expandMemberDecl(node: MemberBlockItemSyntax) -> MacroExpansionResult<MemberBlockItemListSyntax> {
    return expandFreestandingMacro(node.decl.as(MacroExpansionDeclSyntax.self)) { macro, node in
      return try expandFreestandingMemberDeclList(
        definition: macro,
        node: node,
        in: contextGenerator(Syntax(node)),
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand a freestanding macro expansion in a expression position inside
  /// other products.
  ///
  /// For example
  /// ```swift
  /// let a = #foo
  /// ```
  func expandExpr(node: Syntax) -> MacroExpansionResult<ExprSyntax> {
    return expandFreestandingMacro(node.as(MacroExpansionExprSyntax.self)) { macro, node in
      return try expandFreestandingExpr(
        definition: macro,
        node: node,
        in: contextGenerator(Syntax(node)),
        indentationWidth: indentationWidth
      )
    }
  }
}

// MARK: Syntax utilities

private extension AccessorBlockSyntax {
  /// Create a new `AccessorBlockSyntax` by adding the given accessors.
  ///
  /// If this `AccessorBlockSyntax` contains a single code block as a getter,
  /// that code block will be converted to an explicit 'get' accessor. This
  /// causes the body to be indented by `indentationWidth`.
  func addingAccessors(
    from newAccessors: AccessorDeclListSyntax,
    indentationWidth: Trivia
  ) -> AccessorBlockSyntax {
    var result = self
    switch self.accessors {
    case .accessors(let accessors):
      result.accessors = .accessors(accessors + Array(newAccessors))
    case .getter(let getter):
      if newAccessors.isEmpty {
        return self
      }
      // Convert the existing getter into an explicit accessor (with 'get') so
      // we can add more accessors.
      let baseIndentation = getter.indentationOfFirstLine
      let getterAsAccessor = AccessorDeclSyntax(
        accessorSpecifier: .keyword(.get, leadingTrivia: .newline + baseIndentation, trailingTrivia: .space),
        body: CodeBlockSyntax(
          leftBrace: .leftBraceToken(),
          statements: Indenter.indent(getter, indentation: indentationWidth),
          rightBrace: .rightBraceToken(leadingTrivia: .newline + baseIndentation)
        )
      )
      result.accessors = .accessors(AccessorDeclListSyntax([getterAsAccessor] + Array(newAccessors)))
    #if RESILIENT_LIBRARIES
    @unknown default:
      fatalError()
    #endif
    }
    return result
  }
}

private extension String {
  /// Add any trivia from `node` before/after this string.
  ///
  /// We need to do this because we are replacing the entire macro expansion
  /// declaration / expression with the expanded source but semantically, the
  /// user should think about it as just replacing the `#...` expression without
  /// any trivia.
  func wrappingInTrivia(from node: some SyntaxProtocol) -> String {
    return node.leadingTrivia.description
      + self
      + node.trailingTrivia.description
  }
}

private extension SyntaxProtocol {
  /// Detach the current node and inform the macro expansion context,
  /// if it needs to know.
  func detach(in context: MacroExpansionContext) -> Self {
    if let basicContext = context as? BasicMacroExpansionContext {
      return basicContext.detach(self)
    }

    return self.detached
  }

  /// Fold operators in this node using the given operator table, detach the
  /// node and inform the macro expansion context, if it needs to know.
  func detach(
    in context: MacroExpansionContext,
    foldingWith operatorTable: OperatorTable?
  ) -> Syntax {
    let folded: Syntax
    if let operatorTable {
      if let basicContext = context as? BasicMacroExpansionContext {
        folded = basicContext.foldAllOperators(of: self, with: operatorTable)
      } else {
        folded = operatorTable.foldAll(self, errorHandler: { _ in /*ignore*/ })
      }
    } else {
      folded = Syntax(self)
    }
    return folded.detach(in: context)
  }
}

private extension FreestandingMacroExpansionSyntax {
  /// Same as `SyntaxProtocol.detach(in:foldingWith:)` but returns a node of type
  /// `Self` since we know that operator folding doesn't change the type of any
  /// `FreestandingMacroExpansionSyntax`.
  func detach(
    in context: MacroExpansionContext,
    foldingWith operatorTable: OperatorTable?
  ) -> Self {
    return (detach(in: context, foldingWith: operatorTable) as Syntax).cast(Self.self)
  }
}

private extension AttributeSyntax {
  /// Same as `SyntaxProtocol.detach(in:foldingWith:)` but returns a node of type
  /// `Self` since we know that operator folding doesn't change the type of any
  /// `AttributeSyntax`.
  func detach(
    in context: MacroExpansionContext,
    foldingWith operatorTable: OperatorTable?
  ) -> Self {
    return (detach(in: context, foldingWith: operatorTable) as Syntax).cast(Self.self)
  }
}

private extension AccessorDeclSyntax {
  var isGetOrSet: Bool {
    return accessorSpecifier.tokenKind == .keyword(.get) || accessorSpecifier.tokenKind == .keyword(.set)
  }
}

private extension SyntaxProtocol {
  /// Retrieve the qualified type for the nearest extension or name decl.
  ///
  /// For example, for `struct Foo { struct Bar {} }`, calling this on the
  /// inner struct (`Bar`) will return `Foo.Bar`.
  var syntacticQualifiedTypeContext: TypeSyntax? {
    if let ext = self.as(ExtensionDeclSyntax.self) {
      // Don't handle nested 'extension' cases - they are invalid anyway.
      return ext.extendedType.trimmed
    }

    let base = self.parent?.syntacticQualifiedTypeContext
    if let named = self.asProtocol(NamedDeclSyntax.self) {
      if let base = base {
        return TypeSyntax(MemberTypeSyntax(baseType: base, name: named.name.trimmed))
      }
      return TypeSyntax(IdentifierTypeSyntax(name: named.name.trimmed))
    }
    return base
  }
}
