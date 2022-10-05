import Foundation
import SwiftSyntax
import SwiftParser

/// MigrateToNewIfLetSyntax will visit each if statement in the Syntax tree, and
/// checks if the there is an if condition which is of the pre Swift 5.7 "if-let-style"
/// and rewrites it to the new one
///
/// For example will it turn:
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
  // Visit over all IfStmtSyntax nodes
  override func visit(_ node: IfStmtSyntax) -> StmtSyntax {
    // For each node, visit all conditions in this node
    let newConditions = node.conditions.enumerated().map { (index, condition) in
      var conditionCopy = condition
      // check if the condition is a OptionalBindingConditionSyntax...
      if var binding = condition.condition.as(OptionalBindingConditionSyntax.self),
         // ...and has an initializer
         let initializer = binding.initializer,
         // and the name of the variable pattern and the initializer is the same, ignoring any whitespace
         binding.pattern.withoutTrivia().description == initializer.value.withoutTrivia().description {
        // Remove the initializer
        binding.initializer = nil
        // And remove whitespace (the space before the comma) in if statements with multiple conditions
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
