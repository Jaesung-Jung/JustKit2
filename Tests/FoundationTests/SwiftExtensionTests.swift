//
//  SwiftExtensionTests.swift
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

import Testing
@testable import JustFoundation

// MARK: - SequenceExtensionTests

@Suite struct SequenceExtensionTests {
  @Test func testSortedUsingKeyPath() {
    struct Person {
      let name: String
      let age: Int
    }

    let people = [
      Person(name: "Charlie", age: 35),
      Person(name: "Alice", age: 30),
      Person(name: "Bob", age: 25)
    ]

    let sortedByName = people.sorted(using: \.name)
    #expect(sortedByName.map(\.name) == ["Alice", "Bob", "Charlie"])

    let sortedByAgeDescending = people.sorted(using: \.age, by: >)
    #expect(sortedByAgeDescending.map(\.age) == [35, 30, 25])
  }

  @Test func testAsyncMap() async throws {
    let numbers = [1, 2, 3, 4, 5]
    let results = try await numbers.asyncMap { number in
      try await Task.sleep(for: .milliseconds(5))
      return number * 2
    }
    #expect(results == [2, 4, 6, 8, 10])
  }

  @Test func testAsyncCompactMap() async throws {
    let numbers = [1, 2, 3, 4, 5]
    let results = try await numbers.asyncCompactMap { number in
      try await Task.sleep(for: .milliseconds(5))
      return number.isMultiple(of: 2) ? number * 2 : nil
    }
    #expect(results == [4, 8])
  }
}

// MARK: - SequenceExtensionTests
@Suite struct CollectionExtensionTests {
  @Test func testSafeSubscript() {
    let array = [1, 2, 3]
    #expect(array[safe: array.startIndex] == 1)
    #expect(array[safe: array.index(after: array.startIndex)] == 2)
    #expect(array[safe: array.index(before: array.endIndex)] == 3)
    #expect(array[safe: array.endIndex] == nil)
    #expect(array[safe: array.index(after: array.endIndex)] == nil)
  }
}

// MARK: - ArrayExtensionTests

@Suite struct ArrayExtensionTests {
  @Test func testArrayBuilderInit() {
    let array = Array {
      1
      2
      if true {
        3
      }
      for i in 4...5 {
        i
      }
    }
    #expect(array == [1, 2, 3, 4, 5])
  }

  @Test func testAppendingElement() {
    let array = [1, 2, 3]
    let newArray = array.appending(4)
    #expect(array == [1, 2, 3])
    #expect(newArray == [1, 2, 3, 4])
  }

  @Test func testAppendingContentsOf() {
    let array = [1, 2, 3]
    let newArray = array.appending(contentsOf: [4, 5])
    #expect(array == [1, 2, 3])
    #expect(newArray == [1, 2, 3, 4, 5])
  }
}

// MARK: - ArraySliceExtensionTests

@Suite struct ArraySliceExtensionTests {
  @Test func testAppendingElementToSlice() {
    let array: ArraySlice = [1, 2, 3][0...1]
    let newSlice = array.appending(4)
    #expect(Array(newSlice) == [1, 2, 4])
  }

  @Test func testAppendingContentsOfToSlice() {
    let array: ArraySlice = [1, 2, 3][0...1]
    let newSlice = array.appending(contentsOf: [4, 5])
    #expect(Array(newSlice) == [1, 2, 4, 5])
  }
}

// MARK: - ContiguousArrayExtensionTests

@Suite struct ContiguousArrayExtensionTests {
  @Test func testAppendingElementToContiguousArray() {
    let array: ContiguousArray = [1, 2, 3]
    let newArray = array.appending(4)
    #expect(newArray == [1, 2, 3, 4])
  }

  @Test func testAppendingContentsOfToContiguousArray() {
    let array: ContiguousArray = [1, 2, 3]
    let newArray = array.appending(contentsOf: [4, 5])
    #expect(newArray == [1, 2, 3, 4, 5])
  }
}
