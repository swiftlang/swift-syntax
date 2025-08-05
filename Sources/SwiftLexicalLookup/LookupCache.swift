//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// Unqualified lookup cache. Should be used when performing
/// large sequences of adjacent lookups to maximise performance.
public class LookupCache {
  /// Cached results of `ScopeSyntax.lookupParent` calls.
  /// Identified by `SyntaxIdentifier`.
  private let ancestorResultsCache: LRUCache<SyntaxIdentifier, [LookupResult]>
  /// Cached results of `SequentialScopeSyntax.sequentialLookup` calls.
  /// Identified by `SyntaxIdentifier`.
  private let sequentialResultsCache: LRUCache<SyntaxIdentifier, [LookupResult]>
  /// Looked-up scope identifiers during cache accesses.
  private var hits: Set<SyntaxIdentifier> = [] {
    didSet {
      if hits.count > capacity * 2 {
        hits.removeAll()
      }
    }
  }
  
  private let capacity: Int
  private var evictionCount = 0

  /// Creates a new unqualified lookup cache.
  /// `capacity` describes the maximum amount of entries in the cache.
  /// The cache size is maintained according to the LRU (Least Recently Used) policy.
  public init(capacity: Int) {
    self.capacity = capacity
    self.ancestorResultsCache = LRUCache(capacity: (capacity + 1) / 2)
    self.sequentialResultsCache = LRUCache(capacity: capacity / 2)
  }

  /// Get cached ancestor results for the given `id`.
  /// `nil` if there's no cache entry for the given `id`.
  /// Adds `id` and ids of all ancestors to the cache `hits`.
  func getCachedAncestorResults(id: SyntaxIdentifier) -> [LookupResult]? {
    guard let results = ancestorResultsCache[id] else { return nil }
    hits.formUnion(results.map(\.scope.id))
    hits.insert(id)
    return results
  }

  /// Set cached ancestor results for the given `id`.
  /// Adds `id` to the cache `hits`.
  func setCachedAncestorResults(id: SyntaxIdentifier, results: [LookupResult]) {
    hits.insert(id)
    ancestorResultsCache[id] = results
  }

  /// Get cached sequential lookup results for the given `id`.
  /// `nil` if there's no cache entry for the given `id`.
  /// Adds `id` to the cache `hits`.
  func getCachedSequentialResults(id: SyntaxIdentifier) -> [LookupResult]? {
    guard let results = sequentialResultsCache[id] else { return nil }
    hits.insert(id)
    return results
  }

  /// Set cached sequential lookup results for the given `id`.
  /// Adds `id` to the cache `hits`.
  func setCachedSequentialResults(id: SyntaxIdentifier, results: [LookupResult]) {
    hits.insert(id)
    sequentialResultsCache[id] = results
  }

  /// Removes all cached entries without a hit, unless it's prohibited
  /// by the internal `drop` counter.
  /// `drop` parameter specifies how many eviction calls will be
  /// ignored before evicting not-hit members from subsequent lookups.
  ///
  /// Example cache eviction sequences (s - skip, e - evict):
  /// - `drop = 0` - `e -> e -> e -> e -> e -> ...`
  /// - `drop = 1` - `s -> e -> s -> s -> e -> ...`
  /// - `drop = 3` - `s -> s -> s -> e -> s -> ...`
  ///
  /// - Note: `drop = 0` effectively maintains exactly one path of cached results to
  /// the root in the cache (assuming we evict cache members after each lookup in a sequence of lookups).
  /// Higher the `drop` value, more such paths can potentially be stored in the cache at any given moment.
  /// Because of that, a higher `drop` value also translates to a higher number of cache-hits,
  /// but it might not directly translate to better performance. Because of a larger memory footprint,
  /// memory accesses could take longer, slowing down the eviction process. That's why the `drop` value
  /// could be fine-tuned to maximize the performance given file size,
  /// number of lookups, and amount of available memory.
  public func evictEntriesWithoutHit(drop: Int = 0) {
    evictionCount = (evictionCount + 1) % (drop + 1)
    guard evictionCount != 0 else { return }

    for key in ancestorResultsCache.keys where !hits.contains(key) {
      ancestorResultsCache[key] = nil
    }
    for key in sequentialResultsCache.keys where !hits.contains(key) {
      sequentialResultsCache[key] = nil
    }

    hits = []
  }
}
