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

#include "PlatformMutex.h"
#include <stdlib.h>

#if defined(__wasi__) && !defined(_REENTRANT)
#define SWIFTSYNTAX_HAS_THREAD 0
#else
#define SWIFTSYNTAX_HAS_THREAD 1
#endif

#if SWIFTSYNTAX_HAS_THREAD
#if defined(__APPLE__)
#include <os/lock.h>

PlatformMutex swiftsyntax_platform_mutex_create() {
  PlatformMutex m;
  m.opaque = malloc(sizeof(os_unfair_lock));
  *(os_unfair_lock_t)m.opaque = OS_UNFAIR_LOCK_INIT;
  return m;
}

void swiftsyntax_platform_mutex_lock(PlatformMutex m) {
  os_unfair_lock_lock(m.opaque);
}

void swiftsyntax_platform_mutex_unlock(PlatformMutex m) {
  os_unfair_lock_unlock(m.opaque);
}

void swiftsyntax_platform_mutex_destroy(PlatformMutex m) {
  free(m.opaque);
}

#elif defined(_WIN32)
#include <windows.h>

PlatformMutex swiftsyntax_platform_mutex_create() {
  PlatformMutex m;
  m.opaque = malloc(sizeof(SRWLOCK));
  InitializeSRWLock(m.opaque);
  return m;
}

void swiftsyntax_platform_mutex_lock(PlatformMutex m) {
  AcquireSRWLockExclusive(m.opaque);
}

void swiftsyntax_platform_mutex_unlock(PlatformMutex m) {
  ReleaseSRWLockExclusive(m.opaque);
}

void swiftsyntax_platform_mutex_destroy(PlatformMutex m) {
  free(m.opaque);
}

#elif __has_include(<pthread.h>)
#include <pthread.h>

PlatformMutex swiftsyntax_platform_mutex_create() {
  PlatformMutex m;
  m.opaque = malloc(sizeof(pthread_mutex_t));
  pthread_mutex_init(m.opaque, 0);
  return m;
}

void swiftsyntax_platform_mutex_lock(PlatformMutex m) {
  pthread_mutex_lock(m.opaque);
}

void swiftsyntax_platform_mutex_unlock(PlatformMutex m) {
  pthread_mutex_unlock(m.opaque);
}

void swiftsyntax_platform_mutex_destroy(PlatformMutex m) {
  pthread_mutex_destroy(m.opaque);
  free(m.opaque);
}

#else
#error "platform mutex implementation is not available"
// Add platform specific implementation above, or set SWIFTSYNTAX_HAS_THREAD to 0.
#endif

#else // SWIFTSYNTAX_HAS_THREAD

PlatformMutex swiftsyntax_platform_mutex_create() {
  PlatformMutex m;
  m.opaque = 0;
  return m;
}

void swiftsyntax_platform_mutex_lock(PlatformMutex m) {}
void swiftsyntax_platform_mutex_unlock(PlatformMutex m) {}
void swiftsyntax_platform_mutex_destroy(PlatformMutex m) {}

#endif // SWIFTSYNTAX_HAS_THREAD
