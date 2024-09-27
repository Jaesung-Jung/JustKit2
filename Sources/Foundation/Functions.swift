//
//  Functions.swift
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

// MARK: - Clamp

/// Restricts a value to be within the specified minimum and maximum bounds.
///
/// - Parameters:
///   - value: The value to clamp.
///   - minValue: The minimum allowable value.
///   - maxValue: The maximum allowable value.
/// - Returns: The clamped value within the specified range.
///
/// ```
/// let overflow = clamp(20, min: 0, max: 10)
/// print(overflow) // 10
///
/// let underflow = clamp(-5, min: 0, max: 10)
/// print(underflow) // 0
/// ```
@inlinable public func clamp<T>(_ value: T, min minValue: T, max maxValue: T) -> T where T: Comparable {
  return max(minValue, min(value, maxValue))
}

// MARK: - curry

/// Transforms a function that takes two arguments into a curried function that takes one argument at a time.
/// The curried function allows you to partially apply the function by providing one argument at a time.
///
/// - Parameter f: A function that takes two arguments of types `T1` and `T2` and returns a value of type `U`.
/// - Returns: A curried function that takes a `T1` argument first, and then returns another function that takes a `T2` argument,
///            which in turn returns a value of type `U`.
///
/// ```
/// func add(_ a: Int, b: Int) -> Int {
///   return a + b
/// }
///
/// let adder = curry(add)
/// let add27 = adder(27)
/// let result = add27(3)
///
/// print(result) // 30
/// ```
@inlinable public func curry<T1, T2, U>(_ f: @escaping (T1, T2) -> U) -> (T1) -> (T2) -> U {
  return { t1 in { t2 in f(t1, t2) } }
}

/// Transforms a function that takes three arguments into a curried function that takes one argument at a time.
/// The curried function allows you to partially apply the function by providing one argument at a time.
///
/// - Parameter f: A function that takes three arguments of types `T1`, `T2`, and `T3`, and returns a value of type `U`.
/// - Returns: A curried function that takes a `T1` argument first, then returns another function that takes a `T2` argument,
///            and finally returns a function that takes a `T3` argument, which then returns a value of type `U`.
///
/// ```
/// func multiply(_ a: Int, b: Int) -> Int {
///   return a * b
/// }
///
/// let multiplier = curry(multiply)
/// let multiplier3 = multiplier(3)
/// let result = multiplier3(9)
///
/// print(result) // 27
/// ```
@inlinable public func curry<T1, T2, T3, U>(_ f: @escaping (T1, T2, T3) -> U) -> (T1) -> (T2) -> (T3) -> U {
  return { t1 in { t2 in { t3 in f(t1, t2, t3) } } }
}

/// Transforms a function that takes four arguments into a curried function that takes one argument at a time.
/// The curried function allows you to partially apply the function by providing one argument at a time.
///
/// - Parameter f: A function that takes four arguments of types `T1`, `T2`, `T3`, and `T4`, and returns a value of type `U`.
/// - Returns: A curried function that takes a `T1` argument first, then returns another function that takes a `T2` argument,
///            followed by `T3` and `T4` arguments, ultimately returning a value of type `U`.
///
/// ```
/// func multiply(_ a: Int, b: Int) -> Int {
///   return a * b
/// }
///
/// let multiplier = curry(multiply)
/// let multiplier3 = multiplier(3)
/// let result = multiplier3(9)
///
/// print(result) // 27
/// ```
@inlinable public func curry<T1, T2, T3, T4, U>(_ f: @escaping (T1, T2, T3, T4) -> U) -> (T1) -> (T2) -> (T3) -> (T4) -> U {
  return { t1 in { t2 in { t3 in { t4 in f(t1, t2, t3, t4) } } } }
}

