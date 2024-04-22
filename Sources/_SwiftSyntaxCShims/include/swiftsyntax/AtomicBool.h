//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#ifndef SWIFTSYNTAX_ATOMICBOOL_H
#define SWIFTSYNTAX_ATOMICBOOL_H

#include <stdbool.h>

typedef struct {
  _Atomic(bool) value;
} AtomicBool;

__attribute__((swift_name("AtomicBool.init(initialValue:)")))
static inline AtomicBool atomic_bool_create(bool initialValue) {
  AtomicBool atomic;
  atomic.value = initialValue;
  return atomic;
}

__attribute__((swift_name("getter:AtomicBool.value(self:)")))
static inline bool atomic_bool_get(AtomicBool *atomic) {
  return atomic->value;
}

__attribute__((swift_name("setter:AtomicBool.value(self:_:)")))
static inline void atomic_bool_set(AtomicBool *atomic, bool newValue) {
  atomic->value = newValue;
}

#endif // SWIFTSYNTAX_ATOMICBOOL_H
