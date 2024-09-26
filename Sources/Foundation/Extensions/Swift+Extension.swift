//
//  Swift+Extension.swift
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

extension Sequence {
  /// Returns a sorted array of elements using a key path to compare values.
  ///
  /// - Parameter keyPath: The key path to the property used for sorting.
  /// - Returns: A sorted array of the sequence's elements.
  @inlinable public func sorted<T: Comparable>(using keyPath: KeyPath<Element, T>) -> [Element] {
    sorted(using: keyPath, by: <)
  }

  /// Returns a sorted array of elements using a key path and a custom comparator.
  ///
  /// - Parameters:
  ///   - keyPath: The key path to the property used for sorting.
  ///   - areInIncreasingOrder: A function that compares two property values and returns `true` if they are in the desired order.
  /// - Returns: A sorted array of the sequence's elements.
  @inlinable public func sorted<T: Comparable>(using keyPath: KeyPath<Element, T>, by areInIncreasingOrder: (T, T) -> Bool) -> [Element] {
    sorted { areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath]) }
  }
}

// MARK: - Sequence (Concurrency)

extension Sequence {
  /// Asynchronously transforms each element of the sequence using the provided asynchronous closure.
  ///
  /// - Parameter transform: An asynchronous closure that transforms each element of the sequence.
  /// - Returns: An array containing the transformed values.
  public func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
    var values: [T] = []
    for element in self {
      try await values.append(transform(element))
    }
    return values
  }

  /// Asynchronously transforms each element of the sequence, ignoring `nil` results.
  ///
  /// - Parameter transform: An asynchronous closure that transforms each element of the sequence.
  /// - Returns: An array containing the non-`nil` transformed values.
  public func asyncCompactMap<ElementOfResult>(_ transform: (Element) async throws -> ElementOfResult?) async rethrows -> [ElementOfResult] {
    var values: [ElementOfResult] = []
    for element in self {
      if let result = try await transform(element) {
        values.append(result)
      }
    }
    return values
  }
}

// MARK: - Collection (Safe Access)

extension Collection {
  /// Safely returns the element at the specified position, or `nil` if the index is out of bounds.
  ///
  /// - Parameter position: The index of the element.
  /// - Returns: The element at the specified index if it exists, otherwise `nil`.
  @inlinable public subscript(safe position: Index) -> Element? {
    indices.contains(position) ? self[position] : nil
  }
}

// MARK: - Array

extension Array {
  /// Initializes an array using the `@ArrayBuilder`.
  ///
  /// - Parameter build: A closure that returns an array of elements.
  public init(@ArrayBuilder<Element> build: () -> [Element]) {
    self.init(build())
  }

  /// Returns a new array by appending a single element to the array.
  ///
  /// - Parameter newElement: The element to append.
  /// - Returns: A new array with the appended element.
  @inlinable public func appending(_ newElement: Element) -> [Element] {
    var mutable = self
    mutable.append(newElement)
    return mutable
  }

  /// Returns a new array by appending the contents of a sequence to the array.
  ///
  /// - Parameter newElements: A sequence of elements to append.
  /// - Returns: A new array with the appended elements.
  @inlinable public func appending<S: Sequence>(contentsOf newElements: S) -> [Element] where S.Element == Element {
    var mutable = self
    mutable.append(contentsOf: newElements)
    return mutable
  }
}

// MARK: - ArraySlice

extension ArraySlice {
  /// Returns a new `ArraySlice` by appending a single element.
  ///
  /// - Parameter newElement: The element to append.
  /// - Returns: A new `ArraySlice` with the appended element.
  @inlinable public func appending(_ newElement: Element) -> ArraySlice<Element> {
    var mutable = self
    mutable.append(newElement)
    return mutable
  }

  /// Returns a new `ArraySlice` by appending the contents of a sequence.
  ///
  /// - Parameter newElements: A sequence of elements to append.
  /// - Returns: A new `ArraySlice` with the appended elements.
  @inlinable public func appending<S: Sequence>(contentsOf newElements: S) -> ArraySlice<Element> where S.Element == Element {
    var mutable = self
    mutable.append(contentsOf: newElements)
    return mutable
  }
}

// MARK: - ContiguousArray

extension ContiguousArray {
  /// Returns a new `ContiguousArray` by appending a single element.
  ///
  /// - Parameter newElement: The element to append.
  /// - Returns: A new `ContiguousArray` with the appended element.
  @inlinable public func appending(_ newElement: Element) -> ContiguousArray<Element> {
    var mutable = self
    mutable.append(newElement)
    return mutable
  }

  /// Returns a new `ContiguousArray` by appending the contents of a sequence.
  ///
  /// - Parameter newElements: A sequence of elements to append.
  /// - Returns: A new `ContiguousArray` with the appended elements.
  @inlinable public func appending<S: Sequence>(contentsOf newElements: S) -> ContiguousArray<Element> where S.Element == Element {
    var mutable = self
    mutable.append(contentsOf: newElements)
    return mutable
  }
}
