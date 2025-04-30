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

#ifndef SWIFT_LIBRARY_PLUGIN_PROVIDER_LOAD_LIBRARY_H
#define SWIFT_LIBRARY_PLUGIN_PROVIDER_LOAD_LIBRARY_H

#ifdef _WIN32

#include <stdint.h>

void *swiftlibrarypluginprovider_LoadLibraryW(uint16_t *lpLibFileName);
unsigned long swiftlibrarypluginprovider_GetLastError();

#endif /* _WIN32 */

#endif /* SWIFT_LIBRARY_PLUGIN_PROVIDER_LOAD_LIBRARY_H */
