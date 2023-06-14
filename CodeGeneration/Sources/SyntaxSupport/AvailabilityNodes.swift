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

public let AVAILABILITY_NODES: [Node] = [
  // Wrapper for all the different entries that may occur inside @available
  // availability-entry -> '*' ','?
  //                     | identifier ','?
  //                     | availability-version-restriction ','?
  //                     | availability-versioned-argument ','?
  Node(
    name: "AvailabilityArgument",
    nameForDiagnostics: "availability argument",
    description: "A single argument to an `@available` argument like `*`, `iOS 10.1`, or `message: \"This has been deprecated\"`.",
    kind: "Syntax",
    traits: ["WithTrailingComma"],
    children: [
      Child(
        name: "Entry",
        kind: .nodeChoices(choices: [
          Child(
            name: "Token",
            kind: .token(choices: [.token(tokenKind: "BinaryOperatorToken"), .token(tokenKind: "IdentifierToken")], requiresLeadingSpace: false, requiresTrailingSpace: false)
          ),
          Child(
            name: "AvailabilityVersionRestriction",
            kind: .node(kind: "AvailabilityVersionRestriction")
          ),
          Child(
            name: "AvailabilityLabeledArgument",
            kind: .node(kind: "AvailabilityLabeledArgument")
          ),
        ]),
        description: "The actual argument"
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        description: "A trailing comma if the argument is followed by another argument",
        isOptional: true
      ),
    ]
  ),

  // Representation of 'deprecated: 2.3', 'message: "Hello world"' etc.
  // availability-versioned-argument -> identifier ':' version-tuple
  Node(
    name: "AvailabilityLabeledArgument",
    nameForDiagnostics: "availability argument",
    description: "A argument to an `@available` attribute that consists of a label and a value, e.g. `message: \"This has been deprecated\"`.",
    kind: "Syntax",
    children: [
      Child(
        name: "Label",
        kind: .token(choices: [.keyword(text: "message"), .keyword(text: "renamed"), .keyword(text: "introduced"), .keyword(text: "obsoleted"), .keyword(text: "deprecated")]),
        nameForDiagnostics: "label",
        description: "The label of the argument"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        description: "The colon separating label and value"
      ),
      Child(
        name: "Value",
        kind: .nodeChoices(choices: [
          Child(
            name: "String",
            kind: .node(kind: "StringLiteralExpr")
          ),
          Child(
            name: "Version",
            kind: .node(kind: "VersionTuple")
          ),
        ]),
        nameForDiagnostics: "value",
        description: "The value of this labeled argument"
      ),
    ]
  ),

  // availability-spec-list -> availability-entry availability-spec-list?
  Node(
    name: "AvailabilitySpecList",
    nameForDiagnostics: "'@availability' arguments",
    kind: "SyntaxCollection",
    element: "AvailabilityArgument"
  ),

  // Representation for 'iOS 10', 'swift 3.4' etc.
  // availability-version-restriction -> identifier version-tuple
  Node(
    name: "AvailabilityVersionRestriction",
    nameForDiagnostics: "version restriction",
    description: "An argument to `@available` that restricts the availability on a certain platform to a version, e.g. `iOS 10` or `swift 3.4`.",
    kind: "Syntax",
    children: [
      Child(
        name: "Platform",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        nameForDiagnostics: "platform",
        description: "The name of the OS on which the availability should be restricted or 'swift' if the availability should be restricted based on a Swift version.",
        classification: "Keyword"
      ),
      Child(
        name: "Version",
        kind: .node(kind: "VersionTuple"),
        nameForDiagnostics: "version",
        isOptional: true
      ),
    ]
  ),

  // version-tuple -> integer-literal
  //                | float-literal
  //                | float-literal '.' integer-literal
  Node(
    name: "VersionTuple",
    nameForDiagnostics: "version tuple",
    description: "A version number of the form major.minor.patch in which the minor and patch part may be omitted.",
    kind: "Syntax",
    children: [
      Child(
        name: "Major",
        kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")]),
        description: "The major version."
      ),
      Child(
        name: "MinorPeriod",
        kind: .token(choices: [.token(tokenKind: "PeriodToken")]),
        description: "If the version contains a minor number, the period separating the major from the minor number.",
        isOptional: true
      ),
      Child(
        name: "Minor",
        kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")]),
        description: "The minor version if specified.",
        isOptional: true
      ),
      Child(
        name: "PatchPeriod",
        kind: .token(choices: [.token(tokenKind: "PeriodToken")]),
        description: "If the version contains a patch number, the period separating the minor from the patch number.",
        isOptional: true
      ),
      Child(
        name: "Patch",
        kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")]),
        description: "The patch version if specified.",
        isOptional: true
      ),
    ]
  ),

]
