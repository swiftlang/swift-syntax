// RUN: %empty-directory(%t)
// RUN: %validate-incrparse %s --test-case INSERT_SPACE

// REQUIRES: rdar90284916

class AnimationType {
  func foo(x: Blah) {
    switch x {
    case (.

extension AnimationType {
  public<<INSERT_SPACE<||| >>> 