/// Transforms a function that takes five arguments into a curried function that takes one argument at a time.
/// The curried function allows you to partially apply the function by providing one argument at a time.
///
/// - Parameter f: A function that takes five arguments of types `T1`, `T2`, `T3`, `T4`, and `T5`, and returns a value of type `U`.
/// - Returns: A curried function that takes a `T1` argument first, then returns another function that takes a `T2` argument,
///            followed by `T3`, `T4`, and `T5` arguments, ultimately returning a value of type `U`.
///
/// ```
/// func multiply(_ a: Int, b: Int) -> Int {
///   return a * b
/// }
///
/// let multiplier = curry(multiply)
/// let multiplier3 = multiplier(3)
/// let result = multiplier3(9)
///
/// print(result) // 27
/// ```
@inlinable public func curry<T1, T2, T3, T4, T5, U>(_ f: @escaping (T1, T2, T3, T4, T5) -> U) -> (T1) -> (T2) -> (T3) -> (T4) -> (T5) -> U {
  return { t1 in { t2 in { t3 in { t4 in { t5 in f(t1, t2, t3, t4, t5) } } } } }
}

// MARK: - memoize

/// Memoizes a function that takes no arguments and returns a value, caching the result after the first call.
///
/// - Parameter f: A function that takes no arguments and returns a value of type `U`.
/// - Returns: A memoized version of the function `f`, which returns the same cached result after the first call.
///
/// ```
/// let expensiveComputation: () -> Int = {
///     print("Computing...")
///     return 42
/// }
/// let memoizedComputation = memoize(expensiveComputation)
///
/// let result1 = memoizedComputation()  // Prints "Computing..." and returns 42
/// let result2 = memoizedComputation()  // Returns cached value 42 without printing
/// ```
@inlinable public func memoize<U>(_ f: @escaping () -> U) -> () -> U {
  var memo: U?
  return {
    if let r = memo {
      return r
    }
    let r = f()
    memo = r
    return r
  }
}

/// Memoizes a function that takes no arguments and returns a value, caching the result after the first call.
///
/// - Parameter f: A function that takes no arguments and returns a value of type `U`.
/// - Returns: A memoized version of the function `f`, which returns the same cached result after the first call.
///
/// ```
/// func fibonacci(_ n: Int) -> Int {
///   guard n > 1 else {
///     return n
///   }
///   return fibonacci(n - 1) + fibonacci(n - 2)
/// }
///
/// let fibo = memoize(fibonacci)
/// let operatedValue = fibo(10)
/// let cachedValue = fibo(10)
///
/// print(operatedValue) // 55
/// print(cachedValue)   // 55
/// ```
@inlinable public func memoize<T, U>(_ f: @escaping (T) -> U) -> (T) -> U where T: Hashable {
  var memo: [T: U] = [:]
  return { t in
    if let r = memo[t] {
      return r
    }
    let r = f(t)
    memo[t] = r
    return r
  }
}

/// Memoizes a function that takes no arguments and returns a value, caching the result after the first call.
///
/// - Parameter f: A function that takes no arguments and returns a value of type `U`.
/// - Returns: A memoized version of the function `f`, which returns the same cached result after the first call.
///
/// ```
/// func fibonacci(_ n: Int) -> Int {
///   guard n > 1 else {
///     return n
///   }
///   return fibonacci(n - 1) + fibonacci(n - 2)
/// }
///
/// let fibo = memoize(fibonacci)
/// let operatedValue = fibo(10)
/// let cachedValue = fibo(10)
///
/// print(operatedValue) // 55
/// print(cachedValue)   // 55
/// ```
@inlinable public func memoize<T1, T2, U>(_ f: @escaping (T1, T2) -> U) -> (T1, T2) -> U where T1: Hashable, T2: Hashable {
  var memo: [Int: U] = [:]
  return { t1, t2 in
    let h = generateHash {
      $0.combine(t1)
      $0.combine(t2)
    }
    if let r = memo[h] {
      return r
    }
    let r = f(t1, t2)
    memo[h] = r
    return r
  }
}

