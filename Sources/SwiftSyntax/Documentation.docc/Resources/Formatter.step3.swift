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
    /* Formatter here */
  }
}
