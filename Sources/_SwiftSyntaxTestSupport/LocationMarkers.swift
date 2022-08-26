//===--- LocationMarkers.swift --------------------------------------------===//
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

/// Finds all marked ranges in the given text, see `Marker`.
fileprivate func findMarkedRanges(text: String) -> [Marker] {
  var markers = [Marker]()
  while let marker = nextMarkedRange(text: text, from: markers.last?.range.upperBound ?? text.startIndex) {
    markers.append(marker)
  }
  return markers
}

fileprivate func nextMarkedRange(text: String, from: String.Index) -> Marker? {
  guard let start = text.range(of: "#^", range: from ..< text.endIndex),
        let end = text.range(of: "^#", range: start.upperBound ..< text.endIndex) else {
    return nil
  }

  let markerRange = start.lowerBound ..< end.upperBound
  let name = text[start.upperBound ..< end.lowerBound]

  // Expand to the whole line if the line only contains the marker
  let lineRange = text.lineRange(for: start)
  if text[lineRange].trimmingCharacters(in: .whitespacesAndNewlines) == text[markerRange] {
    return Marker(name: name, range: lineRange)
  }
  return Marker(name: name, range: markerRange)
}

fileprivate struct Marker {
  /// The name of the marker without the `#^` and `^#` markup.
  let name: Substring
  /// The range of the marker.
  ///
  /// If the marker contains all the the non-whitepace characters on the line,
  /// this is the range of the entire line. Otherwise it's the range of the
  /// marker itself, including the `#^` and `^#` markup.
  let range: Range<String.Index>
}

public func extractMarkers(_ markedText: String) -> (markers: [String: Int], textWithoutMarkers: String) {
  var text = ""
  var markers = [String: Int]()
  var lastIndex = markedText.startIndex
  for marker in findMarkedRanges(text: markedText) {
    text += markedText[lastIndex ..< marker.range.lowerBound]
    lastIndex = marker.range.upperBound

    assert(markers[String(marker.name)] == nil, "Marker names must be unique")
    markers[String(marker.name)] = text.utf8.count
  }
  text += markedText[lastIndex ..< markedText.endIndex]

  return (markers, text)
}
