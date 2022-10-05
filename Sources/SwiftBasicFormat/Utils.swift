import SwiftSyntax

extension SyntaxProtocol {
  func cast<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S {
    return Syntax(self).as(S.self)!
  }
}

extension Trivia {
  var containsNewline: Bool {
    for piece in self {
      if piece.isNewline {
        return true
      }
    }
    return false
  }
}
