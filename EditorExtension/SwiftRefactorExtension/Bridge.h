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

#include "stdint.h"

struct ConformanceDescriptor {
  int32_t protocol;
  int32_t typeRef;
  int32_t witnessTablePattern;
  uint32_t flags;
};

struct ContextDescriptor {
  uint32_t flags;
  int32_t parent;
};

struct ModuleContextDescriptor {
  uint32_t flags;
  int32_t parent;
  int32_t name;
};

struct TypeContextDescriptor {
  uint32_t flags;
  int32_t parent;
  int32_t name;
  int32_t accessor;
};
