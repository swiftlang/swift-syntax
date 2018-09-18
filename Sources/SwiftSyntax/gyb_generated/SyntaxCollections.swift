//// Automatically Generated From SyntaxCollections.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxCollections.swift.gyb - Syntax Collection ---------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation


/// `CodeBlockItemListSyntax` represents a collection of one or more
/// `CodeBlockItemSyntax` nodes. CodeBlockItemListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CodeBlockItemListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `CodeBlockItemListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `CodeBlockItemListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> CodeBlockItemListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return CodeBlockItemListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `CodeBlockItemListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `CodeBlockItemListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: CodeBlockItemSyntax) -> CodeBlockItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CodeBlockItemListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `CodeBlockItemListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: CodeBlockItemSyntax) -> CodeBlockItemListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `CodeBlockItemListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `CodeBlockItemListSyntax` with that element appended to the end.
  public func inserting(_ syntax: CodeBlockItemSyntax,
                        at index: Int) -> CodeBlockItemListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CodeBlockItemListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `CodeBlockItemListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: CodeBlockItemSyntax) -> CodeBlockItemListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `CodeBlockItemListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `CodeBlockItemListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> CodeBlockItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CodeBlockItemListSyntax` by removing the first element.
  ///
  /// - Returns: A new `CodeBlockItemListSyntax` with the first element removed.
  public func removingFirst() -> CodeBlockItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `CodeBlockItemListSyntax` by removing the last element.
  ///
  /// - Returns: A new `CodeBlockItemListSyntax` with the last element removed.
  public func removingLast() -> CodeBlockItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> CodeBlockItemListSyntaxIterator {
    return CodeBlockItemListSyntaxIterator(collection: self)
  }
}

/// Conformance for `CodeBlockItemListSyntax`` to the Collection protocol.
extension CodeBlockItemListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> CodeBlockItemSyntax {
    return child(at: index)! as! CodeBlockItemSyntax
  }
}

/// A type that iterates over a `CodeBlockItemListSyntax` using its indices.
public struct CodeBlockItemListSyntaxIterator: IteratorProtocol {
  public typealias Element = CodeBlockItemSyntax

  private let collection: CodeBlockItemListSyntax
  private var index: CodeBlockItemListSyntax.Index

  fileprivate init(collection: CodeBlockItemListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `FunctionCallArgumentListSyntax` represents a collection of one or more
/// `FunctionCallArgumentSyntax` nodes. FunctionCallArgumentListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct FunctionCallArgumentListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `FunctionCallArgumentListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `FunctionCallArgumentListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> FunctionCallArgumentListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return FunctionCallArgumentListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `FunctionCallArgumentListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `FunctionCallArgumentListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: FunctionCallArgumentSyntax) -> FunctionCallArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionCallArgumentListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `FunctionCallArgumentListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: FunctionCallArgumentSyntax) -> FunctionCallArgumentListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `FunctionCallArgumentListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `FunctionCallArgumentListSyntax` with that element appended to the end.
  public func inserting(_ syntax: FunctionCallArgumentSyntax,
                        at index: Int) -> FunctionCallArgumentListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionCallArgumentListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `FunctionCallArgumentListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: FunctionCallArgumentSyntax) -> FunctionCallArgumentListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionCallArgumentListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `FunctionCallArgumentListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> FunctionCallArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionCallArgumentListSyntax` by removing the first element.
  ///
  /// - Returns: A new `FunctionCallArgumentListSyntax` with the first element removed.
  public func removingFirst() -> FunctionCallArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionCallArgumentListSyntax` by removing the last element.
  ///
  /// - Returns: A new `FunctionCallArgumentListSyntax` with the last element removed.
  public func removingLast() -> FunctionCallArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> FunctionCallArgumentListSyntaxIterator {
    return FunctionCallArgumentListSyntaxIterator(collection: self)
  }
}

/// Conformance for `FunctionCallArgumentListSyntax`` to the Collection protocol.
extension FunctionCallArgumentListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> FunctionCallArgumentSyntax {
    return child(at: index)! as! FunctionCallArgumentSyntax
  }
}

/// A type that iterates over a `FunctionCallArgumentListSyntax` using its indices.
public struct FunctionCallArgumentListSyntaxIterator: IteratorProtocol {
  public typealias Element = FunctionCallArgumentSyntax

  private let collection: FunctionCallArgumentListSyntax
  private var index: FunctionCallArgumentListSyntax.Index

  fileprivate init(collection: FunctionCallArgumentListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `TupleElementListSyntax` represents a collection of one or more
/// `TupleElementSyntax` nodes. TupleElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TupleElementListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `TupleElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `TupleElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> TupleElementListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return TupleElementListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `TupleElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `TupleElementListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: TupleElementSyntax) -> TupleElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `TupleElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: TupleElementSyntax) -> TupleElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `TupleElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `TupleElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: TupleElementSyntax,
                        at index: Int) -> TupleElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `TupleElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: TupleElementSyntax) -> TupleElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `TupleElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> TupleElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `TupleElementListSyntax` with the first element removed.
  public func removingFirst() -> TupleElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `TupleElementListSyntax` with the last element removed.
  public func removingLast() -> TupleElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> TupleElementListSyntaxIterator {
    return TupleElementListSyntaxIterator(collection: self)
  }
}

/// Conformance for `TupleElementListSyntax`` to the Collection protocol.
extension TupleElementListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> TupleElementSyntax {
    return child(at: index)! as! TupleElementSyntax
  }
}

/// A type that iterates over a `TupleElementListSyntax` using its indices.
public struct TupleElementListSyntaxIterator: IteratorProtocol {
  public typealias Element = TupleElementSyntax

  private let collection: TupleElementListSyntax
  private var index: TupleElementListSyntax.Index

  fileprivate init(collection: TupleElementListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `ArrayElementListSyntax` represents a collection of one or more
/// `ArrayElementSyntax` nodes. ArrayElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ArrayElementListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `ArrayElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ArrayElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ArrayElementListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return ArrayElementListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `ArrayElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ArrayElementListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: ArrayElementSyntax) -> ArrayElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ArrayElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ArrayElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: ArrayElementSyntax) -> ArrayElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ArrayElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ArrayElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: ArrayElementSyntax,
                        at index: Int) -> ArrayElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ArrayElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ArrayElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: ArrayElementSyntax) -> ArrayElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ArrayElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ArrayElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ArrayElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ArrayElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ArrayElementListSyntax` with the first element removed.
  public func removingFirst() -> ArrayElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ArrayElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ArrayElementListSyntax` with the last element removed.
  public func removingLast() -> ArrayElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> ArrayElementListSyntaxIterator {
    return ArrayElementListSyntaxIterator(collection: self)
  }
}

/// Conformance for `ArrayElementListSyntax`` to the Collection protocol.
extension ArrayElementListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> ArrayElementSyntax {
    return child(at: index)! as! ArrayElementSyntax
  }
}

/// A type that iterates over a `ArrayElementListSyntax` using its indices.
public struct ArrayElementListSyntaxIterator: IteratorProtocol {
  public typealias Element = ArrayElementSyntax

  private let collection: ArrayElementListSyntax
  private var index: ArrayElementListSyntax.Index

