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

//
// This file defines the SyntaxRewriter, a class that performs a standard walk
// and tree-rebuilding pattern.
//
// Subclassers of this class can override the walking behavior for any syntax
// node and transform nodes however they like.
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// Syntax rewriter that only visits syntax nodes that are active according
/// to a particular build configuration build configuration.
///
/// Given an example such as
/// ```
/// #if os(Linux)
/// func f() { }
/// #elseif os(iOS)
/// func g() { }
/// #endif
/// ```
///
/// the rewriter will eliminate nodes for inactive clauses, leaving only
/// those nodes that are in active clauses. When rewriting the above given
/// a build configuration for Linux, the resulting tree will be
///
/// ```
/// func f() { }
/// ```
///
/// When rewriting the above given a build configuration for iOS, the resulting
/// tree will be
///
/// ```
/// func g() { }
/// ```
///
/// For any other target platforms, the resulting tree will be empty (other
/// than trivia).
class ActiveSyntaxRewriter<Configuration: BuildConfiguration> : SyntaxRewriter {
  let configuration: Configuration
  
  init(configuration: Configuration) {
    self.configuration = configuration
  }
  
  private func dropInactive<List: Collection & SyntaxCollection>(
    _ node: List,
    elementAsIfConfig: (List.Element) -> IfConfigDeclSyntax?
  ) -> List {
    var newElements: [List.Element] = []
    var anyChanged = false
    for elementIndex in node.indices {
      let element = node[elementIndex]
      
      // Find #ifs within the list.
      if let ifConfigDecl = elementAsIfConfig(element) {
        // If this is the first element that changed, note that we have
        // changes and add all prior elements to the list of new elements.
        if !anyChanged {
          anyChanged = true
          newElements.append(contentsOf: node[..<elementIndex])
        }
        
        // FIXME: Swallowing errors
        guard let activeClause = try? ifConfigDecl.activeClause(in: configuration) else {
          continue
        }
        
        guard let elements = activeClause.elements else {
          continue
        }
        
        let innerElements = Syntax(elements).cast(List.self)
        let newInnerElements = dropInactive(innerElements, elementAsIfConfig: elementAsIfConfig)
        newElements.append(contentsOf: newInnerElements)
        
        continue
      }
      
      if anyChanged {
        newElements.append(element)
      }
    }
    
    if !anyChanged {
      return node
    }
    
    return List(newElements)
  }
  
  override func visit(_ node: CodeBlockItemListSyntax) -> CodeBlockItemListSyntax {
    let rewrittenNode = dropInactive(node) { element in
      guard case .decl(let declElement) = element.item else {
        return nil
      }
      
      return declElement.as(IfConfigDeclSyntax.self)
    }
    
    return super.visit(rewrittenNode)
  }
  
  override func visit(_ node: MemberDeclListSyntax) -> MemberDeclListSyntax {
    let rewrittenNode = dropInactive(node) { element in
      return element.decl.as(IfConfigDeclSyntax.self)
    }
    
    return super.visit(rewrittenNode)
  }
  
  override func visit(_ node: SwitchCaseListSyntax) -> SwitchCaseListSyntax {
    let rewrittenNode = dropInactive(node) { element in
      if case .ifConfigDecl(let ifConfigDecl) = element {
        return ifConfigDecl
      }
      
      return nil
    }
    
    return super.visit(rewrittenNode)
  }

  override func visit(_ node: AttributeListSyntax) -> AttributeListSyntax {
    let rewrittenNode = dropInactive(node) { element in
      if case .ifConfigDecl(let ifConfigDecl) = element {
        return ifConfigDecl
      }

      return nil
    }

    return super.visit(rewrittenNode)
  }
}


extension SyntaxProtocol {
  /// Produce a copy of this syntax node that removes all syntax regions that
  /// are inactive according to the given build configuration, leaving only
  /// the code that is active within that build configuration.
  public func removingInactive(in configuration: some BuildConfiguration) -> Syntax {
    let visitor = ActiveSyntaxRewriter(configuration: configuration)
    return visitor.rewrite(Syntax(self))
  }
}
