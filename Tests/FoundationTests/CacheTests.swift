//
//  CacheTests.swift
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
import Testing
@testable import JustFoundation

@Suite struct CacheTests {
  @Test func testSetObjectAndGetObject() {
    let cache = Cache<String, String>()
    cache.setObject("TestObject", forKey: "key1")
    let retrievedObject = cache.object(forKey: "key1")
    #expect(retrievedObject == "TestObject")
  }

  @Test func testSetObjectWithExpiration() async throws {
    let cache = Cache<String, String>()
    cache.setObject("TestObject", forKey: "key1", expiration: .seconds(1))
    let retrievedObjectBeforeExpiration = cache.object(forKey: "key1")
    #expect(retrievedObjectBeforeExpiration == "TestObject")

    try await Task.sleep(for: .seconds(1.5))
    let retrievedObjectAfterExpiration = cache.object(forKey: "key1")
    #expect(retrievedObjectAfterExpiration == nil)
  }

  @Test func testRemoveObject() {
    let cache = Cache<String, String>()
    cache.setObject("TestObject", forKey: "key1")
    cache.removeObject(forKey: "key1")
    let retrievedObject = cache.object(forKey: "key1")
    #expect(retrievedObject == nil)
  }

  @Test func testRemoveAllObjects() {
    let cache = Cache<String, String>()
    cache.setObject("TestObject1", forKey: "key1")
    cache.setObject("TestObject2", forKey: "key2")
    cache.removeAllObjects()
    let retrievedObject1 = cache.object(forKey: "key1")
    let retrievedObject2 = cache.object(forKey: "key2")
    #expect(retrievedObject1 == nil)
    #expect(retrievedObject2 == nil)
  }

  @Test func testCostLimit() {
    let cache = Cache<String, String>(costLimit: 1)
    cache.setObject("TestObject1", forKey: "key1", cost: 1)
    cache.setObject("TestObject2", forKey: "key2", cost: 1)
    let retrievedObject1 = cache.object(forKey: "key1")
    let retrievedObject2 = cache.object(forKey: "key2")
    // Since the cost limit is 1, only the last object should remain in the cache
    #expect(retrievedObject1 == nil)
    #expect(retrievedObject2 == "TestObject2")
  }

  @Test func testCountLimit() {
    let cache = Cache<String, String>(countLimit: 1)
    cache.setObject("TestObject1", forKey: "key1")
    cache.setObject("TestObject2", forKey: "key2")
    let retrievedObject1 = cache.object(forKey: "key1")
    let retrievedObject2 = cache.object(forKey: "key2")
    // Since the count limit is 1, only the last object should remain in the cache
    #expect(retrievedObject1 == nil)
    #expect(retrievedObject2 == "TestObject2")
  }

  @Test func testWillEvictObject() {
    let cache = Cache<String, String>(countLimit: 1)
    var evictedObject: String?

    cache.willEvictObject = { object in
      evictedObject = object
    }

    cache.setObject("TestObject1", forKey: "key1")
    cache.setObject("TestObject2", forKey: "key2") // This should evict "TestObject1"

    #expect(evictedObject == "TestObject1")
  }

  @Test func testEvictsObjectsWithDiscardedContent() {
    let cache = Cache<String, String>()
    cache.evictsObjectsWithDiscardedContent = true
    cache.setObject("TestObject1", forKey: "key1")
    #expect(cache.evictsObjectsWithDiscardedContent == true)
  }
}
