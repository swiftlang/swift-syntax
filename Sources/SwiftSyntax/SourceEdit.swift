public struct SourceEdit: Equatable {
  /// The byte range of the original source buffer that the edit applies to.
  public let range: ByteSourceRange
  /// The length of the edit replacement in UTF8 bytes.
  public let replacementLength: Int

  public var offset: Int { return range.offset }

  public var length: Int { return range.length }

  public var endOffset: Int { return range.endOffset }

  /// After the edit has been applied the range of the replacement text.
  public var replacementRange: ByteSourceRange {
    return ByteSourceRange(offset: offset, length: replacementLength)
  }

  public init(range: ByteSourceRange, replacementLength: Int) {
    self.range = range
    self.replacementLength = replacementLength
  }

  public init(offset: Int, length: Int, replacementLength: Int) {
    self.range = ByteSourceRange(offset: offset, length: length)
    self.replacementLength = replacementLength
  }

  public func intersectsOrTouchesRange(_ other: ByteSourceRange) -> Bool {
    return self.range.intersectsOrTouches(other)
  }

  public func intersectsRange(_ other: ByteSourceRange) -> Bool {
    return self.range.intersects(other)
  }
}

fileprivate extension Sequence where Element: Comparable {
  var isSorted: Bool {
    return zip(self, self.dropFirst()).allSatisfy({ $0.0 < $0.1 })
  }
}

/// Edits that are applied **simultaneously**. That is, the offsets of all edits
/// refer to the original string and are not shifted by previous edits. For
/// example applying
///  - insert 'x' at offset 0
///  - insert 'y' at offset 1
///  - insert 'z' at offset 2
///  to '012345' results in 'x0y1z2345'.
///
/// The raw `edits` of this struct are guaranteed to
///   1. not be overlapping.
///   2. be in increasing source offset order.
public struct ConcurrentEdits {
  enum ConcurrentEditsError: Error, CustomStringConvertible {
    case editsNotConcurrent

    var description: String {
      switch self {
      case .editsNotConcurrent:
        return "Edits passed to ConcurrentEdits(concurrent:) does not satisfy the requirements posed by ConcurrentEdits"
      }
    }
  }

  /// The raw concurrent edits. Are guaranteed to satisfy the requirements
  /// stated above.
  public let edits: [SourceEdit]

  /// Initialize this struct from edits that are already in a concurrent form
  /// and are guaranteed to satisfy the requirements posed above.
  public init(concurrent: [SourceEdit]) throws {
    if !Self.isValidConcurrentEditArray(concurrent) {
      throw ConcurrentEditsError.editsNotConcurrent
    }
    self.edits = concurrent
  }

  /// Create concurrent from a set of sequential edits. Sequential edits are
  /// applied one after the other. Applying the first edit results in an
  /// intermediate string to which the second edit is applied etc. For example
  /// applying
  ///  - insert 'x' at offset 0
  ///  - insert 'y' at offset 1
  ///  - insert 'z' at offset 2
  ///  to '012345' results in 'xyz012345'.

  public init(fromSequential sequentialEdits: [SourceEdit]) {
    do {
      try self.init(concurrent: Self.translateSequentialEditsToConcurrentEdits(sequentialEdits))
    } catch {
      fatalError("ConcurrentEdits created by translateSequentialEditsToConcurrentEdits do not satisfy ConcurrentEdits requirements")
    }
  }

  /// Construct a concurrent edits struct from a single edit. For a single edit,
  /// there is no differentiation between being it being applied concurrently
  /// or sequentially.
  public init(_ single: SourceEdit) {
    do {
      try self.init(concurrent: [single])
    } catch {
      fatalError("A single edit doesn't satisfy the ConcurrentEdits requirements?")
    }
  }

  private static func translateSequentialEditsToConcurrentEdits(
    _ edits: [SourceEdit]
  ) -> [SourceEdit] {
    var concurrentEdits: [SourceEdit] = []
    for editToAdd in edits {
      var editToAdd = editToAdd
      var editIndiciesMergedWithNewEdit: [Int] = []
      for (index, existingEdit) in concurrentEdits.enumerated() {
        if existingEdit.replacementRange.intersectsOrTouches(editToAdd.range) {
          let intersectionLength =
            existingEdit.replacementRange.intersected(editToAdd.range).length
          editToAdd = SourceEdit(
            offset: Swift.min(existingEdit.offset, editToAdd.offset),
            length: existingEdit.length + editToAdd.length - intersectionLength,
            replacementLength: existingEdit.replacementLength +
              editToAdd.replacementLength - intersectionLength
          )
          editIndiciesMergedWithNewEdit.append(index)
        } else if existingEdit.offset < editToAdd.endOffset {
          editToAdd = SourceEdit(
            offset: editToAdd.offset - existingEdit.replacementLength +
              existingEdit.length,
            length: editToAdd.length,
            replacementLength: editToAdd.replacementLength
          )
        }
      }
      assert(editIndiciesMergedWithNewEdit.isSorted)
      for indexToRemove in editIndiciesMergedWithNewEdit.reversed() {
        concurrentEdits.remove(at: indexToRemove)
      }
      let insertPos = concurrentEdits.firstIndex(where: { edit in
        editToAdd.endOffset <= edit.offset
      }) ?? concurrentEdits.count
      concurrentEdits.insert(editToAdd, at: insertPos)
      assert(ConcurrentEdits.isValidConcurrentEditArray(concurrentEdits))
    }
    return concurrentEdits
  }

  private static func isValidConcurrentEditArray(_ edits: [SourceEdit]) -> Bool {
    // Not quite sure if we should disallow creating an `IncrementalParseTransition`
    // object without edits but there doesn't seem to be much benefit if we do,
    // and there are 'lit' tests that want to test incremental re-parsing without edits.
    guard !edits.isEmpty else { return true }

    for i in 1..<edits.count {
      let prevEdit = edits[i-1]
      let curEdit = edits[i]
      if curEdit.range.offset < prevEdit.range.endOffset {
        return false
      }
      if curEdit.intersectsRange(prevEdit.range) {
        return false
      }
    }
    return true
  }

  /// **Public for testing purposes only**
  public static func _isValidConcurrentEditArray(_ edits: [SourceEdit]) -> Bool {
    return isValidConcurrentEditArray(edits)
  }
}