  fileprivate init(collection: ArrayElementListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `DictionaryElementListSyntax` represents a collection of one or more
/// `DictionaryElementSyntax` nodes. DictionaryElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct DictionaryElementListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `DictionaryElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `DictionaryElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> DictionaryElementListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return DictionaryElementListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `DictionaryElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `DictionaryElementListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: DictionaryElementSyntax) -> DictionaryElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DictionaryElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `DictionaryElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: DictionaryElementSyntax) -> DictionaryElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `DictionaryElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `DictionaryElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: DictionaryElementSyntax,
                        at index: Int) -> DictionaryElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DictionaryElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `DictionaryElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: DictionaryElementSyntax) -> DictionaryElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `DictionaryElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `DictionaryElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> DictionaryElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DictionaryElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `DictionaryElementListSyntax` with the first element removed.
  public func removingFirst() -> DictionaryElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `DictionaryElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `DictionaryElementListSyntax` with the last element removed.
  public func removingLast() -> DictionaryElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> DictionaryElementListSyntaxIterator {
    return DictionaryElementListSyntaxIterator(collection: self)
  }
}

/// Conformance for `DictionaryElementListSyntax`` to the Collection protocol.
extension DictionaryElementListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> DictionaryElementSyntax {
    return child(at: index)! as! DictionaryElementSyntax
  }
}

/// A type that iterates over a `DictionaryElementListSyntax` using its indices.
public struct DictionaryElementListSyntaxIterator: IteratorProtocol {
  public typealias Element = DictionaryElementSyntax

  private let collection: DictionaryElementListSyntax
  private var index: DictionaryElementListSyntax.Index

  fileprivate init(collection: DictionaryElementListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `StringInterpolationSegmentsSyntax` represents a collection of one or more
/// `Syntax` nodes. StringInterpolationSegmentsSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct StringInterpolationSegmentsSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `StringInterpolationSegmentsSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `StringInterpolationSegmentsSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> StringInterpolationSegmentsSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return StringInterpolationSegmentsSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `StringInterpolationSegmentsSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `StringInterpolationSegmentsSyntax` with that element appended to the end.
  public func appending(
    _ syntax: Syntax) -> StringInterpolationSegmentsSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `StringInterpolationSegmentsSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `StringInterpolationSegmentsSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: Syntax) -> StringInterpolationSegmentsSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `StringInterpolationSegmentsSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `StringInterpolationSegmentsSyntax` with that element appended to the end.
  public func inserting(_ syntax: Syntax,
                        at index: Int) -> StringInterpolationSegmentsSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `StringInterpolationSegmentsSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `StringInterpolationSegmentsSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: Syntax) -> StringInterpolationSegmentsSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `StringInterpolationSegmentsSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `StringInterpolationSegmentsSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> StringInterpolationSegmentsSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `StringInterpolationSegmentsSyntax` by removing the first element.
  ///
  /// - Returns: A new `StringInterpolationSegmentsSyntax` with the first element removed.
  public func removingFirst() -> StringInterpolationSegmentsSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `StringInterpolationSegmentsSyntax` by removing the last element.
  ///
  /// - Returns: A new `StringInterpolationSegmentsSyntax` with the last element removed.
  public func removingLast() -> StringInterpolationSegmentsSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> StringInterpolationSegmentsSyntaxIterator {
    return StringInterpolationSegmentsSyntaxIterator(collection: self)
  }
}

/// Conformance for `StringInterpolationSegmentsSyntax`` to the Collection protocol.
extension StringInterpolationSegmentsSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> Syntax {
    return child(at: index)! 
  }
}

/// A type that iterates over a `StringInterpolationSegmentsSyntax` using its indices.
public struct StringInterpolationSegmentsSyntaxIterator: IteratorProtocol {
  public typealias Element = Syntax

  private let collection: StringInterpolationSegmentsSyntax
  private var index: StringInterpolationSegmentsSyntax.Index

  fileprivate init(collection: StringInterpolationSegmentsSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `DeclNameArgumentListSyntax` represents a collection of one or more
/// `DeclNameArgumentSyntax` nodes. DeclNameArgumentListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct DeclNameArgumentListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `DeclNameArgumentListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `DeclNameArgumentListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> DeclNameArgumentListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return DeclNameArgumentListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `DeclNameArgumentListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: DeclNameArgumentSyntax) -> DeclNameArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `DeclNameArgumentListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: DeclNameArgumentSyntax) -> DeclNameArgumentListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `DeclNameArgumentListSyntax` with that element appended to the end.
  public func inserting(_ syntax: DeclNameArgumentSyntax,
                        at index: Int) -> DeclNameArgumentListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `DeclNameArgumentListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: DeclNameArgumentSyntax) -> DeclNameArgumentListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `DeclNameArgumentListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> DeclNameArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by removing the first element.
  ///
  /// - Returns: A new `DeclNameArgumentListSyntax` with the first element removed.
  public func removingFirst() -> DeclNameArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclNameArgumentListSyntax` by removing the last element.
  ///
  /// - Returns: A new `DeclNameArgumentListSyntax` with the last element removed.
  public func removingLast() -> DeclNameArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> DeclNameArgumentListSyntaxIterator {
    return DeclNameArgumentListSyntaxIterator(collection: self)
  }
}

/// Conformance for `DeclNameArgumentListSyntax`` to the Collection protocol.
extension DeclNameArgumentListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> DeclNameArgumentSyntax {
    return child(at: index)! as! DeclNameArgumentSyntax
  }
}

/// A type that iterates over a `DeclNameArgumentListSyntax` using its indices.
public struct DeclNameArgumentListSyntaxIterator: IteratorProtocol {
  public typealias Element = DeclNameArgumentSyntax

  private let collection: DeclNameArgumentListSyntax
  private var index: DeclNameArgumentListSyntax.Index

  fileprivate init(collection: DeclNameArgumentListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `ExprListSyntax` represents a collection of one or more
/// `ExprSyntax` nodes. ExprListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ExprListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `ExprListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ExprListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ExprListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return ExprListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `ExprListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ExprListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: ExprSyntax) -> ExprListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ExprListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ExprListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: ExprSyntax) -> ExprListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ExprListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ExprListSyntax` with that element appended to the end.
  public func inserting(_ syntax: ExprSyntax,
                        at index: Int) -> ExprListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ExprListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ExprListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: ExprSyntax) -> ExprListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ExprListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ExprListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ExprListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ExprListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ExprListSyntax` with the first element removed.
  public func removingFirst() -> ExprListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ExprListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ExprListSyntax` with the last element removed.
  public func removingLast() -> ExprListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> ExprListSyntaxIterator {
    return ExprListSyntaxIterator(collection: self)
  }
}

/// Conformance for `ExprListSyntax`` to the Collection protocol.
extension ExprListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> ExprSyntax {
    return child(at: index)! as! ExprSyntax
  }
}

/// A type that iterates over a `ExprListSyntax` using its indices.
public struct ExprListSyntaxIterator: IteratorProtocol {
  public typealias Element = ExprSyntax

  private let collection: ExprListSyntax
  private var index: ExprListSyntax.Index

  fileprivate init(collection: ExprListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `ClosureCaptureItemListSyntax` represents a collection of one or more
/// `ClosureCaptureItemSyntax` nodes. ClosureCaptureItemListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ClosureCaptureItemListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ClosureCaptureItemListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ClosureCaptureItemListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return ClosureCaptureItemListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ClosureCaptureItemListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: ClosureCaptureItemSyntax) -> ClosureCaptureItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ClosureCaptureItemListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: ClosureCaptureItemSyntax) -> ClosureCaptureItemListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ClosureCaptureItemListSyntax` with that element appended to the end.
  public func inserting(_ syntax: ClosureCaptureItemSyntax,
                        at index: Int) -> ClosureCaptureItemListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ClosureCaptureItemListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: ClosureCaptureItemSyntax) -> ClosureCaptureItemListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ClosureCaptureItemListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ClosureCaptureItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ClosureCaptureItemListSyntax` with the first element removed.
  public func removingFirst() -> ClosureCaptureItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureCaptureItemListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ClosureCaptureItemListSyntax` with the last element removed.
  public func removingLast() -> ClosureCaptureItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> ClosureCaptureItemListSyntaxIterator {
    return ClosureCaptureItemListSyntaxIterator(collection: self)
  }
}

