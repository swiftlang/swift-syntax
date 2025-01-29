//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#ifndef SWIFTSYNTAX_PLATFORMMUTEX_H
#define SWIFTSYNTAX_PLATFORMMUTEX_H

#include "_bridging.h"

typedef struct PlatformMutex {
  void *opaque;
} PlatformMutex;

SWIFT_NAME_S("PlatformMutex.create()")
PlatformMutex swiftsyntax_platform_mutex_create(void);

SWIFT_NAME_S("PlatformMutex.lock(self:)")
void swiftsyntax_platform_mutex_lock(PlatformMutex m);

SWIFT_NAME_S("PlatformMutex.unlock(self:)")
void swiftsyntax_platform_mutex_unlock(PlatformMutex m);

SWIFT_NAME_S("PlatformMutex.destroy(self:)")
void swiftsyntax_platform_mutex_destroy(PlatformMutex m);

#endif // SWIFTSYNTAX_PLATFORMMUTEX_H
