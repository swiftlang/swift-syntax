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
#include <stdlib.h>

typedef struct {
  _Atomic(bool) value;
} AtomicBool;

static inline AtomicBool *_Nonnull swiftsyntax_atomic_bool_create(bool initialValue) {
  AtomicBool *atomic = (AtomicBool *)malloc(sizeof(AtomicBool));
  atomic->value = initialValue;
  return atomic;
}

static inline bool swiftsyntax_atomic_bool_get(AtomicBool *_Nonnull atomic) {
  return atomic->value;
}

static inline void swiftsyntax_atomic_bool_set(AtomicBool *_Nonnull atomic, bool newValue) {
  atomic->value = newValue;
}

static inline void swiftsyntax_atomic_bool_destroy(AtomicBool *_Nonnull atomic) {
  free(atomic);
}

typedef struct {
  _Atomic(const void *_Nullable) value;
} AtomicPointer;

static inline const void *_Nullable swiftsyntax_atomic_pointer_get(const AtomicPointer *_Nonnull atomic) {
  return atomic->value;
}

static inline void swiftsyntax_atomic_pointer_set(AtomicPointer *_Nonnull atomic, const void *_Nullable newValue) {
  atomic->value = newValue;
}

#endif // SWIFTSYNTAX_ATOMICBOOL_H
