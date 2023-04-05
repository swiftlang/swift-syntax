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

#if __APPLE__
#include <TargetConditionals.h>
#if TARGET_OS_MAC && !TARGET_OS_IPHONE
#define TARGET_IS_MACOS 1
#endif
#endif

#include "InstructionsExecuted.h"

#ifdef TARGET_IS_MACOS
#include <libproc.h>
#include <sys/resource.h>
#include <unistd.h>

uint64_t getInstructionsExecuted() {
  struct rusage_info_v4 ru;
  if (proc_pid_rusage(getpid(), RUSAGE_INFO_V4, (rusage_info_t *)&ru) == 0) {
    return ru.ri_instructions;
  }
  return 0;
}
#else
uint64_t getInstructionsExecuted() {
  return 0;
}
#endif
