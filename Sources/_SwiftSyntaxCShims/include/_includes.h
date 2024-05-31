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
//
// This file is for, instead of importing platform modules in Swift file, like:
//
//   #if canImport(Darwin)
//   import Darwin
//   #elseif canImport(Glibc)
//   import Glibc
//   ...
//
// Just include them here using C facilities, so that Swift module can just:
//
//   import _SwiftSyntaxCShims
//
//===----------------------------------------------------------------------===//

#if defined(_WIN32)
// NOTE: Do NOT include "WinSDK" headers here.
// This is a part of compiler. If we use 'WinSDK' here, the compiler links with
// swiftWinSDK.dll when (re)bulding it, and fails because it's used.
#include <io.h>

#elif defined(__unix__) || defined(__APPLE__)
#include <unistd.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
