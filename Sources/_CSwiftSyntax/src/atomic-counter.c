#include "atomic-counter.h"

uint64_t cswiftsyntax_get_unique_counter(void) {
  static _Atomic uint64_t counter = 0;
  return ++counter;
}