/// Conformance for `ClosureCaptureItemListSyntax`` to the Collection protocol.
extension ClosureCaptureItemListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> ClosureCaptureItemSyntax {
    return child(at: index)! as! ClosureCaptureItemSyntax
  }
}

/// A type that iterates over a `ClosureCaptureItemListSyntax` using its indices.
public struct ClosureCaptureItemListSyntaxIterator: IteratorProtocol {
  public typealias Element = ClosureCaptureItemSyntax

  private let collection: ClosureCaptureItemListSyntax
  private var index: ClosureCaptureItemListSyntax.Index

  fileprivate init(collection: ClosureCaptureItemListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `ClosureParamListSyntax` represents a collection of one or more
/// `ClosureParamSyntax` nodes. ClosureParamListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ClosureParamListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `ClosureParamListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ClosureParamListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ClosureParamListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return ClosureParamListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `ClosureParamListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ClosureParamListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: ClosureParamSyntax) -> ClosureParamListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureParamListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ClosureParamListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: ClosureParamSyntax) -> ClosureParamListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ClosureParamListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ClosureParamListSyntax` with that element appended to the end.
  public func inserting(_ syntax: ClosureParamSyntax,
                        at index: Int) -> ClosureParamListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureParamListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ClosureParamListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: ClosureParamSyntax) -> ClosureParamListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureParamListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ClosureParamListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ClosureParamListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureParamListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ClosureParamListSyntax` with the first element removed.
  public func removingFirst() -> ClosureParamListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ClosureParamListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ClosureParamListSyntax` with the last element removed.
  public func removingLast() -> ClosureParamListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> ClosureParamListSyntaxIterator {
    return ClosureParamListSyntaxIterator(collection: self)
  }
}

/// Conformance for `ClosureParamListSyntax`` to the Collection protocol.
extension ClosureParamListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> ClosureParamSyntax {
    return child(at: index)! as! ClosureParamSyntax
  }
}

/// A type that iterates over a `ClosureParamListSyntax` using its indices.
public struct ClosureParamListSyntaxIterator: IteratorProtocol {
  public typealias Element = ClosureParamSyntax

  private let collection: ClosureParamListSyntax
  private var index: ClosureParamListSyntax.Index

  fileprivate init(collection: ClosureParamListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `ObjcNameSyntax` represents a collection of one or more
/// `ObjcNamePieceSyntax` nodes. ObjcNameSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ObjcNameSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `ObjcNameSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ObjcNameSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ObjcNameSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return ObjcNameSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `ObjcNameSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ObjcNameSyntax` with that element appended to the end.
  public func appending(
    _ syntax: ObjcNamePieceSyntax) -> ObjcNameSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ObjcNameSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ObjcNameSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: ObjcNamePieceSyntax) -> ObjcNameSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ObjcNameSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ObjcNameSyntax` with that element appended to the end.
  public func inserting(_ syntax: ObjcNamePieceSyntax,
                        at index: Int) -> ObjcNameSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ObjcNameSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ObjcNameSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: ObjcNamePieceSyntax) -> ObjcNameSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ObjcNameSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ObjcNameSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ObjcNameSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ObjcNameSyntax` by removing the first element.
  ///
  /// - Returns: A new `ObjcNameSyntax` with the first element removed.
  public func removingFirst() -> ObjcNameSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ObjcNameSyntax` by removing the last element.
  ///
  /// - Returns: A new `ObjcNameSyntax` with the last element removed.
  public func removingLast() -> ObjcNameSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> ObjcNameSyntaxIterator {
    return ObjcNameSyntaxIterator(collection: self)
  }
}

/// Conformance for `ObjcNameSyntax`` to the Collection protocol.
extension ObjcNameSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> ObjcNamePieceSyntax {
    return child(at: index)! as! ObjcNamePieceSyntax
  }
}

/// A type that iterates over a `ObjcNameSyntax` using its indices.
public struct ObjcNameSyntaxIterator: IteratorProtocol {
  public typealias Element = ObjcNamePieceSyntax

  private let collection: ObjcNameSyntax
  private var index: ObjcNameSyntax.Index

  fileprivate init(collection: ObjcNameSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `FunctionParameterListSyntax` represents a collection of one or more
/// `FunctionParameterSyntax` nodes. FunctionParameterListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct FunctionParameterListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `FunctionParameterListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `FunctionParameterListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> FunctionParameterListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return FunctionParameterListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `FunctionParameterListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `FunctionParameterListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: FunctionParameterSyntax) -> FunctionParameterListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionParameterListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `FunctionParameterListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: FunctionParameterSyntax) -> FunctionParameterListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `FunctionParameterListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `FunctionParameterListSyntax` with that element appended to the end.
  public func inserting(_ syntax: FunctionParameterSyntax,
                        at index: Int) -> FunctionParameterListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionParameterListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `FunctionParameterListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: FunctionParameterSyntax) -> FunctionParameterListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionParameterListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `FunctionParameterListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> FunctionParameterListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionParameterListSyntax` by removing the first element.
  ///
  /// - Returns: A new `FunctionParameterListSyntax` with the first element removed.
  public func removingFirst() -> FunctionParameterListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `FunctionParameterListSyntax` by removing the last element.
  ///
  /// - Returns: A new `FunctionParameterListSyntax` with the last element removed.
  public func removingLast() -> FunctionParameterListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> FunctionParameterListSyntaxIterator {
    return FunctionParameterListSyntaxIterator(collection: self)
  }
}

/// Conformance for `FunctionParameterListSyntax`` to the Collection protocol.
extension FunctionParameterListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> FunctionParameterSyntax {
    return child(at: index)! as! FunctionParameterSyntax
  }
}

/// A type that iterates over a `FunctionParameterListSyntax` using its indices.
public struct FunctionParameterListSyntaxIterator: IteratorProtocol {
  public typealias Element = FunctionParameterSyntax

  private let collection: FunctionParameterListSyntax
  private var index: FunctionParameterListSyntax.Index

  fileprivate init(collection: FunctionParameterListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `IfConfigClauseListSyntax` represents a collection of one or more
/// `IfConfigClauseSyntax` nodes. IfConfigClauseListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct IfConfigClauseListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `IfConfigClauseListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `IfConfigClauseListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> IfConfigClauseListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return IfConfigClauseListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `IfConfigClauseListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `IfConfigClauseListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: IfConfigClauseSyntax) -> IfConfigClauseListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `IfConfigClauseListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `IfConfigClauseListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: IfConfigClauseSyntax) -> IfConfigClauseListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `IfConfigClauseListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `IfConfigClauseListSyntax` with that element appended to the end.
  public func inserting(_ syntax: IfConfigClauseSyntax,
                        at index: Int) -> IfConfigClauseListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `IfConfigClauseListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `IfConfigClauseListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: IfConfigClauseSyntax) -> IfConfigClauseListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `IfConfigClauseListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `IfConfigClauseListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> IfConfigClauseListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `IfConfigClauseListSyntax` by removing the first element.
  ///
  /// - Returns: A new `IfConfigClauseListSyntax` with the first element removed.
  public func removingFirst() -> IfConfigClauseListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `IfConfigClauseListSyntax` by removing the last element.
  ///
  /// - Returns: A new `IfConfigClauseListSyntax` with the last element removed.
  public func removingLast() -> IfConfigClauseListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> IfConfigClauseListSyntaxIterator {
    return IfConfigClauseListSyntaxIterator(collection: self)
  }
}

/// Conformance for `IfConfigClauseListSyntax`` to the Collection protocol.
extension IfConfigClauseListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> IfConfigClauseSyntax {
    return child(at: index)! as! IfConfigClauseSyntax
  }
}

/// A type that iterates over a `IfConfigClauseListSyntax` using its indices.
public struct IfConfigClauseListSyntaxIterator: IteratorProtocol {
  public typealias Element = IfConfigClauseSyntax

