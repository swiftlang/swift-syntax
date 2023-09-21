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
  Node(
    kind: .availabilityArgument,
    base: .syntax,
    nameForDiagnostics: "availability argument",
    documentation: "A single argument to an `@available` argument like `*`, `iOS 10.1`, or `message: \"This has been deprecated\"`.",
    traits: ["WithTrailingComma"],
    children: [
      Child(
        name: "argument",
        deprecatedName: "entry",
        kind: .nodeChoices(choices: [
          Child(
            name: "token",
            kind: .token(
              choices: [.token(.binaryOperator), .token(.identifier)],
              requiresLeadingSpace: false,
              requiresTrailingSpace: false
            )
          ),
          Child(
            name: "availabilityVersionRestriction",
            kind: .node(kind: .platformVersion)
          ),
          Child(
            name: "availabilityLabeledArgument",
            kind: .node(kind: .availabilityLabeledArgument)
          ),
        ]),
        documentation: "The actual argument."
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "A trailing comma if the argument is followed by another argument.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .availabilityLabeledArgument,
    base: .syntax,
    nameForDiagnostics: "availability argument",
    documentation: "An argument to an `@available` attribute that consists of a label and a value, e.g. `message: \"This has been deprecated\"`.",
    children: [
      Child(
        name: "label",
        kind: .token(choices: [
          .keyword(.message),
          .keyword(.renamed),
          .keyword(.introduced),
          .keyword(.obsoleted),
          .keyword(.deprecated),
        ]),
        nameForDiagnostics: "label",
        documentation: "The label of the argument."
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        documentation: "The colon separating label and value."
      ),
      Child(
        name: "value",
        kind: .nodeChoices(choices: [
          Child(
            name: "string",
            kind: .node(kind: .simpleStringLiteralExpr)
          ),
          Child(
            name: "version",
            kind: .node(kind: .versionTuple)
          ),
        ]),
        nameForDiagnostics: "value",
        documentation: "The value of this labeled argument."
      ),
    ]
  ),

  Node(
    kind: .availabilityArgumentList,
    base: .syntaxCollection,
    nameForDiagnostics: "'@availability' arguments",
    elementChoices: [.availabilityArgument]
  ),

  Node(
    kind: .platformVersion,
    base: .syntax,
    nameForDiagnostics: "version restriction",
    documentation: "An argument to `@available` that restricts the availability on a certain platform to a version, e.g. `iOS 10` or `swift 3.4`.",
    children: [
      Child(
        name: "platform",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "platform",
        documentation:
          "The name of the OS on which the availability should be restricted or 'swift' if the availability should be restricted based on a Swift version."
      ),
      Child(
        name: "version",
        kind: .node(kind: .versionTuple),
        nameForDiagnostics: "version",
        documentation: """
          The version of this platform.

          This parameter is optional because a custom platform alias can be specified using the `-define-availability` 
          argument to the Swift compiler. For example, when passing `-define-availability "_iOS8Aligned:macOS 10.10, iOS 8.0"`
          to the Swift compiler, then `@available(_iOS8Aligned, *)` is interpreted as `@available(macOS 10.10, iOS 8.0, *)`.
          """,
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .versionComponent,
    base: .syntax,
    nameForDiagnostics: nil,
    documentation: "An element to represent a single component in a version, like `.1`.",
    children: [
      Child(
        name: "period",
        kind: .token(choices: [.token(.period)]),
        documentation: "The period of this version component."
      ),
      Child(
        name: "number",
        kind: .token(choices: [.token(.integerLiteral)]),
        documentation: "The version number of this component."
      ),
    ]
  ),

  Node(
    kind: .versionComponentList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.versionComponent]
  ),

  Node(
    kind: .versionTuple,
    base: .syntax,
    nameForDiagnostics: "version tuple",
    documentation: "A version number like `1.2.0`. Only the first version component is required. There might be an arbitrary number of following components.",
    children: [
      Child(
        name: "major",
        kind: .token(choices: [.token(.integerLiteral)]),
        documentation: "The major version."
      ),
      Child(
        name: "components",
        kind: .collection(kind: .versionComponentList, collectionElementName: "VersionComponent"),
        documentation: "Any version components that are not the major version . For example, for `1.2.0`, this will contain `.2.0`."
      ),
    ]
  ),

]
