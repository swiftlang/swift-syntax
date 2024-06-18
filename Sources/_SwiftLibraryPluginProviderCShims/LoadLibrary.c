//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#include "LoadLibrary.h"

#ifdef _WIN32

#include <windows.h>
#include <libloaderapi.h>
#include <errhandlingapi.h>

void *swiftlibrarypluginprovider_LoadLibraryW(uint16_t *lpLibFileName) {
  return LoadLibraryW(lpLibFileName);
}

unsigned long swiftlibrarypluginprovider_GetLastError() {
  return GetLastError();
}

#endif /* _WIN32 */