  private let collection: IfConfigClauseListSyntax
  private var index: IfConfigClauseListSyntax.Index

  fileprivate init(collection: IfConfigClauseListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `InheritedTypeListSyntax` represents a collection of one or more
/// `InheritedTypeSyntax` nodes. InheritedTypeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct InheritedTypeListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `InheritedTypeListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `InheritedTypeListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> InheritedTypeListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return InheritedTypeListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `InheritedTypeListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `InheritedTypeListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: InheritedTypeSyntax) -> InheritedTypeListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `InheritedTypeListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `InheritedTypeListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: InheritedTypeSyntax) -> InheritedTypeListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `InheritedTypeListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `InheritedTypeListSyntax` with that element appended to the end.
  public func inserting(_ syntax: InheritedTypeSyntax,
                        at index: Int) -> InheritedTypeListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `InheritedTypeListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `InheritedTypeListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: InheritedTypeSyntax) -> InheritedTypeListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `InheritedTypeListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `InheritedTypeListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> InheritedTypeListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `InheritedTypeListSyntax` by removing the first element.
  ///
  /// - Returns: A new `InheritedTypeListSyntax` with the first element removed.
  public func removingFirst() -> InheritedTypeListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `InheritedTypeListSyntax` by removing the last element.
  ///
  /// - Returns: A new `InheritedTypeListSyntax` with the last element removed.
  public func removingLast() -> InheritedTypeListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> InheritedTypeListSyntaxIterator {
    return InheritedTypeListSyntaxIterator(collection: self)
  }
}

/// Conformance for `InheritedTypeListSyntax`` to the Collection protocol.
extension InheritedTypeListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> InheritedTypeSyntax {
    return child(at: index)! as! InheritedTypeSyntax
  }
}

/// A type that iterates over a `InheritedTypeListSyntax` using its indices.
public struct InheritedTypeListSyntaxIterator: IteratorProtocol {
  public typealias Element = InheritedTypeSyntax

  private let collection: InheritedTypeListSyntax
  private var index: InheritedTypeListSyntax.Index

  fileprivate init(collection: InheritedTypeListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `DeclListSyntax` represents a collection of one or more
/// `DeclSyntax` nodes. DeclListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct DeclListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `DeclListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `DeclListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> DeclListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return DeclListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `DeclListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `DeclListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: DeclSyntax) -> DeclListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `DeclListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: DeclSyntax) -> DeclListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `DeclListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `DeclListSyntax` with that element appended to the end.
  public func inserting(_ syntax: DeclSyntax,
                        at index: Int) -> DeclListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `DeclListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: DeclSyntax) -> DeclListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `DeclListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> DeclListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclListSyntax` by removing the first element.
  ///
  /// - Returns: A new `DeclListSyntax` with the first element removed.
  public func removingFirst() -> DeclListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `DeclListSyntax` by removing the last element.
  ///
  /// - Returns: A new `DeclListSyntax` with the last element removed.
  public func removingLast() -> DeclListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> DeclListSyntaxIterator {
    return DeclListSyntaxIterator(collection: self)
  }
}

/// Conformance for `DeclListSyntax`` to the Collection protocol.
extension DeclListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> DeclSyntax {
    return child(at: index)! as! DeclSyntax
  }
}

/// A type that iterates over a `DeclListSyntax` using its indices.
public struct DeclListSyntaxIterator: IteratorProtocol {
  public typealias Element = DeclSyntax

  private let collection: DeclListSyntax
  private var index: DeclListSyntax.Index

  fileprivate init(collection: DeclListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `ModifierListSyntax` represents a collection of one or more
/// `DeclModifierSyntax` nodes. ModifierListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ModifierListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `ModifierListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ModifierListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ModifierListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return ModifierListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `ModifierListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ModifierListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: DeclModifierSyntax) -> ModifierListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ModifierListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ModifierListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: DeclModifierSyntax) -> ModifierListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ModifierListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ModifierListSyntax` with that element appended to the end.
  public func inserting(_ syntax: DeclModifierSyntax,
                        at index: Int) -> ModifierListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ModifierListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ModifierListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: DeclModifierSyntax) -> ModifierListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ModifierListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ModifierListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ModifierListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ModifierListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ModifierListSyntax` with the first element removed.
  public func removingFirst() -> ModifierListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ModifierListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ModifierListSyntax` with the last element removed.
  public func removingLast() -> ModifierListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> ModifierListSyntaxIterator {
    return ModifierListSyntaxIterator(collection: self)
  }
}

/// Conformance for `ModifierListSyntax`` to the Collection protocol.
extension ModifierListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> DeclModifierSyntax {
    return child(at: index)! as! DeclModifierSyntax
  }
}

/// A type that iterates over a `ModifierListSyntax` using its indices.
public struct ModifierListSyntaxIterator: IteratorProtocol {
  public typealias Element = DeclModifierSyntax

  private let collection: ModifierListSyntax
  private var index: ModifierListSyntax.Index

  fileprivate init(collection: ModifierListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `AccessPathSyntax` represents a collection of one or more
/// `AccessPathComponentSyntax` nodes. AccessPathSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct AccessPathSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `AccessPathSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `AccessPathSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> AccessPathSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return AccessPathSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `AccessPathSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `AccessPathSyntax` with that element appended to the end.
  public func appending(
    _ syntax: AccessPathComponentSyntax) -> AccessPathSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessPathSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `AccessPathSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: AccessPathComponentSyntax) -> AccessPathSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `AccessPathSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `AccessPathSyntax` with that element appended to the end.
  public func inserting(_ syntax: AccessPathComponentSyntax,
                        at index: Int) -> AccessPathSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessPathSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `AccessPathSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: AccessPathComponentSyntax) -> AccessPathSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessPathSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `AccessPathSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> AccessPathSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessPathSyntax` by removing the first element.
  ///
  /// - Returns: A new `AccessPathSyntax` with the first element removed.
  public func removingFirst() -> AccessPathSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessPathSyntax` by removing the last element.
  ///
  /// - Returns: A new `AccessPathSyntax` with the last element removed.
  public func removingLast() -> AccessPathSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> AccessPathSyntaxIterator {
    return AccessPathSyntaxIterator(collection: self)
  }
}

/// Conformance for `AccessPathSyntax`` to the Collection protocol.
extension AccessPathSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> AccessPathComponentSyntax {
    return child(at: index)! as! AccessPathComponentSyntax
  }
}

/// A type that iterates over a `AccessPathSyntax` using its indices.
public struct AccessPathSyntaxIterator: IteratorProtocol {
  public typealias Element = AccessPathComponentSyntax

  private let collection: AccessPathSyntax
  private var index: AccessPathSyntax.Index

  fileprivate init(collection: AccessPathSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `AccessorListSyntax` represents a collection of one or more
/// `AccessorDeclSyntax` nodes. AccessorListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct AccessorListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `AccessorListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `AccessorListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> AccessorListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return AccessorListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `AccessorListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `AccessorListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: AccessorDeclSyntax) -> AccessorListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessorListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `AccessorListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: AccessorDeclSyntax) -> AccessorListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `AccessorListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `AccessorListSyntax` with that element appended to the end.
  public func inserting(_ syntax: AccessorDeclSyntax,
                        at index: Int) -> AccessorListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessorListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `AccessorListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: AccessorDeclSyntax) -> AccessorListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessorListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `AccessorListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> AccessorListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessorListSyntax` by removing the first element.
  ///
  /// - Returns: A new `AccessorListSyntax` with the first element removed.
  public func removingFirst() -> AccessorListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `AccessorListSyntax` by removing the last element.
  ///
  /// - Returns: A new `AccessorListSyntax` with the last element removed.
  public func removingLast() -> AccessorListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> AccessorListSyntaxIterator {
    return AccessorListSyntaxIterator(collection: self)
  }
}

/// Conformance for `AccessorListSyntax`` to the Collection protocol.
extension AccessorListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> AccessorDeclSyntax {
    return child(at: index)! as! AccessorDeclSyntax
  }
}

/// A type that iterates over a `AccessorListSyntax` using its indices.
public struct AccessorListSyntaxIterator: IteratorProtocol {
  public typealias Element = AccessorDeclSyntax

