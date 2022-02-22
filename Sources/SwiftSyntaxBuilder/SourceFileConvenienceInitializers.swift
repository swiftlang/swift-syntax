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

extension SourceFile {
  /// A convenience initializer that allows passing in statements using a result builder instead of having to wrap them in a `CodeBlockItemList`.
  public init(
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleAsCodeBlockItemList
  ) {
    self.init(
      statements: statementsBuilder(),
      eofToken: .eof
    )
  }
}
