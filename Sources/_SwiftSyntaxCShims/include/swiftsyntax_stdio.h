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

#ifndef SWIFTSYNTAX_STDIO_H
#define SWIFTSYNTAX_STDIO_H

#include "_bridging.h"

#include <stdio.h>

SWIFT_NAME_S("getter:_stdout()")
static inline FILE *swiftsyntax_stdout(void) {
  return stdout;
}

SWIFT_NAME_S("getter:_stdin()")
static inline FILE *swiftsyntax_stdin(void) {
  return stdin;
}

SWIFT_NAME_S("getter:_stderr()")
static inline FILE *swiftsyntax_stderr(void) {
  return stderr;
}

#endif // SWIFTSYNTAX_STDIO_H
