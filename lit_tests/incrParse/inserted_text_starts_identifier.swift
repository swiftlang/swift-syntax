// RUN: %empty-directory(%t)
// RUN: %validate-incrparse %s --test-case STRING

// SR-8995 rdar://problem/45259469

// REQUIRES: rdar90284916

self = <<STRING<|||_                            _>>>foo(1)[object1, object2] + o bar(1)
