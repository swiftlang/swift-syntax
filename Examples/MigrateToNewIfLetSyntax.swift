import Foundation
import SwiftSyntax
import SwiftParser

/// MigrateToNewIfLetSyntax will visit each `if` statement in the syntax tree
/// replacing all "old style" optional bindings by the new shorter syntax available
/// since Swift 5.7.
///
/// For example, it will turn:
/// ```
/// if let foo = foo {
///   ...
/// }
/// ```
/// into:
/// ```
/// if let foo {
///   ...
/// }
class MigrateToNewIfLetSyntax: SyntaxRewriter {
  // Visit all `if` statements.
  override func visit(_ node: IfStmtSyntax) -> StmtSyntax {
    // Visit all conditions in the node.
    let newConditions = node.conditions.enumerated().map { (index, condition) in
      var conditionCopy = condition
      // Check if the condition is an optional binding ...
      if var binding = condition.condition.as(OptionalBindingConditionSyntax.self),
         // ... and has an initializer ...
         let initializer = binding.initializer,
         // ... and both sides of the assignment are the same identifiers.
         binding.pattern.withoutTrivia().description == initializer.value.withoutTrivia().description {
        // Remove the initializer ... 
        binding.initializer = nil
        // ... and remove whitespace before the comma (in `if` statements with multiple conditions).
        if index != node.conditions.count - 1 {
          binding.pattern = binding.pattern.withoutTrailingTrivia()
        }
        conditionCopy.condition = Syntax(binding)
      }
      return conditionCopy
    }
    return StmtSyntax(node.withConditions(ConditionElementListSyntax(newConditions)))
  }
  
  /// Utility function to migrate all swift files in a folder and its subfolders
  static func migrate(folderPath: String) {
    for case let fileURL as String in FileManager.default.enumerator(atPath: folderPath)! {
      if fileURL.hasSuffix("swift") {
        print("Rewriting", fileURL)
        let fullPath = folderPath + "/" + fileURL
        let tree = try! Parser.parse(source: String(data: FileManager.default.contents(atPath: fullPath)!, encoding: .utf8 )!)
        let newTree = MigrateToNewIfLetSyntax().visit(tree)
        try! newTree.description.write(toFile: fullPath, atomically: true, encoding: .utf8)
      }
    }
  }
}

MigrateToNewIfLetSyntax.migrate(folderPath: "/path/to/folder")
