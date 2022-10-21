import SwiftSyntax

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
