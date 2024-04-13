
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
