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

#ifndef SWIFTSYNTAX_ERRNO_H
#define SWIFTSYNTAX_ERRNO_H

#include "_bridging.h"

#include <errno.h>

SWIFT_NAME_S("getter:_errno()")
static inline int swiftsyntax_errno(void) {
  return errno;
}

#endif // SWIFTSYNTAX_ERRNO_H
