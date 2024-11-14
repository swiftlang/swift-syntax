# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_syntax_library(SwiftLexicalLookup
  IdentifiableSyntax.swift
  LookupName.swift
  LookupResult.swift
  SimpleLookupQueries.swift
  LookupConfig.swift
  
  Scopes/CanInterleaveResultsLaterScopeSyntax.swift
  Scopes/FunctionScopeSyntax.swift
  Scopes/GenericParameterScopeSyntax.swift
  Scopes/IntroducingToSequentialParentScopeSyntax.swift
  Scopes/LookInMembersScopeSyntax.swift
  Scopes/NominalTypeDeclSyntax.swift
  Scopes/ScopeImplementations.swift
  Scopes/ScopeSyntax.swift
  Scopes/SequentialScopeSyntax.swift
  Scopes/WithGenericParametersScopeSyntax.swift
)

target_link_swift_syntax_libraries(SwiftLexicalLookup PUBLIC
  SwiftSyntax
  SwiftIfConfig)

