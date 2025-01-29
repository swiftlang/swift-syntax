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

#ifndef SWIFTSYNTAX_BRIDGING_H
#define SWIFTSYNTAX_BRIDGING_H

#if __has_attribute(swift_name)
#define SWIFT_NAME_S(NAME) __attribute__((swift_name(NAME)))
#else
#define SWIFT_NAME_S(NAME)
#endif

#endif // SWIFTSYNTAX_BRIDGING_H
