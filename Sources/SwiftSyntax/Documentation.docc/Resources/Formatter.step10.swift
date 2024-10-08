import Foundation
import SwiftParser
import SwiftSyntax

@main struct ImportFormatter {
  static func main() {
    guard CommandLine.arguments.count == 2 else {
      print("Not enough arguments!")
      return
    }

    let filePath = CommandLine.arguments[1]
    guard FileManager.default.fileExists(atPath: filePath) else {
      print("File doesn't exist at path: \(filePath)")
      return
    }

    guard let file = try? String(contentsOfFile: filePath) else {
      print("File at path isn't readable: \(filePath)")
      return
    }

    let formattedFile = ImportFormatter().formatImports(in: file)
    print(formattedFile)
  }

  func formatImports(in file: String) -> SourceFileSyntax {
    let sourceFile = Parser.parse(source: file)
    var items = classifyItems(in: sourceFile)
    let pivotPoint = items.partition { item in
      switch item {
      case .import(_, _):
        return false
      case .other(_):
        return true
      }
    }
    items[..<pivotPoint]
      .sort { lhs, rhs in
        guard
          case .import(let lhsImport, _) = lhs,
          case .import(let rhsImport, _) = rhs
        else {
          fatalError("Partition must only contain import items!")
        }
        return lhsImport.path.description < rhsImport.path.description
      }
    let formattedStatements = items.map { item in
      switch item {
      case .import(_, let statement):
        return statement
      case .other(let statement):
        return statement
      }
    }
    return
      sourceFile
      .with(\.statements, CodeBlockItemListSyntax(formattedStatements))
  }

  enum Item {
    case `import`(ImportDeclSyntax, CodeBlockItemSyntax)
    case other(CodeBlockItemSyntax)
  }

  func classifyItems(in file: SourceFileSyntax) -> [Item] {
    file
      .statements
      .map { statement in
        if case .decl(let decl) = statement.item,
          let `import` = decl.as(ImportDeclSyntax.self)
        {
          return .import(`import`, statement)
        } else {
          return .other(statement)
        }
      }
  }
}