  private let collection: AccessorListSyntax
  private var index: AccessorListSyntax.Index

  fileprivate init(collection: AccessorListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `PatternBindingListSyntax` represents a collection of one or more
/// `PatternBindingSyntax` nodes. PatternBindingListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct PatternBindingListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `PatternBindingListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `PatternBindingListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> PatternBindingListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return PatternBindingListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `PatternBindingListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `PatternBindingListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: PatternBindingSyntax) -> PatternBindingListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PatternBindingListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `PatternBindingListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: PatternBindingSyntax) -> PatternBindingListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `PatternBindingListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `PatternBindingListSyntax` with that element appended to the end.
  public func inserting(_ syntax: PatternBindingSyntax,
                        at index: Int) -> PatternBindingListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PatternBindingListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `PatternBindingListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: PatternBindingSyntax) -> PatternBindingListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `PatternBindingListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `PatternBindingListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> PatternBindingListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PatternBindingListSyntax` by removing the first element.
  ///
  /// - Returns: A new `PatternBindingListSyntax` with the first element removed.
  public func removingFirst() -> PatternBindingListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `PatternBindingListSyntax` by removing the last element.
  ///
  /// - Returns: A new `PatternBindingListSyntax` with the last element removed.
  public func removingLast() -> PatternBindingListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> PatternBindingListSyntaxIterator {
    return PatternBindingListSyntaxIterator(collection: self)
  }
}

/// Conformance for `PatternBindingListSyntax`` to the Collection protocol.
extension PatternBindingListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> PatternBindingSyntax {
    return child(at: index)! as! PatternBindingSyntax
  }
}

/// A type that iterates over a `PatternBindingListSyntax` using its indices.
public struct PatternBindingListSyntaxIterator: IteratorProtocol {
  public typealias Element = PatternBindingSyntax

  private let collection: PatternBindingListSyntax
  private var index: PatternBindingListSyntax.Index

  fileprivate init(collection: PatternBindingListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `EnumCaseElementListSyntax` represents a collection of one or more
/// `EnumCaseElementSyntax` nodes. EnumCaseElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct EnumCaseElementListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `EnumCaseElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `EnumCaseElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> EnumCaseElementListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return EnumCaseElementListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `EnumCaseElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `EnumCaseElementListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: EnumCaseElementSyntax) -> EnumCaseElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `EnumCaseElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `EnumCaseElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: EnumCaseElementSyntax) -> EnumCaseElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `EnumCaseElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `EnumCaseElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: EnumCaseElementSyntax,
                        at index: Int) -> EnumCaseElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `EnumCaseElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `EnumCaseElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: EnumCaseElementSyntax) -> EnumCaseElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `EnumCaseElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `EnumCaseElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> EnumCaseElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `EnumCaseElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `EnumCaseElementListSyntax` with the first element removed.
  public func removingFirst() -> EnumCaseElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `EnumCaseElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `EnumCaseElementListSyntax` with the last element removed.
  public func removingLast() -> EnumCaseElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> EnumCaseElementListSyntaxIterator {
    return EnumCaseElementListSyntaxIterator(collection: self)
  }
}

/// Conformance for `EnumCaseElementListSyntax`` to the Collection protocol.
extension EnumCaseElementListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> EnumCaseElementSyntax {
    return child(at: index)! as! EnumCaseElementSyntax
  }
}

/// A type that iterates over a `EnumCaseElementListSyntax` using its indices.
public struct EnumCaseElementListSyntaxIterator: IteratorProtocol {
  public typealias Element = EnumCaseElementSyntax

  private let collection: EnumCaseElementListSyntax
  private var index: EnumCaseElementListSyntax.Index

  fileprivate init(collection: EnumCaseElementListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `PrecedenceGroupAttributeListSyntax` represents a collection of one or more
/// `Syntax` nodes. PrecedenceGroupAttributeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct PrecedenceGroupAttributeListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> PrecedenceGroupAttributeListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return PrecedenceGroupAttributeListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: Syntax) -> PrecedenceGroupAttributeListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: Syntax) -> PrecedenceGroupAttributeListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Syntax,
                        at index: Int) -> PrecedenceGroupAttributeListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: Syntax) -> PrecedenceGroupAttributeListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> PrecedenceGroupAttributeListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by removing the first element.
  ///
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with the first element removed.
  public func removingFirst() -> PrecedenceGroupAttributeListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupAttributeListSyntax` by removing the last element.
  ///
  /// - Returns: A new `PrecedenceGroupAttributeListSyntax` with the last element removed.
  public func removingLast() -> PrecedenceGroupAttributeListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> PrecedenceGroupAttributeListSyntaxIterator {
    return PrecedenceGroupAttributeListSyntaxIterator(collection: self)
  }
}

/// Conformance for `PrecedenceGroupAttributeListSyntax`` to the Collection protocol.
extension PrecedenceGroupAttributeListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> Syntax {
    return child(at: index)! 
  }
}

/// A type that iterates over a `PrecedenceGroupAttributeListSyntax` using its indices.
public struct PrecedenceGroupAttributeListSyntaxIterator: IteratorProtocol {
  public typealias Element = Syntax

  private let collection: PrecedenceGroupAttributeListSyntax
  private var index: PrecedenceGroupAttributeListSyntax.Index

  fileprivate init(collection: PrecedenceGroupAttributeListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `PrecedenceGroupNameListSyntax` represents a collection of one or more
/// `PrecedenceGroupNameElementSyntax` nodes. PrecedenceGroupNameListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct PrecedenceGroupNameListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> PrecedenceGroupNameListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return PrecedenceGroupNameListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: PrecedenceGroupNameElementSyntax) -> PrecedenceGroupNameListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: PrecedenceGroupNameElementSyntax) -> PrecedenceGroupNameListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with that element appended to the end.
  public func inserting(_ syntax: PrecedenceGroupNameElementSyntax,
                        at index: Int) -> PrecedenceGroupNameListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: PrecedenceGroupNameElementSyntax) -> PrecedenceGroupNameListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> PrecedenceGroupNameListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by removing the first element.
  ///
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with the first element removed.
  public func removingFirst() -> PrecedenceGroupNameListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `PrecedenceGroupNameListSyntax` by removing the last element.
  ///
  /// - Returns: A new `PrecedenceGroupNameListSyntax` with the last element removed.
  public func removingLast() -> PrecedenceGroupNameListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> PrecedenceGroupNameListSyntaxIterator {
    return PrecedenceGroupNameListSyntaxIterator(collection: self)
  }
}

/// Conformance for `PrecedenceGroupNameListSyntax`` to the Collection protocol.
extension PrecedenceGroupNameListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> PrecedenceGroupNameElementSyntax {
    return child(at: index)! as! PrecedenceGroupNameElementSyntax
  }
}

/// A type that iterates over a `PrecedenceGroupNameListSyntax` using its indices.
public struct PrecedenceGroupNameListSyntaxIterator: IteratorProtocol {
  public typealias Element = PrecedenceGroupNameElementSyntax

  private let collection: PrecedenceGroupNameListSyntax
  private var index: PrecedenceGroupNameListSyntax.Index

