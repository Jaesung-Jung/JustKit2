//
//  FunctionTests.swift
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

@Suite struct FunctionTests {
  // MARK: - Clamp Tests

  @Test func testClampWithinBounds() {
    let value = 5
    let clampedValue = clamp(value, min: 0, max: 10)
    #expect(clampedValue == 5)
  }

  @Test func testClampBelowMinimum() {
    let value = -5
    let clampedValue = clamp(value, min: 0, max: 10)
    #expect(clampedValue == 0)
  }

  @Test func testClampAboveMaximum() {
    let value = 15
    let clampedValue = clamp(value, min: 0, max: 10)
    #expect(clampedValue == 10)
  }

  @Test func testClampWithEqualMinAndMax() {
    let value = 5
    let clampedValue = clamp(value, min: 10, max: 10)
    #expect(clampedValue == 10)
  }

  @Test func testClampWithFloatingPoint() {
    let value = 5.5
    let clampedValue = clamp(value, min: 0.0, max: 5.0)
    #expect(clampedValue == 5.0)
  }

  // MARK: - Curry Tests

  @Test func testCurryTwoArguments() {
    func add(_ a: Int, _ b: Int) -> Int {
      return a + b
    }
    let curriedAdd = curry(add)
    let add5 = curriedAdd(5)
    let result = add5(10)
    #expect(result == 15)
  }

  @Test func testCurryThreeArguments() {
    func multiply(_ a: Int, _ b: Int, _ c: Int) -> Int {
      return a * b * c
    }
    let curriedMultiply = curry(multiply)
    let multiply2 = curriedMultiply(2)
    let multiply2and3 = multiply2(3)
    let result = multiply2and3(4)
    #expect(result == 24)
  }

  @Test func testCurryFourArguments() {
    func sum(_ a: Int, _ b: Int, _ c: Int, _ d: Int) -> Int {
      return a + b + c + d
    }
    let curriedSum = curry(sum)
    let sum1 = curriedSum(1)
    let sum1and2 = sum1(2)
    let sum1and2and3 = sum1and2(3)
    let result = sum1and2and3(4)
    #expect(result == 10)
  }

  @Test func testCurryFiveArguments() {
    func concatenate(_ a: String, _ b: String, _ c: String, _ d: String, _ e: String) -> String {
      return a + b + c + d + e
    }
    let curriedConcatenate = curry(concatenate)
    let concatA = curriedConcatenate("A")
    let concatAB = concatA("B")
    let concatABC = concatAB("C")
    let concatABCD = concatABC("D")
    let result = concatABCD("E")
    #expect(result == "ABCDE")
  }

  // MARK: - Memoize Tests

  @Test func testMemoizeNoArgs() {
    var counter = 0
    let memoizedFunction = memoize {
      counter += 1
      return "Result"
    }

    let firstCall = memoizedFunction()
    let secondCall = memoizedFunction()

    #expect(firstCall == "Result")
    #expect(secondCall == "Result")
    #expect(counter == 1)
  }

  @Test func testMemoizeOneArg() {
    var counter = 0
    let memoizedFunction = memoize { (value: Int) -> String in
      counter += 1
      return "Result \(value)"
    }

    let firstCall = memoizedFunction(1)
    let secondCall = memoizedFunction(1)
    let thirdCall = memoizedFunction(2)

    #expect(firstCall == "Result 1")
    #expect(secondCall == "Result 1")
    #expect(thirdCall == "Result 2")
    #expect(counter == 2)
  }

  @Test func testMemoizeTwoArgs() {
    var counter = 0
    let memoizedFunction = memoize { (a: Int, b: Int) -> String in
      counter += 1
      return "\(a) + \(b) = \(a + b)"
    }

    let firstCall = memoizedFunction(1, 2)
    let secondCall = memoizedFunction(1, 2)
    let thirdCall = memoizedFunction(3, 4)

    #expect(firstCall == "1 + 2 = 3")
    #expect(secondCall == "1 + 2 = 3")
    #expect(thirdCall == "3 + 4 = 7")
    #expect(counter == 2)
  }

  @Test func testMemoizeThreeArgs() {
    var counter = 0
    let memoizedFunction = memoize { (a: Int, b: Int, c: Int) -> String in
      counter += 1
      return "\(a) + \(b) + \(c) = \(a + b + c)"
    }

    let firstCall = memoizedFunction(1, 2, 3)
    let secondCall = memoizedFunction(1, 2, 3)
    let thirdCall = memoizedFunction(4, 5, 6)

    #expect(firstCall == "1 + 2 + 3 = 6")
    #expect(secondCall == "1 + 2 + 3 = 6")
    #expect(thirdCall == "4 + 5 + 6 = 15")
    #expect(counter == 2)
  }

  // MARK: - Memoize Tests for 4 Arguments

  @Test func testMemoizeFourArgs() {
    var counter = 0
    let memoizedFunction = memoize { (a: Int, b: Int, c: Int, d: Int) -> String in
      counter += 1
      return "\(a) + \(b) + \(c) + \(d) = \(a + b + c + d)"
    }

    let firstCall = memoizedFunction(1, 2, 3, 4)
    let secondCall = memoizedFunction(1, 2, 3, 4)
    let thirdCall = memoizedFunction(5, 6, 7, 8)

    #expect(firstCall == "1 + 2 + 3 + 4 = 10")
    #expect(secondCall == "1 + 2 + 3 + 4 = 10")
    #expect(thirdCall == "5 + 6 + 7 + 8 = 26")
    #expect(counter == 2)
  }

  @Test func testMemoizeFiveArgs() {
    var counter = 0
    let memoizedFunction = memoize { (a: Int, b: Int, c: Int, d: Int, e: Int) -> String in
      counter += 1
      return "\(a) + \(b) + \(c) + \(d) + \(e) = \(a + b + c + d + e)"
    }

    let firstCall = memoizedFunction(1, 2, 3, 4, 5)
    let secondCall = memoizedFunction(1, 2, 3, 4, 5)
    let thirdCall = memoizedFunction(6, 7, 8, 9, 10)

    #expect(firstCall == "1 + 2 + 3 + 4 + 5 = 15")
    #expect(secondCall == "1 + 2 + 3 + 4 + 5 = 15")
    #expect(thirdCall == "6 + 7 + 8 + 9 + 10 = 40")
    #expect(counter == 2)
  }
}
