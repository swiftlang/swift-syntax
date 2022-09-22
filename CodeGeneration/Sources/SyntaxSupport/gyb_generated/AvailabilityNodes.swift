//// Automatically Generated From AvailabilityNodes.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public let AVAILABILITY_NODES: [Node] = [
  Node(name: "AvailabilitySpecList",
       nameForDiagnostics: "'@availability' arguments",
       kind: "SyntaxCollection",
       element: "AvailabilityArgument"),

  Node(name: "AvailabilityArgument",
       nameForDiagnostics: "'@available' argument",
       description: "A single argument to an `@available` argument like `*`, `iOS 10.1`,or `message: \"This has been deprecated\"`.",
       kind: "Syntax",
       children: [
         Child(name: "Entry",
               kind: "Syntax",
               description: "The actual argument",
               nodeChoices: [
                 Child(name: "Star",
                       kind: "SpacedBinaryOperatorToken",
                       tokenChoices: [
                         "SpacedBinaryOperator"
                       ],
                       textChoices: [
                         "*"
                       ]),
                 Child(name: "IdentifierRestriction",
                       kind: "IdentifierToken",
                       tokenChoices: [
                         "Identifier"
                       ]),
                 Child(name: "AvailabilityVersionRestriction",
                       kind: "AvailabilityVersionRestriction"),
                 Child(name: "AvailabilityLabeledArgument",
                       kind: "AvailabilityLabeledArgument")
               ]),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               description: "A trailing comma if the argument is followed by anotherargument",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "AvailabilityLabeledArgument",
       nameForDiagnostics: "'@available' argument",
       description: "A argument to an `@available` attribute that consists of a label anda value, e.g. `message: \"This has been deprecated\"`.",
       kind: "Syntax",
       children: [
         Child(name: "Label",
               kind: "IdentifierToken",
               description: "The label of the argument",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               description: "The colon separating label and value",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Value",
               kind: "Syntax",
               description: "The value of this labeled argument",
               nodeChoices: [
                 Child(name: "String",
                       kind: "StringLiteralToken",
                       tokenChoices: [
                         "StringLiteral"
                       ]),
                 Child(name: "Version",
                       kind: "VersionTuple")
               ])
       ]),

  Node(name: "AvailabilityVersionRestriction",
       nameForDiagnostics: "'@available' argument",
       description: "An argument to `@available` that restricts the availability on acertain platform to a version, e.g. `iOS 10` or `swift 3.4`.",
       kind: "Syntax",
       children: [
         Child(name: "Platform",
               kind: "IdentifierToken",
               description: "The name of the OS on which the availability should berestricted or 'swift' if the availability should berestricted based on a Swift version.",
               tokenChoices: [
                 "Identifier"
               ],
               classification: "Keyword"),
         Child(name: "Version",
               kind: "VersionTuple",
               isOptional: true)
       ]),

  Node(name: "VersionTuple",
       nameForDiagnostics: "version tuple",
       description: "A version number of the form major.minor.patch in which the minorand patch part may be omitted.",
       kind: "Syntax",
       children: [
         Child(name: "MajorMinor",
               kind: "Syntax",
               description: "In case the version consists only of the major version, aninteger literal that specifies the major version. In casethe version consists of major and minor version number, afloating literal in which the decimal part is interpretedas the minor version.",
               nodeChoices: [
                 Child(name: "Major",
                       kind: "IntegerLiteralToken",
                       tokenChoices: [
                         "IntegerLiteral"
                       ]),
                 Child(name: "MajorMinor",
                       kind: "FloatingLiteralToken",
                       tokenChoices: [
                         "FloatingLiteral"
                       ])
               ]),
         Child(name: "PatchPeriod",
               kind: "PeriodToken",
               description: "If the version contains a patch number, the periodseparating the minor from the patch number.",
               isOptional: true,
               tokenChoices: [
                 "Period"
               ]),
         Child(name: "PatchVersion",
               kind: "IntegerLiteralToken",
               description: "The patch version if specified.",
               isOptional: true,
               tokenChoices: [
                 "IntegerLiteral"
               ])
       ]),

]