  fileprivate init(collection: PrecedenceGroupNameListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `TokenListSyntax` represents a collection of one or more
/// `TokenSyntax` nodes. TokenListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TokenListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `TokenListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `TokenListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> TokenListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return TokenListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `TokenListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `TokenListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: TokenSyntax) -> TokenListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TokenListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `TokenListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: TokenSyntax) -> TokenListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `TokenListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `TokenListSyntax` with that element appended to the end.
  public func inserting(_ syntax: TokenSyntax,
                        at index: Int) -> TokenListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TokenListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `TokenListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: TokenSyntax) -> TokenListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `TokenListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `TokenListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> TokenListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TokenListSyntax` by removing the first element.
  ///
  /// - Returns: A new `TokenListSyntax` with the first element removed.
  public func removingFirst() -> TokenListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `TokenListSyntax` by removing the last element.
  ///
  /// - Returns: A new `TokenListSyntax` with the last element removed.
  public func removingLast() -> TokenListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> TokenListSyntaxIterator {
    return TokenListSyntaxIterator(collection: self)
  }
}

/// Conformance for `TokenListSyntax`` to the Collection protocol.
extension TokenListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> TokenSyntax {
    return child(at: index)! as! TokenSyntax
  }
}

/// A type that iterates over a `TokenListSyntax` using its indices.
public struct TokenListSyntaxIterator: IteratorProtocol {
  public typealias Element = TokenSyntax

  private let collection: TokenListSyntax
  private var index: TokenListSyntax.Index

  fileprivate init(collection: TokenListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `AttributeListSyntax` represents a collection of one or more
/// `AttributeSyntax` nodes. AttributeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct AttributeListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `AttributeListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `AttributeListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> AttributeListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return AttributeListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `AttributeListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `AttributeListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: AttributeSyntax) -> AttributeListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AttributeListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `AttributeListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: AttributeSyntax) -> AttributeListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `AttributeListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `AttributeListSyntax` with that element appended to the end.
  public func inserting(_ syntax: AttributeSyntax,
                        at index: Int) -> AttributeListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AttributeListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `AttributeListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: AttributeSyntax) -> AttributeListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `AttributeListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `AttributeListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> AttributeListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `AttributeListSyntax` by removing the first element.
  ///
  /// - Returns: A new `AttributeListSyntax` with the first element removed.
  public func removingFirst() -> AttributeListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `AttributeListSyntax` by removing the last element.
  ///
  /// - Returns: A new `AttributeListSyntax` with the last element removed.
  public func removingLast() -> AttributeListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> AttributeListSyntaxIterator {
    return AttributeListSyntaxIterator(collection: self)
  }
}

/// Conformance for `AttributeListSyntax`` to the Collection protocol.
extension AttributeListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> AttributeSyntax {
    return child(at: index)! as! AttributeSyntax
  }
}

/// A type that iterates over a `AttributeListSyntax` using its indices.
public struct AttributeListSyntaxIterator: IteratorProtocol {
  public typealias Element = AttributeSyntax

  private let collection: AttributeListSyntax
  private var index: AttributeListSyntax.Index

  fileprivate init(collection: AttributeListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `SwitchCaseListSyntax` represents a collection of one or more
/// `Syntax` nodes. SwitchCaseListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct SwitchCaseListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `SwitchCaseListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `SwitchCaseListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> SwitchCaseListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return SwitchCaseListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `SwitchCaseListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `SwitchCaseListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: Syntax) -> SwitchCaseListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `SwitchCaseListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `SwitchCaseListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: Syntax) -> SwitchCaseListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `SwitchCaseListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `SwitchCaseListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Syntax,
                        at index: Int) -> SwitchCaseListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `SwitchCaseListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `SwitchCaseListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: Syntax) -> SwitchCaseListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `SwitchCaseListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `SwitchCaseListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> SwitchCaseListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `SwitchCaseListSyntax` by removing the first element.
  ///
  /// - Returns: A new `SwitchCaseListSyntax` with the first element removed.
  public func removingFirst() -> SwitchCaseListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `SwitchCaseListSyntax` by removing the last element.
  ///
  /// - Returns: A new `SwitchCaseListSyntax` with the last element removed.
  public func removingLast() -> SwitchCaseListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> SwitchCaseListSyntaxIterator {
    return SwitchCaseListSyntaxIterator(collection: self)
  }
}

/// Conformance for `SwitchCaseListSyntax`` to the Collection protocol.
extension SwitchCaseListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> Syntax {
    return child(at: index)! 
  }
}

/// A type that iterates over a `SwitchCaseListSyntax` using its indices.
public struct SwitchCaseListSyntaxIterator: IteratorProtocol {
  public typealias Element = Syntax

  private let collection: SwitchCaseListSyntax
  private var index: SwitchCaseListSyntax.Index

  fileprivate init(collection: SwitchCaseListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `CatchClauseListSyntax` represents a collection of one or more
/// `CatchClauseSyntax` nodes. CatchClauseListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CatchClauseListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `CatchClauseListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `CatchClauseListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> CatchClauseListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return CatchClauseListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `CatchClauseListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `CatchClauseListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: CatchClauseSyntax) -> CatchClauseListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchClauseListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `CatchClauseListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: CatchClauseSyntax) -> CatchClauseListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `CatchClauseListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `CatchClauseListSyntax` with that element appended to the end.
  public func inserting(_ syntax: CatchClauseSyntax,
                        at index: Int) -> CatchClauseListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchClauseListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `CatchClauseListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: CatchClauseSyntax) -> CatchClauseListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchClauseListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `CatchClauseListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> CatchClauseListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchClauseListSyntax` by removing the first element.
  ///
  /// - Returns: A new `CatchClauseListSyntax` with the first element removed.
  public func removingFirst() -> CatchClauseListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `CatchClauseListSyntax` by removing the last element.
  ///
  /// - Returns: A new `CatchClauseListSyntax` with the last element removed.
  public func removingLast() -> CatchClauseListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> CatchClauseListSyntaxIterator {
    return CatchClauseListSyntaxIterator(collection: self)
  }
}

/// Conformance for `CatchClauseListSyntax`` to the Collection protocol.
extension CatchClauseListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> CatchClauseSyntax {
    return child(at: index)! as! CatchClauseSyntax
  }
}

/// A type that iterates over a `CatchClauseListSyntax` using its indices.
public struct CatchClauseListSyntaxIterator: IteratorProtocol {
  public typealias Element = CatchClauseSyntax

  private let collection: CatchClauseListSyntax
  private var index: CatchClauseListSyntax.Index

  fileprivate init(collection: CatchClauseListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `CaseItemListSyntax` represents a collection of one or more
/// `CaseItemSyntax` nodes. CaseItemListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CaseItemListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `CaseItemListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `CaseItemListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> CaseItemListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return CaseItemListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `CaseItemListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `CaseItemListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: CaseItemSyntax) -> CaseItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CaseItemListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `CaseItemListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: CaseItemSyntax) -> CaseItemListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `CaseItemListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `CaseItemListSyntax` with that element appended to the end.
  public func inserting(_ syntax: CaseItemSyntax,
                        at index: Int) -> CaseItemListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CaseItemListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `CaseItemListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: CaseItemSyntax) -> CaseItemListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `CaseItemListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `CaseItemListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> CaseItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CaseItemListSyntax` by removing the first element.
  ///
  /// - Returns: A new `CaseItemListSyntax` with the first element removed.
  public func removingFirst() -> CaseItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `CaseItemListSyntax` by removing the last element.
  ///
  /// - Returns: A new `CaseItemListSyntax` with the last element removed.
  public func removingLast() -> CaseItemListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> CaseItemListSyntaxIterator {
    return CaseItemListSyntaxIterator(collection: self)
  }
}

/// Conformance for `CaseItemListSyntax`` to the Collection protocol.
extension CaseItemListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> CaseItemSyntax {
    return child(at: index)! as! CaseItemSyntax
  }
}

/// A type that iterates over a `CaseItemListSyntax` using its indices.
public struct CaseItemListSyntaxIterator: IteratorProtocol {
  public typealias Element = CaseItemSyntax

  private let collection: CaseItemListSyntax
  private var index: CaseItemListSyntax.Index

