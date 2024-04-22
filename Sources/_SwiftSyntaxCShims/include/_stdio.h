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

#include <errno.h>
#include <stdio.h>

typedef FILE *_ss_ptr_FILE;

static _ss_ptr_FILE _ss_stdout(void) {
  return stdout;
}

static _ss_ptr_FILE _ss_stdin(void) {
  return stdin;
}

static _ss_ptr_FILE _ss_stderr(void) {
  return stderr;
}

static int _ss_errno(void) {
  return errno;
}
