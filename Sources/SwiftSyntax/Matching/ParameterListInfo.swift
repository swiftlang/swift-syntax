//
//  ParameterListInfo.swift
//  swift-syntax
//
//  Created by Kim de Vos on 13/04/2025.
//

/// Provides information about the parameter list of a given declaration, including whether each parameter
/// has a default argument.
struct ParameterListInfo {
  private var defaultArguments: [Bool]
  private var acceptsUnlabeledTrailingClosures: [Bool]
  private var propertyWrappers: [Bool]
  private var implicitSelfCapture: [Bool]
  private var inheritActorContext: [Bool]
  private var variadicGenerics: [Bool]
  private var sendingParameters: [Bool]

  /// Default initializer
  init() {
    self.defaultArguments = []
    self.acceptsUnlabeledTrailingClosures = []
    self.propertyWrappers = []
    self.implicitSelfCapture = []
    self.inheritActorContext = []
    self.variadicGenerics = []
    self.sendingParameters = []
  }

  /// Custom initializer with parameters
  init(params: [FunctionParameterSyntax], paramOwner: DeclSyntax?, skipCurriedSelf: Bool) {
    self.defaultArguments = Array(repeating: false, count: params.count)
    self.acceptsUnlabeledTrailingClosures = Array(repeating: false, count: params.count)
    self.propertyWrappers = Array(repeating: false, count: params.count)
    self.implicitSelfCapture = Array(repeating: false, count: params.count)
    self.inheritActorContext = Array(repeating: false, count: params.count)
    self.variadicGenerics = Array(repeating: false, count: params.count)
    self.sendingParameters = Array(repeating: false, count: params.count)
  }

  /// Whether the parameter at the given index has a default argument.
  func hasDefaultArgument(paramIdx: Int) -> Bool {
    return defaultArguments[paramIdx]
  }

  /// Whether the parameter accepts an unlabeled trailing closure argument
  /// according to the "forward-scan" rule.
  func acceptsUnlabeledTrailingClosureArgument(paramIdx: Int) -> Bool {
    return acceptsUnlabeledTrailingClosures[paramIdx]
  }

  /// The ParamDecl at the given index if the parameter has an applied property wrapper.
  func hasExternalPropertyWrapper(paramIdx: Int) -> Bool {
    return propertyWrappers[paramIdx]
  }

  /// Whether the given parameter is a closure that should allow capture of
  /// 'self' to be implicit, without requiring "self.".
  func isImplicitSelfCapture(paramIdx: Int) -> Bool {
    return implicitSelfCapture[paramIdx]
  }

  /// Whether the given parameter is a closure that should inherit the actor context
  /// from the context in which it was created.
  func inheritsActorContext(paramIdx: Int) -> Bool {
    return inheritActorContext[paramIdx]
  }

  /// Whether the parameter is a variadic generic parameter.
  func isVariadicGenericParameter(paramIdx: Int) -> Bool {
    return variadicGenerics[paramIdx]
  }

  /// Returns true if this is a sending parameter.
  func isSendingParameter(paramIdx: Int) -> Bool {
    return sendingParameters[paramIdx]
  }

  /// Retrieve the number of non-defaulted parameters.
  func numNonDefaultedParameters() -> Int {
    return defaultArguments.filter { !$0 }.count
  }

  /// Retrieve the number of parameters for which we have information.
  func size() -> Int {
    return defaultArguments.count
  }
}