  fileprivate init(collection: CaseItemListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `ConditionElementListSyntax` represents a collection of one or more
/// `ConditionElementSyntax` nodes. ConditionElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ConditionElementListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `ConditionElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `ConditionElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> ConditionElementListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return ConditionElementListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `ConditionElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `ConditionElementListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: ConditionElementSyntax) -> ConditionElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ConditionElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `ConditionElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: ConditionElementSyntax) -> ConditionElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `ConditionElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `ConditionElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: ConditionElementSyntax,
                        at index: Int) -> ConditionElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ConditionElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `ConditionElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: ConditionElementSyntax) -> ConditionElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `ConditionElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `ConditionElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> ConditionElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `ConditionElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `ConditionElementListSyntax` with the first element removed.
  public func removingFirst() -> ConditionElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `ConditionElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `ConditionElementListSyntax` with the last element removed.
  public func removingLast() -> ConditionElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> ConditionElementListSyntaxIterator {
    return ConditionElementListSyntaxIterator(collection: self)
  }
}

/// Conformance for `ConditionElementListSyntax`` to the Collection protocol.
extension ConditionElementListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> ConditionElementSyntax {
    return child(at: index)! as! ConditionElementSyntax
  }
}

/// A type that iterates over a `ConditionElementListSyntax` using its indices.
public struct ConditionElementListSyntaxIterator: IteratorProtocol {
  public typealias Element = ConditionElementSyntax

  private let collection: ConditionElementListSyntax
  private var index: ConditionElementListSyntax.Index

  fileprivate init(collection: ConditionElementListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `GenericRequirementListSyntax` represents a collection of one or more
/// `Syntax` nodes. GenericRequirementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct GenericRequirementListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `GenericRequirementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `GenericRequirementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> GenericRequirementListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return GenericRequirementListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `GenericRequirementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `GenericRequirementListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: Syntax) -> GenericRequirementListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericRequirementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `GenericRequirementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: Syntax) -> GenericRequirementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `GenericRequirementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `GenericRequirementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: Syntax,
                        at index: Int) -> GenericRequirementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericRequirementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `GenericRequirementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: Syntax) -> GenericRequirementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericRequirementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `GenericRequirementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> GenericRequirementListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericRequirementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `GenericRequirementListSyntax` with the first element removed.
  public func removingFirst() -> GenericRequirementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericRequirementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `GenericRequirementListSyntax` with the last element removed.
  public func removingLast() -> GenericRequirementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> GenericRequirementListSyntaxIterator {
    return GenericRequirementListSyntaxIterator(collection: self)
  }
}

/// Conformance for `GenericRequirementListSyntax`` to the Collection protocol.
extension GenericRequirementListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> Syntax {
    return child(at: index)! 
  }
}

/// A type that iterates over a `GenericRequirementListSyntax` using its indices.
public struct GenericRequirementListSyntaxIterator: IteratorProtocol {
  public typealias Element = Syntax

  private let collection: GenericRequirementListSyntax
  private var index: GenericRequirementListSyntax.Index

  fileprivate init(collection: GenericRequirementListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `GenericParameterListSyntax` represents a collection of one or more
/// `GenericParameterSyntax` nodes. GenericParameterListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct GenericParameterListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `GenericParameterListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `GenericParameterListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> GenericParameterListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return GenericParameterListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `GenericParameterListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `GenericParameterListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: GenericParameterSyntax) -> GenericParameterListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericParameterListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `GenericParameterListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: GenericParameterSyntax) -> GenericParameterListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `GenericParameterListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `GenericParameterListSyntax` with that element appended to the end.
  public func inserting(_ syntax: GenericParameterSyntax,
                        at index: Int) -> GenericParameterListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericParameterListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `GenericParameterListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: GenericParameterSyntax) -> GenericParameterListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericParameterListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `GenericParameterListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> GenericParameterListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericParameterListSyntax` by removing the first element.
  ///
  /// - Returns: A new `GenericParameterListSyntax` with the first element removed.
  public func removingFirst() -> GenericParameterListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericParameterListSyntax` by removing the last element.
  ///
  /// - Returns: A new `GenericParameterListSyntax` with the last element removed.
  public func removingLast() -> GenericParameterListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> GenericParameterListSyntaxIterator {
    return GenericParameterListSyntaxIterator(collection: self)
  }
}

/// Conformance for `GenericParameterListSyntax`` to the Collection protocol.
extension GenericParameterListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> GenericParameterSyntax {
    return child(at: index)! as! GenericParameterSyntax
  }
}

/// A type that iterates over a `GenericParameterListSyntax` using its indices.
public struct GenericParameterListSyntaxIterator: IteratorProtocol {
  public typealias Element = GenericParameterSyntax

  private let collection: GenericParameterListSyntax
  private var index: GenericParameterListSyntax.Index

  fileprivate init(collection: GenericParameterListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `CompositionTypeElementListSyntax` represents a collection of one or more
/// `CompositionTypeElementSyntax` nodes. CompositionTypeElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CompositionTypeElementListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `CompositionTypeElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `CompositionTypeElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> CompositionTypeElementListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return CompositionTypeElementListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `CompositionTypeElementListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: CompositionTypeElementSyntax) -> CompositionTypeElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `CompositionTypeElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: CompositionTypeElementSyntax) -> CompositionTypeElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `CompositionTypeElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: CompositionTypeElementSyntax,
                        at index: Int) -> CompositionTypeElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `CompositionTypeElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: CompositionTypeElementSyntax) -> CompositionTypeElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `CompositionTypeElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> CompositionTypeElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `CompositionTypeElementListSyntax` with the first element removed.
  public func removingFirst() -> CompositionTypeElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `CompositionTypeElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `CompositionTypeElementListSyntax` with the last element removed.
  public func removingLast() -> CompositionTypeElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> CompositionTypeElementListSyntaxIterator {
    return CompositionTypeElementListSyntaxIterator(collection: self)
  }
}

/// Conformance for `CompositionTypeElementListSyntax`` to the Collection protocol.
extension CompositionTypeElementListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> CompositionTypeElementSyntax {
    return child(at: index)! as! CompositionTypeElementSyntax
  }
}

/// A type that iterates over a `CompositionTypeElementListSyntax` using its indices.
public struct CompositionTypeElementListSyntaxIterator: IteratorProtocol {
  public typealias Element = CompositionTypeElementSyntax

  private let collection: CompositionTypeElementListSyntax
  private var index: CompositionTypeElementListSyntax.Index

  fileprivate init(collection: CompositionTypeElementListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `TupleTypeElementListSyntax` represents a collection of one or more
/// `TupleTypeElementSyntax` nodes. TupleTypeElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TupleTypeElementListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `TupleTypeElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `TupleTypeElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> TupleTypeElementListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return TupleTypeElementListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `TupleTypeElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `TupleTypeElementListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: TupleTypeElementSyntax) -> TupleTypeElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleTypeElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `TupleTypeElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: TupleTypeElementSyntax) -> TupleTypeElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `TupleTypeElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `TupleTypeElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: TupleTypeElementSyntax,
                        at index: Int) -> TupleTypeElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleTypeElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `TupleTypeElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: TupleTypeElementSyntax) -> TupleTypeElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleTypeElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `TupleTypeElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> TupleTypeElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleTypeElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `TupleTypeElementListSyntax` with the first element removed.
  public func removingFirst() -> TupleTypeElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `TupleTypeElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `TupleTypeElementListSyntax` with the last element removed.
  public func removingLast() -> TupleTypeElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> TupleTypeElementListSyntaxIterator {
    return TupleTypeElementListSyntaxIterator(collection: self)
  }
}

/// Conformance for `TupleTypeElementListSyntax`` to the Collection protocol.
extension TupleTypeElementListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> TupleTypeElementSyntax {
    return child(at: index)! as! TupleTypeElementSyntax
  }
}

