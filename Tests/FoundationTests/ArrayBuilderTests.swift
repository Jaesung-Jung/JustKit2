//
// ArrayBuilderTests.swift
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

// MARK: - ArrayBuilderTests

@Suite struct ArrayBuilderTests {
  @Test func testBuildBlockWithItems() {
    let result = build {
      1
      2
      3
    }
    #expect(result == [1, 2, 3])
  }

  @Test func testBuildBlockWithArrays() {
    let result: [Int] = build {
      [1, 2]
      [3, 4]
    }
    #expect(result == [1, 2, 3, 4])
  }

  @Test(arguments: [true, false]) func testBuildOptional(isIncludes: Bool) {
    let result = build {
      if isIncludes {
        1
      }
      2
      3
    }
    #expect(result == (isIncludes ? [1, 2, 3] : [2, 3]))
  }

  @Test(arguments: [true, false]) func testBuildEither(condition: Bool) {
    let result = build {
      if condition {
        1
        2
      } else {
        3
        4
      }
    }
    #expect(result == (condition ? [1, 2] : [3, 4]))
  }

  @Test func testBuildExpression() {
    let result = build {
      "Hello"
      "World"
    }
    #expect(result == ["Hello", "World"])
  }

  @Test func testBuildWithSequence() {
    let result: [Int] = build {
      repeatElement(5, count: 2)
      sequence(first: 0) { $0 < 5 ? $0 + 1 : nil }.map { $0 }
    }
    #expect(result == [5, 5, 0, 1, 2, 3 ,4, 5])
  }

  @Test func testBuildWithArray() {
    let result = build {
      for i in 0..<5 {
        i
      }
    }
    #expect(result == [0, 1, 2, 3, 4])
  }

  @Test func testBuildLimitedAvailability() {
    let result = build {
      if #available(iOS 18.0, macCatalyst 18.0, *) {
        "iOS 18"
      }
      "Item"
    }
    if #available(iOS 18.0, macCatalyst 18.0, *) {
      #expect(result == ["iOS 18", "Item"])
    } else {
      #expect(result == ["Item"])
    }
  }
}

// MARK: - ArrayBuilderTests (Build)

extension ArrayBuilderTests {
  func build<Item>(@ArrayBuilder<Item> builder: () -> [Item]) -> [Item] {
    return builder()
  }
}
