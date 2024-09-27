//
//  Cache.swift
//
//  Copyright © 2024 Jaesung Jung. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

// MARK: - Cache

/// A generic cache that stores objects in memory with optional expiration times and cost limits.
///
/// This class wraps an `NSCache` and provides additional features, such as object expiration and customizable eviction handling.
public class Cache<Key: Hashable, Object> {
  let storage = NSCache<NSNumber, Box>()

  var delegateProxy: NSCacheDelegateProxy?

  /// Called when an object is about to be evicted or removed from the cache.
  public var willEvictObject: ((Object) -> Void)? {
    get { delegateProxy?.observer }
    set {
      delegateProxy = newValue.map { NSCacheDelegateProxy(observer: $0) }
      storage.delegate = delegateProxy
    }
  }

  /// The name of the cache.
  ///
  /// The default value is an empty string ("").
  public var name: String {
    get { storage.name }
    set { storage.name = newValue }
  }

  /// The maximum total cost that the cache can hold before it starts evicting objects.
  ///
  /// If 0, there is no total cost limit. The default value is 0.
  /// When you add an object to the cache, you may pass in a specified cost for the object,
  /// such as the size in bytes of the object. If adding this object to the cache causes the cache’s
  /// total cost to rise above totalCostLimit, the cache may automatically evict objects until
  /// its total cost falls below totalCostLimit. The order in which the cache evicts objects is not guaranteed.
  /// This is not a strict limit, and if the cache goes over the limit, an object in the cache could be evicted instantly,
  /// at a later point in time, or possibly never, all depending on the implementation details of the cache.
  public var costLimit: Int {
    get { storage.totalCostLimit }
    set { storage.totalCostLimit = newValue }
  }

  /// The maximum number of objects the cache should hold.
  ///
  /// If 0, there is no count limit. The default value is 0.
  /// This is not a strict limit—if the cache goes over the limit, an object in the cache could be evicted instantly,
  /// later, or possibly never, depending on the implementation details of the cache.
  public var countLimit: Int {
    get { storage.countLimit }
    set { storage.countLimit = newValue }
  }

  /// Whether the cache will automatically evict discardable-content objects whose content has been discarded.
  public var evictsObjectsWithDiscardedContent: Bool {
    get { storage.evictsObjectsWithDiscardedContent }
    set { storage.evictsObjectsWithDiscardedContent = newValue }
  }

  /// Initializes a new cache.
  ///
  /// - Parameters:
  ///   - name: The name of the cache (optional).
  ///   - costLimit: The total cost limit of the cache (optional).
  ///   - countLimit: The count limit of the cache (optional).
  public init(name: String? = nil, costLimit: Int? = nil, countLimit: Int? = nil) {
    if let name = name {
      storage.name = name
    }
    if let costLimit = costLimit {
      storage.totalCostLimit = costLimit
    }
    if let countLimit = countLimit {
      storage.countLimit = countLimit
    }
  }

  /// Returns the value associated with a given key.
  ///
  /// - Parameter key: An object identifying the value.
  /// - Returns: The value associated with key, or nil if no value is associated with key.
  public func object(forKey key: Key) -> Object? {
    let key = NSNumber(value: key.hashValue)
    guard let item = storage.object(forKey: key) else {
      return nil
    }
    if item.isExpired {
      storage.removeObject(forKey: key)
      return nil
    }
    return item.object
  }

  /// Sets the value of the specified key in the cache.
  ///
  /// - Parameters:
  ///   - obj: The object to be stored in the cache.
  ///   - key: The key with which to associate the value.
  ///   - cost: The cost of the object (default is `0`).
  ///   - expiration: The expiration policy for the object (default is `.never`).
  public func setObject(_ obj: Object, forKey key: Key, cost: Int = 0, expiration: Expiration = .never) {
    storage.setObject(Box(obj, expiration: expiration), forKey: NSNumber(value: key.hashValue), cost: cost)
  }

  /// Removes the value of the specified key in the cache.
  ///
  /// - Parameter key: The key identifying the value to be removed.
  public func removeObject(forKey key: Key) {
    storage.removeObject(forKey: NSNumber(value: key.hashValue))
  }
  
  /// Empties the cache.
  public func removeAllObjects() {
    storage.removeAllObjects()
  }
}

// MARK: - Cache.Expiration

extension Cache {
  /// An enumeration that defines the expiration policies for cached objects.
  public enum Expiration {
    case seconds(Int)
    case milliseconds(Int)
    case never

    var timeInterval: TimeInterval? {
      switch self {
      case .seconds(let seconds):
        return TimeInterval(seconds)
      case .milliseconds(let milliseconds):
        return TimeInterval(milliseconds) / 1000
      case .never:
        return nil
      }
    }
  }
}

// MARK: - Cache.Box<T>

extension Cache {
  class Box {
    let creationDate = Date()
    let object: Object
    let expiration: Expiration
    var isExpired: Bool {
      guard let timeInterval = expiration.timeInterval else {
        return false
      }
      return -creationDate.timeIntervalSinceNow > timeInterval
    }

    init(_ object: Object, expiration: Expiration) {
      self.object = object
      self.expiration = expiration
    }
  }
}

// MARK: - Cache (NSCacheDelegateProxy)

extension Cache {
  class NSCacheDelegateProxy: NSObject, NSCacheDelegate {
    let observer: (Object) -> Void

    init(observer: @escaping (Object) -> Void) {
      self.observer = observer
    }

    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
      if let box = obj as? Box {
        observer(box.object)
      }
    }
  }
}
