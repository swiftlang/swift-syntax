// RUN: %empty-directory(%t)
// RUN: %validate-incrparse %s --test-case ADD_ELSE

// REQUIRES: rdar90284916

func container() {
#if false
  <<ADD_ELSE<|||#else>>>
