# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_syntax_library(SwiftRefactor
  AddSeparatorsToIntegerLiteral.swift
  CallLikeSyntax.swift
  CallToTrailingClosures.swift
  ConvertComputedPropertyToStored.swift
  ConvertComputedPropertyToZeroParameterFunction.swift
  ConvertStoredPropertyToComputed.swift
  ConvertToDoCatch.swift
  ConvertZeroParameterFunctionToComputedProperty.swift
  DeclModifierRemover.swift
  ExpandEditorPlaceholder.swift
  FormatRawStringLiteral.swift
  IntegerLiteralUtilities.swift
  MigrateToNewIfLetSyntax.swift
  OpaqueParameterToGeneric.swift
  RefactoringProvider.swift
  RemoveRedundantParentheses.swift
  RemoveSeparatorsFromIntegerLiteral.swift
  SyntaxUtils.swift

  PackageManifest/AddPackageDependency.swift
  PackageManifest/AddPackageTarget.swift
  PackageManifest/AddPluginUsage.swift
  PackageManifest/AddProduct.swift
  PackageManifest/AddSwiftSetting.swift
  PackageManifest/AddTargetDependency.swift
  PackageManifest/ManifestEditError.swift
  PackageManifest/ManifestSyntaxRepresentable.swift
  PackageManifest/PackageDependency.swift
  PackageManifest/PackageTarget.swift
  PackageManifest/ProductDescription.swift
  PackageManifest/StringUtils.swift
  PackageManifest/SyntaxEditUtils.swift
)

target_link_swift_syntax_libraries(SwiftRefactor PUBLIC
  SwiftBasicFormat
  SwiftParser
  SwiftSyntax
  SwiftSyntaxBuilder
)
