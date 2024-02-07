//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#include "SwiftSyntaxAtomicBool.h"

AtomicBool atomic_bool_create(bool initialValue) {
  AtomicBool atomic;
  atomic.value = initialValue;
  return atomic;
}

bool atomic_bool_get(AtomicBool *atomic) {
  return atomic->value;
}

void atomic_bool_set(AtomicBool *atomic, bool newValue) {
  atomic->value = newValue;
}