/// A type that iterates over a `TupleTypeElementListSyntax` using its indices.
public struct TupleTypeElementListSyntaxIterator: IteratorProtocol {
  public typealias Element = TupleTypeElementSyntax

  private let collection: TupleTypeElementListSyntax
  private var index: TupleTypeElementListSyntax.Index

  fileprivate init(collection: TupleTypeElementListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `GenericArgumentListSyntax` represents a collection of one or more
/// `GenericArgumentSyntax` nodes. GenericArgumentListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct GenericArgumentListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `GenericArgumentListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `GenericArgumentListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> GenericArgumentListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return GenericArgumentListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `GenericArgumentListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `GenericArgumentListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: GenericArgumentSyntax) -> GenericArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericArgumentListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `GenericArgumentListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: GenericArgumentSyntax) -> GenericArgumentListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `GenericArgumentListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `GenericArgumentListSyntax` with that element appended to the end.
  public func inserting(_ syntax: GenericArgumentSyntax,
                        at index: Int) -> GenericArgumentListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericArgumentListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `GenericArgumentListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: GenericArgumentSyntax) -> GenericArgumentListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericArgumentListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `GenericArgumentListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> GenericArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericArgumentListSyntax` by removing the first element.
  ///
  /// - Returns: A new `GenericArgumentListSyntax` with the first element removed.
  public func removingFirst() -> GenericArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `GenericArgumentListSyntax` by removing the last element.
  ///
  /// - Returns: A new `GenericArgumentListSyntax` with the last element removed.
  public func removingLast() -> GenericArgumentListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> GenericArgumentListSyntaxIterator {
    return GenericArgumentListSyntaxIterator(collection: self)
  }
}

/// Conformance for `GenericArgumentListSyntax`` to the Collection protocol.
extension GenericArgumentListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> GenericArgumentSyntax {
    return child(at: index)! as! GenericArgumentSyntax
  }
}

/// A type that iterates over a `GenericArgumentListSyntax` using its indices.
public struct GenericArgumentListSyntaxIterator: IteratorProtocol {
  public typealias Element = GenericArgumentSyntax

  private let collection: GenericArgumentListSyntax
  private var index: GenericArgumentListSyntax.Index

  fileprivate init(collection: GenericArgumentListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}


/// `TuplePatternElementListSyntax` represents a collection of one or more
/// `TuplePatternElementSyntax` nodes. TuplePatternElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TuplePatternElementListSyntax: _SyntaxBase {
  let _root: SyntaxData
  unowned let _data: SyntaxData

  /// Creates a Syntax node from the provided root and data.
  internal init(root: SyntaxData, data: SyntaxData) {
    self._root = root
    self._data = data
  }

  /// Creates a new `TuplePatternElementListSyntax` by replacing the underlying layout with
  /// a different set of raw syntax nodes.
  ///
  /// - Parameter layout: The new list of raw syntax nodes underlying this
  ///                     collection.
  /// - Returns: A new `TuplePatternElementListSyntax` with the new layout underlying it.
  internal func replacingLayout(
    _ layout: [RawSyntax?]) -> TuplePatternElementListSyntax {
    let newRaw = data.raw.replacingLayout(layout)
    let (newRoot, newData) = data.replacingSelf(newRaw)
    return TuplePatternElementListSyntax(root: newRoot, data: newData)
  }

  /// Creates a new `TuplePatternElementListSyntax` by appending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to append.
  /// - Returns: A new `TuplePatternElementListSyntax` with that element appended to the end.
  public func appending(
    _ syntax: TuplePatternElementSyntax) -> TuplePatternElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.append(syntax.raw)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TuplePatternElementListSyntax` by prepending the provided syntax element
  /// to the children.
  ///
  /// - Parameter syntax: The element to prepend.
  /// - Returns: A new `TuplePatternElementListSyntax` with that element prepended to the
  ///            beginning.
  public func prepending(
    _ syntax: TuplePatternElementSyntax) -> TuplePatternElementListSyntax {
    return inserting(syntax, at: 0)
  }

  /// Creates a new `TuplePatternElementListSyntax` by inserting the provided syntax element
  /// at the provided index in the children.
  ///
  /// - Parameters:
  ///   - syntax: The element to insert.
  ///   - index: The index at which to insert the element in the collection.
  ///
  /// - Returns: A new `TuplePatternElementListSyntax` with that element appended to the end.
  public func inserting(_ syntax: TuplePatternElementSyntax,
                        at index: Int) -> TuplePatternElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid insertion index (0 to 1 past the end)
    precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                 "inserting node at invalid index \(index)")
    newLayout.insert(syntax.raw, at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TuplePatternElementListSyntax` by replacing the syntax element
  /// at the provided index.
  ///
  /// - Parameters:
  ///   - index: The index at which to replace the element in the collection.
  ///   - syntax: The element to replace with.
  ///
  /// - Returns: A new `TuplePatternElementListSyntax` with the new element at the provided index.
  public func replacing(childAt index: Int,
                        with syntax: TuplePatternElementSyntax) -> TuplePatternElementListSyntax {
    var newLayout = data.raw.layout
    /// Make sure the index is a valid index for replacing
    precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                 "replacing node at invalid index \(index)")
    newLayout[index] = syntax.raw
    return replacingLayout(newLayout)
  }

  /// Creates a new `TuplePatternElementListSyntax` by removing the syntax element at the
  /// provided index.
  ///
  /// - Parameter index: The index of the element to remove from the collection.
  /// - Returns: A new `TuplePatternElementListSyntax` with the element at the provided index
  ///            removed.
  public func removing(childAt index: Int) -> TuplePatternElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.remove(at: index)
    return replacingLayout(newLayout)
  }

  /// Creates a new `TuplePatternElementListSyntax` by removing the first element.
  ///
  /// - Returns: A new `TuplePatternElementListSyntax` with the first element removed.
  public func removingFirst() -> TuplePatternElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeFirst()
    return replacingLayout(newLayout)
  }

  /// Creates a new `TuplePatternElementListSyntax` by removing the last element.
  ///
  /// - Returns: A new `TuplePatternElementListSyntax` with the last element removed.
  public func removingLast() -> TuplePatternElementListSyntax {
    var newLayout = data.raw.layout
    newLayout.removeLast()
    return replacingLayout(newLayout)
  }

  /// Returns an iterator over the elements of this syntax collection.
  public func makeIterator() -> TuplePatternElementListSyntaxIterator {
    return TuplePatternElementListSyntaxIterator(collection: self)
  }
}

/// Conformance for `TuplePatternElementListSyntax`` to the Collection protocol.
extension TuplePatternElementListSyntax: Collection {
  public var startIndex: Int {
    return data.childCaches.startIndex
  }

  public var endIndex: Int {
    return data.childCaches.endIndex
  }

  public func index(after i: Int) -> Int {
    return data.childCaches.index(after: i)
  }

  public subscript(_ index: Int) -> TuplePatternElementSyntax {
    return child(at: index)! as! TuplePatternElementSyntax
  }
}

/// A type that iterates over a `TuplePatternElementListSyntax` using its indices.
public struct TuplePatternElementListSyntaxIterator: IteratorProtocol {
  public typealias Element = TuplePatternElementSyntax

  private let collection: TuplePatternElementListSyntax
  private var index: TuplePatternElementListSyntax.Index

  fileprivate init(collection: TuplePatternElementListSyntax) {
    self.collection = collection
    self.index = collection.startIndex
  }

  public mutating func next() -> Element? {
    guard
      !(self.collection.isEmpty || self.index == self.collection.endIndex)
    else {
      return nil
    }

    let result = collection[index]
    collection.formIndex(after: &index)
    return result
  }
}