/// Memoizes a function that takes no arguments and returns a value, caching the result after the first call.
///
/// - Parameter f: A function that takes no arguments and returns a value of type `U`.
/// - Returns: A memoized version of the function `f`, which returns the same cached result after the first call.
///
/// ```
/// func fibonacci(_ n: Int) -> Int {
///   guard n > 1 else {
///     return n
///   }
///   return fibonacci(n - 1) + fibonacci(n - 2)
/// }
///
/// let fibo = memoize(fibonacci)
/// let operatedValue = fibo(10)
/// let cachedValue = fibo(10)
///
/// print(operatedValue) // 55
/// print(cachedValue)   // 55
/// ```
@inlinable public func memoize<T1, T2, T3, U>(_ f: @escaping (T1, T2, T3) -> U) -> (T1, T2, T3) -> U where T1: Hashable, T2: Hashable, T3: Hashable {
  var memo: [Int: U] = [:]
  return { t1, t2, t3 in
    let h = generateHash {
      $0.combine(t1)
      $0.combine(t2)
      $0.combine(t3)
    }
    if let r = memo[h] {
      return r
    }
    let r = f(t1, t2, t3)
    memo[h] = r
    return r
  }
}

/// Memoizes a function that takes no arguments and returns a value, caching the result after the first call.
///
/// - Parameter f: A function that takes no arguments and returns a value of type `U`.
/// - Returns: A memoized version of the function `f`, which returns the same cached result after the first call.
///
/// ```
/// func fibonacci(_ n: Int) -> Int {
///   guard n > 1 else {
///     return n
///   }
///   return fibonacci(n - 1) + fibonacci(n - 2)
/// }
///
/// let fibo = memoize(fibonacci)
/// let operatedValue = fibo(10)
/// let cachedValue = fibo(10)
///
/// print(operatedValue) // 55
/// print(cachedValue)   // 55
/// ```
@inlinable public func memoize<T1, T2, T3, T4, U>(_ f: @escaping (T1, T2, T3, T4) -> U) -> (T1, T2, T3, T4) -> U where T1: Hashable, T2: Hashable, T3: Hashable, T4: Hashable {
  var memo: [Int: U] = [:]
  return { t1, t2, t3, t4 in
    let h = generateHash {
      $0.combine(t1)
      $0.combine(t2)
      $0.combine(t3)
      $0.combine(t4)
    }
    if let r = memo[h] {
      return r
    }
    let r = f(t1, t2, t3, t4)
    memo[h] = r
    return r
  }
}

/// Memoizes a function that takes no arguments and returns a value, caching the result after the first call.
///
/// - Parameter f: A function that takes no arguments and returns a value of type `U`.
/// - Returns: A memoized version of the function `f`, which returns the same cached result after the first call.
///
/// ```
/// func fibonacci(_ n: Int) -> Int {
///   guard n > 1 else {
///     return n
///   }
///   return fibonacci(n - 1) + fibonacci(n - 2)
/// }
///
/// let fibo = memoize(fibonacci)
/// let operatedValue = fibo(10)
/// let cachedValue = fibo(10)
///
/// print(operatedValue) // 55
/// print(cachedValue)   // 55
/// ```
@inlinable public func memoize<T1, T2, T3, T4, T5, U>(_ f: @escaping (T1, T2, T3, T4, T5) -> U) -> (T1, T2, T3, T4, T5) -> U where T1: Hashable, T2: Hashable, T3: Hashable, T4: Hashable, T5: Hashable {
  var memo: [Int: U] = [:]
  return { t1, t2, t3, t4, t5 in
    let h = generateHash {
      $0.combine(t1)
      $0.combine(t2)
      $0.combine(t3)
      $0.combine(t4)
      $0.combine(t5)
    }
    if let r = memo[h] {
      return r
    }
    let r = f(t1, t2, t3, t4, t5)
    memo[h] = r
    return r
  }
}

// MARK: - Hash

@inlinable func generateHash(_ builder: (inout Hasher) -> Void) -> Int {
  var hasher = Hasher()
  builder(&hasher)
  return hasher.finalize()
}
