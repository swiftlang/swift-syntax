//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder

/// Add a swift setting to a manifest's source code.
@_spi(PackageRefactor)
public struct AddSwiftSetting: EditRefactoringProvider {
  public struct Context {
    let target: String
    let setting: String
    let value: ExprSyntax?
  }

  /// The set of argument labels that can occur after the "targets"
  /// argument in the Package initializers.
  private static let argumentLabelsAfterSwiftSettings: Set<String> = [
    "linkerSettings",
    "plugins",
  ]

  public static func upcomingFeature(
    to target: String,
    name: String,
    manifest: SourceFileSyntax
  ) throws -> [SourceEdit] {
    try textRefactor(
      syntax: manifest,
      in: .init(
        target: target,
        setting: "enableUpcomingFeature",
        value: name.asSyntax()
      )
    )
  }

  public static func experimentalFeature(
    to target: String,
    name: String,
    manifest: SourceFileSyntax
  ) throws -> [SourceEdit] {
    try textRefactor(
      syntax: manifest,
      in: .init(
        target: target,
        setting: "enableExperimentalFeature",
        value: name.asSyntax()
      )
    )
  }

  public static func languageMode(
    to target: String,
    mode rawMode: String,
    manifest: SourceFileSyntax
  ) throws -> [SourceEdit] {
    let mode: String
    switch rawMode {
    case "3", "4", "5", "6":
      mode = ".v\(rawMode)"
    case "4.2":
      mode = ".v4_2"
    default:
      mode = ".version(\"\(rawMode)\")"
    }

    return try textRefactor(
      syntax: manifest,
      in: .init(
        target: target,
        setting: "swiftLanguageMode",
        value: "\(raw: mode)"
      )
    )
  }

  public static func strictMemorySafety(
    to target: String,
    manifest: SourceFileSyntax
  ) throws -> [SourceEdit] {
    try textRefactor(
      syntax: manifest,
      in: .init(
        target: target,
        setting: "strictMemorySafety()",
        value: .none
      )
    )
  }

  public static func textRefactor(
    syntax manifest: SourceFileSyntax,
    in context: Context
  ) throws -> [SourceEdit] {
    guard let packageCall = manifest.findCall(calleeName: "Package") else {
      throw ManifestEditError.cannotFindPackage
    }

    guard let targetsArgument = packageCall.findArgument(labeled: "targets"),
      let targetArray = targetsArgument.expression.findArrayArgument()
    else {
      throw ManifestEditError.cannotFindTargets
    }

    let targetCall = targetArray
      .elements
      .lazy
      .compactMap {
        $0.expression.as(FunctionCallExprSyntax.self)
      }.first { targetCall in
        if let nameArgument = targetCall.findArgument(labeled: "name"),
          let nameLiteral = nameArgument.expression.as(StringLiteralExprSyntax.self),
          nameLiteral.representedLiteralValue == context.target
        {
          return true
        }

        return false
      }

    guard let targetCall else {
      throw ManifestEditError.cannotFindTarget(targetName: context.target)
    }

    if let memberRef = targetCall.calledExpression.as(MemberAccessExprSyntax.self),
      memberRef.declName.baseName.text == "plugin"
    {
      throw ManifestEditError.cannotAddSettingsToPluginTarget
    }

    let newTargetCall =
      if let value = context.value {
        try targetCall.appendingToArrayArgument(
          label: "swiftSettings",
          labelsAfter: self.argumentLabelsAfterSwiftSettings,
          newElement: ".\(raw: context.setting)(\(value))"
        )
      } else {
        try targetCall.appendingToArrayArgument(
          label: "swiftSettings",
          labelsAfter: self.argumentLabelsAfterSwiftSettings,
          newElement: ".\(raw: context.setting)"
        )
      }

    return [
      .replace(targetCall, with: newTargetCall.description)
    ]
  }
}
