// RUN: %empty-directory(%t)
// RUN: %validate-incrparse %s --test-case NO_CHANGES
// RUN: %validate-incrparse %s --test-case NESTED_INITIALIZERS

// REQUIRES: rdar90284916

func start() {}

class Bar

let y = 1

class NestedInitializers {
  <<NESTED_INITIALIZERS<|||init() {>>>
    init() {

    }
  <<NESTED_INITIALIZERS<|||}>>>
}
