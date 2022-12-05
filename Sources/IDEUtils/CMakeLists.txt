# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_host_library(IDEUtils
  generated/SyntaxClassification.swift
  Syntax+Classifications.swift
  SyntaxClassifier.swift
)

target_link_libraries(IDEUtils PUBLIC
  SwiftSyntax)
