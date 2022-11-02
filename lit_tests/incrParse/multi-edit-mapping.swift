// RUN: %empty-directory(%t)
// RUN: %validate-incrparse %s --test-case MULTI

// https://github.com/apple/swift-syntax/issues/1045
// XFAIL: *

let one: Int;<reparse MULTI>let two: Int; let three: Int; <<MULTI<|||                      >>><<MULTI<|||   >>>let found: Int;</reparse MULTI>let five: Int;
