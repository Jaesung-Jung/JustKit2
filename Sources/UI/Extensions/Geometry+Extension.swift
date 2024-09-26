//
//  Geometry+Extension.swift
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

import SwiftUI

// MARK: - UIEdgeInsets

extension UIEdgeInsets {
  /// The combined vertical insets (`top + bottom`).
  @inlinable public var vertical: CGFloat { top + bottom }

  /// The combined horizontal insets (`left + right`).
  @inlinable public var horizontal: CGFloat { left + right }

  /// Negates the insets, flipping the sign of each side.
  @inlinable public var negate: UIEdgeInsets {
    UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
  }

  /// Initializes `UIEdgeInsets` with a top inset and zero for all other sides.
  ///
  /// - Parameter top: The inset for the top edge.
  public init(top: CGFloat) {
    self.init(top: top, left: 0, bottom: 0, right: 0)
  }

  /// Initializes `UIEdgeInsets` with a top and left inset.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - left: The inset for the left edge.
  public init(top: CGFloat, left: CGFloat) {
    self.init(top: top, left: left, bottom: 0, right: 0)
  }

  /// Initializes `UIEdgeInsets` with a top and bottom inset.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - bottom: The inset for the bottom edge.
  public init(top: CGFloat, bottom: CGFloat) {
    self.init(top: top, left: 0, bottom: bottom, right: 0)
  }

  /// Initializes `UIEdgeInsets` with a top and right inset.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - right: The inset for the right edge.
  public init(top: CGFloat, right: CGFloat) {
    self.init(top: top, left: 0, bottom: 0, right: right)
  }

  /// Initializes `UIEdgeInsets` with a top, left, and bottom inset.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - left: The inset for the left edge.
  ///   - bottom: The inset for the bottom edge.
  public init(top: CGFloat, left: CGFloat, bottom: CGFloat) {
    self.init(top: top, left: left, bottom: bottom, right: 0)
  }

  /// Initializes `UIEdgeInsets` with a top, left, and right inset.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - left: The inset for the left edge.
  ///   - right: The inset for the right edge.
  public init(top: CGFloat, left: CGFloat, right: CGFloat) {
    self.init(top: top, left: left, bottom: 0, right: right)
  }

  /// Initializes `UIEdgeInsets` with a left inset and zero for all other sides.
  ///
  /// - Parameter left: The inset for the left edge.
  public init(left: CGFloat) {
    self.init(top: 0, left: left, bottom: 0, right: 0)
  }

  /// Initializes `UIEdgeInsets` with a left and bottom inset.
  ///
  /// - Parameters:
  ///   - left: The inset for the left edge.
  ///   - bottom: The inset for the bottom edge.
  public init(left: CGFloat, bottom: CGFloat) {
    self.init(top: 0, left: left, bottom: bottom, right: 0)
  }

  /// Initializes `UIEdgeInsets` with a left and right inset.
  ///
  /// - Parameters:
  ///   - left: The inset for the left edge.
  ///   - right: The inset for the right edge.
  public init(left: CGFloat, right: CGFloat) {
    self.init(top: 0, left: left, bottom: 0, right: right)
  }

  /// Initializes `UIEdgeInsets` with left, bottom, and right insets.
  ///
  /// - Parameters:
  ///   - left: The inset for the left edge.
  ///   - bottom: The inset for the bottom edge.
  ///   - right: The inset for the right edge.
  public init(left: CGFloat, bottom: CGFloat, right: CGFloat) {
    self.init(top: 0, left: left, bottom: bottom, right: right)
  }

  /// Initializes `UIEdgeInsets` with a bottom inset and zero for all other sides.
  ///
  /// - Parameter bottom: The inset for the bottom edge.
  public init(bottom: CGFloat) {
    self.init(top: 0, left: 0, bottom: bottom, right: 0)
  }

  /// Initializes `UIEdgeInsets` with a bottom and right inset.
  ///
  /// - Parameters:
  ///   - bottom: The inset for the bottom edge.
  ///   - right: The inset for the right edge.
  public init(bottom: CGFloat, right: CGFloat) {
    self.init(top: 0, left: 0, bottom: bottom, right: right)
  }

  /// Initializes `UIEdgeInsets` with a right inset and zero for all other sides.
  ///
  /// - Parameter right: The inset for the right edge.
  public init(right: CGFloat) {
    self.init(top: 0, left: 0, bottom: 0, right: right)
  }

  /// Initializes `UIEdgeInsets` with the same inset for both horizontal edges.
  ///
  /// - Parameter horizontal: The inset for both `left` and `right` edges.
  public init(horizontal: CGFloat) {
    self.init(top: 0, left: horizontal, bottom: 0, right: horizontal)
  }

  /// Initializes `UIEdgeInsets` with the same inset for both vertical edges.
  ///
  /// - Parameter vertical: The inset for both `top` and `bottom` edges.
  public init(vertical: CGFloat) {
    self.init(top: vertical, left: 0, bottom: vertical, right: 0)
  }

  /// Initializes `UIEdgeInsets` with the same horizontal and vertical insets.
  ///
  /// - Parameters:
  ///   - horizontal: The inset for both `left` and `right` edges.
  ///   - vertical: The inset for both `top` and `bottom` edges.
  public init(horizontal: CGFloat, vertical: CGFloat) {
    self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
  }

  /// Initializes `UIEdgeInsets` with the same inset for all edges.
  ///
  /// - Parameter inset: The inset for `top`, `left`, `bottom`, and `right`.
  public init(_ inset: CGFloat) {
    self.init(top: inset, left: inset, bottom: inset, right: inset)
  }

  /// Adds two `UIEdgeInsets` values element-wise.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side `UIEdgeInsets`.
  ///   - rhs: The right-hand side `UIEdgeInsets`.
  /// - Returns: A `UIEdgeInsets` where each side is the sum of the corresponding sides of `lhs` and `rhs`.
  @inlinable public static func + (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
    lhs.appending(rhs)
  }

  /// Subtracts the right-hand side `UIEdgeInsets` from the left-hand side element-wise.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side `UIEdgeInsets`.
  ///   - rhs: The right-hand side `UIEdgeInsets`.
  /// - Returns: A `UIEdgeInsets` where each side is the result of subtracting the corresponding sides of `rhs` from `lhs`.
  @inlinable public static func - (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
    lhs.subtracting(rhs)
  }

  /// Multiplies each side of a `UIEdgeInsets` by a scalar value of type `CGFloat`.
  ///
  /// - Parameters:
  ///   - lhs: The `UIEdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `CGFloat`.
  /// - Returns: A `UIEdgeInsets` where each side is multiplied by `rhs`.
  @inlinable public static func * (lhs: UIEdgeInsets, rhs: CGFloat) -> UIEdgeInsets {
    lhs.multiplying(rhs)
  }

  /// Multiplies each side of a `UIEdgeInsets` by a scalar value of type `Float`.
  ///
  /// - Parameters:
  ///   - lhs: The `UIEdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `Float`.
  /// - Returns: A `UIEdgeInsets` where each side is multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: UIEdgeInsets, rhs: Float) -> UIEdgeInsets {
    lhs.multiplying(CGFloat(rhs))
  }

  /// Multiplies each side of a `UIEdgeInsets` by a scalar value of type `Double`.
  ///
  /// - Parameters:
  ///   - lhs: The `UIEdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `Double`.
  /// - Returns: A `UIEdgeInsets` where each side is multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: UIEdgeInsets, rhs: Double) -> UIEdgeInsets {
    lhs.multiplying(CGFloat(rhs))
  }

  /// Multiplies each side of a `UIEdgeInsets` by a scalar value of type `Int`.
  ///
  /// - Parameters:
  ///   - lhs: The `UIEdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `Int`.
  /// - Returns: A `UIEdgeInsets` where each side is multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: UIEdgeInsets, rhs: Int) -> UIEdgeInsets {
    lhs.multiplying(CGFloat(rhs))
  }

  /// Negates each side of the `UIEdgeInsets`, reversing the sign of each inset value.
  ///
  /// - Parameter insets: The `UIEdgeInsets` to negate.
  /// - Returns: A `UIEdgeInsets` where each side is negated.
  @inlinable public static prefix func - (insets: UIEdgeInsets) -> UIEdgeInsets {
    insets.negate
  }

  /// Rounds each side of the `UIEdgeInsets` according to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
  @inlinable public mutating func round(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) {
    self = rounded(rule)
  }

  /// Rounds each side of the `UIEdgeInsets` according to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
  /// - Returns: A new `UIEdgeInsets` with the rounded values for each side.
  @inlinable public func rounded(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> UIEdgeInsets {
    UIEdgeInsets(
      top: top.rounded(rule),
      left: left.rounded(rule),
      bottom: bottom.rounded(rule),
      right: right.rounded(rule)
    )
  }

  /// Appends the given insets to the current `UIEdgeInsets`.
  ///
  /// - Parameter insets: The `UIEdgeInsets` to add.
  /// - Mutates: The current `UIEdgeInsets` by adding the corresponding values of `insets`.
  @inlinable public mutating func append(_ insets: UIEdgeInsets) {
    self = appending(insets)
  }

  /// Adds the given insets to the current `UIEdgeInsets`.
  ///
  /// - Parameter insets: The `UIEdgeInsets` to add.
  /// - Returns: A new `UIEdgeInsets` with the values of `insets` added to the corresponding sides.
  @inlinable public func appending(_ insets: UIEdgeInsets) -> UIEdgeInsets {
    UIEdgeInsets(
      top: top + insets.top,
      left: left + insets.left,
      bottom: bottom + insets.bottom,
      right: right + insets.right
    )
  }

  /// Subtracts the given insets from the current `UIEdgeInsets`.
  ///
  /// - Parameter insets: The `UIEdgeInsets` to subtract.
  /// - Mutates: The current `UIEdgeInsets` by subtracting the corresponding values of `insets`.
  @inlinable public mutating func subtract(_ insets: UIEdgeInsets) {
    self = subtracting(insets)
  }

  /// Subtracts the given insets from the current `UIEdgeInsets`.
  ///
  /// - Parameter insets: The `UIEdgeInsets` to subtract.
  /// - Returns: A new `UIEdgeInsets` with the values of `insets` subtracted from the corresponding sides.
  @inlinable public func subtracting(_ insets: UIEdgeInsets) -> UIEdgeInsets {
    UIEdgeInsets(
      top: top - insets.top,
      left: left - insets.left,
      bottom: bottom - insets.bottom,
      right: right - insets.right
    )
  }

  /// Multiplies each side of the `UIEdgeInsets` by the given `CGFloat` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `UIEdgeInsets` by multiplying each side by `factor`.
  @inlinable public mutating func multiply(_ factor: CGFloat) {
    self = multiplying(factor)
  }

  /// Multiplies each side of the `UIEdgeInsets` by the given `Float` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `UIEdgeInsets` by multiplying each side by `CGFloat(factor)`.
  @inlinable public mutating func multiply(_ factor: Float) {
    self = multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the `UIEdgeInsets` by the given `Double` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `UIEdgeInsets` by multiplying each side by `CGFloat(factor)`.
  @inlinable public mutating func multiply(_ factor: Double) {
    self = multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the `UIEdgeInsets` by the given `Int` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `UIEdgeInsets` by multiplying each side by `CGFloat(factor)`.
  @inlinable public mutating func multiply(_ factor: Int) {
    self = multiplying(CGFloat(factor))
  }

  /// Returns a new `UIEdgeInsets` where each side is multiplied by the given `CGFloat` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `UIEdgeInsets` with each side multiplied by `factor`.
  @inlinable public func multiplying(_ factor: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(
      top: top * factor,
      left: left * factor,
      bottom: bottom * factor,
      right: right * factor
    )
  }

  /// Returns a new `UIEdgeInsets` where each side is multiplied by the given `Float` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `UIEdgeInsets` with each side multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Float) -> UIEdgeInsets {
    multiplying(CGFloat(factor))
  }

  /// Returns a new `UIEdgeInsets` where each side is multiplied by the given `Double` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `UIEdgeInsets` with each side multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Double) -> UIEdgeInsets {
    multiplying(CGFloat(factor))
  }

  /// Returns a new `UIEdgeInsets` where each side is multiplied by the given `Int` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `UIEdgeInsets` with each side multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Int) -> UIEdgeInsets {
    multiplying(CGFloat(factor))
  }
}

// MARK: - NSDirectionalEdgeInsets

extension NSDirectionalEdgeInsets {
  /// The combined vertical insets (`top + bottom`).
  @inlinable public var vertical: CGFloat { top + bottom }

  /// The combined horizontal insets (`leading + trailing`).
  @inlinable public var horizontal: CGFloat { leading + trailing }

  /// Negates the insets, flipping the sign of each side.
  @inlinable public var negate: NSDirectionalEdgeInsets {
    NSDirectionalEdgeInsets(top: -top, leading: -leading, bottom: -bottom, trailing: -trailing)
  }

  /// Initializes `NSDirectionalEdgeInsets` with a top inset and zero for all other sides.
  ///
  /// - Parameter top: The inset for the top edge.
  public init(top: CGFloat) {
    self.init(top: top, leading: 0, bottom: 0, trailing: 0)
  }

  /// Initializes `NSDirectionalEdgeInsets` with a top and leading inset.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - leading: The inset for the leading edge.
  public init(top: CGFloat, leading: CGFloat) {
    self.init(top: top, leading: leading, bottom: 0, trailing: 0)
  }

  /// Initializes `NSDirectionalEdgeInsets` with a top and bottom inset.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - bottom: The inset for the bottom edge.
  public init(top: CGFloat, bottom: CGFloat) {
    self.init(top: top, leading: 0, bottom: bottom, trailing: 0)
  }

  /// Initializes `NSDirectionalEdgeInsets` with a top and trailing inset.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - trailing: The inset for the trailing edge.
  public init(top: CGFloat, trailing: CGFloat) {
    self.init(top: top, leading: 0, bottom: 0, trailing: trailing)
  }

  /// Initializes `NSDirectionalEdgeInsets` with a top, leading, and bottom inset.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - leading: The inset for the leading edge.
  ///   - bottom: The inset for the bottom edge.
  public init(top: CGFloat, leading: CGFloat, bottom: CGFloat) {
    self.init(top: top, leading: leading, bottom: bottom, trailing: 0)
  }

  /// Initializes `NSDirectionalEdgeInsets` with a top, leading, and trailing inset.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - leading: The inset for the leading edge.
  ///   - trailing: The inset for the trailing edge.
  public init(top: CGFloat, leading: CGFloat, trailing: CGFloat) {
    self.init(top: top, leading: leading, bottom: 0, trailing: trailing)
  }

  /// Initializes `NSDirectionalEdgeInsets` with only the leading inset.
  ///
  /// - Parameter leading: The inset for the leading edge.
  public init(leading: CGFloat) {
    self.init(top: 0, leading: leading, bottom: 0, trailing: 0)
  }

  /// Initializes `NSDirectionalEdgeInsets` with leading and bottom insets.
  ///
  /// - Parameters:
  ///   - leading: The inset for the leading edge.
  ///   - bottom: The inset for the bottom edge.
  public init(leading: CGFloat, bottom: CGFloat) {
    self.init(top: 0, leading: leading, bottom: bottom, trailing: 0)
  }

  /// Initializes `NSDirectionalEdgeInsets` with leading and trailing insets.
  ///
  /// - Parameters:
  ///   - leading: The inset for the leading edge.
  ///   - trailing: The inset for the trailing edge.
  public init(leading: CGFloat, trailing: CGFloat) {
    self.init(top: 0, leading: leading, bottom: 0, trailing: trailing)
  }

  /// Initializes `NSDirectionalEdgeInsets` with leading, bottom, and trailing insets.
  ///
  /// - Parameters:
  ///   - leading: The inset for the leading edge.
  ///   - bottom: The inset for the bottom edge.
  ///   - trailing: The inset for the trailing edge.
  public init(leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
    self.init(top: 0, leading: leading, bottom: bottom, trailing: trailing)
  }

  /// Initializes `NSDirectionalEdgeInsets` with only the bottom inset.
  ///
  /// - Parameter bottom: The inset for the bottom edge.
  public init(bottom: CGFloat) {
    self.init(top: 0, leading: 0, bottom: bottom, trailing: 0)
  }

  /// Initializes `NSDirectionalEdgeInsets` with bottom and trailing insets.
  ///
  /// - Parameters:
  ///   - bottom: The inset for the bottom edge.
  ///   - trailing: The inset for the trailing edge.
  public init(bottom: CGFloat, trailing: CGFloat) {
    self.init(top: 0, leading: 0, bottom: bottom, trailing: trailing)
  }

  /// Initializes `NSDirectionalEdgeInsets` with only the trailing inset.
  ///
  /// - Parameter trailing: The inset for the trailing edge.
  public init(trailing: CGFloat) {
    self.init(top: 0, leading: 0, bottom: 0, trailing: trailing)
  }

  /// Initializes `NSDirectionalEdgeInsets` with the same horizontal inset for both `leading` and `trailing`.
  ///
  /// - Parameter horizontal: The inset for both the `leading` and `trailing` edges.
  public init(horizontal: CGFloat) {
    self.init(top: 0, leading: horizontal, bottom: 0, trailing: horizontal)
  }

  /// Initializes `NSDirectionalEdgeInsets` with the same vertical inset for both `top` and `bottom`.
  ///
  /// - Parameter vertical: The inset for both the `top` and `bottom` edges.
  public init(vertical: CGFloat) {
    self.init(top: vertical, leading: 0, bottom: vertical, trailing: 0)
  }

  /// Initializes `NSDirectionalEdgeInsets` with both horizontal and vertical insets.
  ///
  /// - Parameters:
  ///   - horizontal: The inset for both the `leading` and `trailing` edges.
  ///   - vertical: The inset for both the `top` and `bottom` edges.
  public init(horizontal: CGFloat, vertical: CGFloat) {
    self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
  }

  /// Initializes `NSDirectionalEdgeInsets` with the same inset value for all edges.
  ///
  /// - Parameter inset: The inset to apply to `top`, `leading`, `bottom`, and `trailing`.
  public init(_ inset: CGFloat) {
    self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
  }

  /// Adds two `NSDirectionalEdgeInsets` values element-wise.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side `NSDirectionalEdgeInsets`.
  ///   - rhs: The right-hand side `NSDirectionalEdgeInsets`.
  /// - Returns: A `NSDirectionalEdgeInsets` where each side is the sum of the corresponding sides of `lhs` and `rhs`.
  @inlinable public static func + (lhs: NSDirectionalEdgeInsets, rhs: NSDirectionalEdgeInsets) -> NSDirectionalEdgeInsets {
    lhs.appending(rhs)
  }

  /// Subtracts the right-hand side `NSDirectionalEdgeInsets` from the left-hand side element-wise.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side `NSDirectionalEdgeInsets`.
  ///   - rhs: The right-hand side `NSDirectionalEdgeInsets`.
  /// - Returns: A `NSDirectionalEdgeInsets` where each side is the result of subtracting the corresponding sides of `rhs` from `lhs`.
  @inlinable public static func - (lhs: NSDirectionalEdgeInsets, rhs: NSDirectionalEdgeInsets) -> NSDirectionalEdgeInsets {
    lhs.subtracting(rhs)
  }

  /// Multiplies each side of a `NSDirectionalEdgeInsets` by a scalar value of type `CGFloat`.
  ///
  /// - Parameters:
  ///   - lhs: The `NSDirectionalEdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `CGFloat`.
  /// - Returns: A `NSDirectionalEdgeInsets` where each side is multiplied by `rhs`.
  @inlinable public static func * (lhs: NSDirectionalEdgeInsets, rhs: CGFloat) -> NSDirectionalEdgeInsets {
    lhs.multiplying(rhs)
  }

  /// Multiplies each side of a `NSDirectionalEdgeInsets` by a scalar value of type `Float`.
  ///
  /// - Parameters:
  ///   - lhs: The `NSDirectionalEdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `Float`.
  /// - Returns: A `NSDirectionalEdgeInsets` where each side is multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: NSDirectionalEdgeInsets, rhs: Float) -> NSDirectionalEdgeInsets {
    lhs.multiplying(CGFloat(rhs))
  }

  /// Multiplies each side of a `NSDirectionalEdgeInsets` by a scalar value of type `Double`.
  ///
  /// - Parameters:
  ///   - lhs: The `NSDirectionalEdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `Double`.
  /// - Returns: A `NSDirectionalEdgeInsets` where each side is multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: NSDirectionalEdgeInsets, rhs: Double) -> NSDirectionalEdgeInsets {
    lhs.multiplying(CGFloat(rhs))
  }

  /// Multiplies each side of a `NSDirectionalEdgeInsets` by a scalar value of type `Int`.
  ///
  /// - Parameters:
  ///   - lhs: The `NSDirectionalEdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `Int`.
  /// - Returns: A `NSDirectionalEdgeInsets` where each side is multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: NSDirectionalEdgeInsets, rhs: Int) -> NSDirectionalEdgeInsets {
    lhs.multiplying(CGFloat(rhs))
  }

  /// Negates the insets, flipping the sign of each side.
  ///
  /// - Parameter insets: The `NSDirectionalEdgeInsets` to negate.
  /// - Returns: A `NSDirectionalEdgeInsets` where each side is negated.
  @inlinable public static prefix func - (insets: NSDirectionalEdgeInsets) -> NSDirectionalEdgeInsets {
    insets.negate
  }

  /// Rounds each side of the `NSDirectionalEdgeInsets` according to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
  /// - Mutates: The current `NSDirectionalEdgeInsets` by rounding each side according to the rule.
  @inlinable public mutating func round(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) {
    self = rounded(rule)
  }

  /// Rounds each side of the `NSDirectionalEdgeInsets` according to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
  /// - Returns: A new `NSDirectionalEdgeInsets` where each side is rounded according to the rule.
  @inlinable public func rounded(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> NSDirectionalEdgeInsets {
    NSDirectionalEdgeInsets(
      top: top.rounded(rule),
      leading: leading.rounded(rule),
      bottom: bottom.rounded(rule),
      trailing: trailing.rounded(rule)
    )
  }

  /// Adds the given insets to the current `NSDirectionalEdgeInsets`.
  ///
  /// - Parameter insets: The `NSDirectionalEdgeInsets` to add.
  /// - Mutates: The current `NSDirectionalEdgeInsets` by adding the corresponding values of `insets` to each side.
  @inlinable public mutating func append(_ insets: NSDirectionalEdgeInsets) {
    self = appending(insets)
  }

  /// Adds the given insets to the current `NSDirectionalEdgeInsets`.
  ///
  /// - Parameter insets: The `NSDirectionalEdgeInsets` to add.
  /// - Returns: A new `NSDirectionalEdgeInsets` where the corresponding values of `insets` are added to each side.
  @inlinable public func appending(_ insets: NSDirectionalEdgeInsets) -> NSDirectionalEdgeInsets {
    NSDirectionalEdgeInsets(
      top: top + insets.top,
      leading: leading + insets.leading,
      bottom: bottom + insets.bottom,
      trailing: trailing + insets.trailing
    )
  }

  /// Subtracts the given insets from the current `NSDirectionalEdgeInsets`.
  ///
  /// - Parameter insets: The `NSDirectionalEdgeInsets` to subtract.
  /// - Mutates: The current `NSDirectionalEdgeInsets` by subtracting the corresponding values of `insets` from each side.
  @inlinable public mutating func subtract(_ insets: NSDirectionalEdgeInsets) {
    self = subtracting(insets)
  }

  /// Subtracts the given insets from the current `NSDirectionalEdgeInsets`.
  ///
  /// - Parameter insets: The `NSDirectionalEdgeInsets` to subtract.
  /// - Returns: A new `NSDirectionalEdgeInsets` where the corresponding values of `insets` are subtracted from each side.
  @inlinable public func subtracting(_ insets: NSDirectionalEdgeInsets) -> NSDirectionalEdgeInsets {
    NSDirectionalEdgeInsets(
      top: top - insets.top,
      leading: leading - insets.leading,
      bottom: bottom - insets.bottom,
      trailing: trailing - insets.trailing
    )
  }

  /// Multiplies each side of the current `NSDirectionalEdgeInsets` by the given `CGFloat` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `NSDirectionalEdgeInsets` by multiplying each side by `factor`.
  @inlinable public mutating func multiply(_ factor: CGFloat) {
    self = multiplying(factor)
  }

  /// Multiplies each side of the current `NSDirectionalEdgeInsets` by the given `Float` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `NSDirectionalEdgeInsets` by multiplying each side by `CGFloat(factor)`.
  @inlinable public mutating func multiply(_ factor: Float) {
    self = multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the current `NSDirectionalEdgeInsets` by the given `Double` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `NSDirectionalEdgeInsets` by multiplying each side by `CGFloat(factor)`.
  @inlinable public mutating func multiply(_ factor: Double) {
    self = multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the current `NSDirectionalEdgeInsets` by the given `Int` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `NSDirectionalEdgeInsets` by multiplying each side by `CGFloat(factor)`.
  @inlinable public mutating func multiply(_ factor: Int) {
    self = multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the `NSDirectionalEdgeInsets` by the given `CGFloat` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `NSDirectionalEdgeInsets` where each side is multiplied by `factor`.
  @inlinable public func multiplying(_ factor: CGFloat) -> NSDirectionalEdgeInsets {
    NSDirectionalEdgeInsets(
      top: top * factor,
      leading: leading * factor,
      bottom: bottom * factor,
      trailing: trailing * factor
    )
  }

  /// Multiplies each side of the `NSDirectionalEdgeInsets` by the given `Float` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `NSDirectionalEdgeInsets` where each side is multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Float) -> NSDirectionalEdgeInsets {
    multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the `NSDirectionalEdgeInsets` by the given `Double` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `NSDirectionalEdgeInsets` where each side is multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Double) -> NSDirectionalEdgeInsets {
    multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the `NSDirectionalEdgeInsets` by the given `Int` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `NSDirectionalEdgeInsets` where each side is multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Int) -> NSDirectionalEdgeInsets {
    multiplying(CGFloat(factor))
  }
}

// MARK: - EdgeInsets

extension EdgeInsets {
  /// The combined vertical insets (`top + bottom`).
  @inlinable public var vertical: CGFloat { top + bottom }

  /// The combined horizontal insets (`leading + trailing`).
  @inlinable public var horizontal: CGFloat { leading + trailing }

  /// Negates the insets, flipping the sign of each side.
  @inlinable public var negate: EdgeInsets {
    EdgeInsets(top: -top, leading: -leading, bottom: -bottom, trailing: -trailing)
  }

  /// Initializes `EdgeInsets` with a top inset and zero for all other sides.
  ///
  /// - Parameter top: The inset for the top edge.
  public init(top: CGFloat) {
    self.init(top: top, leading: 0, bottom: 0, trailing: 0)
  }

  /// Initializes `EdgeInsets` with top and leading insets.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - leading: The inset for the leading edge.
  public init(top: CGFloat, leading: CGFloat) {
    self.init(top: top, leading: leading, bottom: 0, trailing: 0)
  }

  /// Initializes `EdgeInsets` with top and bottom insets.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - bottom: The inset for the bottom edge.
  public init(top: CGFloat, bottom: CGFloat) {
    self.init(top: top, leading: 0, bottom: bottom, trailing: 0)
  }

  /// Initializes `EdgeInsets` with top and trailing insets.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - trailing: The inset for the trailing edge.
  public init(top: CGFloat, trailing: CGFloat) {
    self.init(top: top, leading: 0, bottom: 0, trailing: trailing)
  }

  /// Initializes `EdgeInsets` with top, leading, and bottom insets.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - leading: The inset for the leading edge.
  ///   - bottom: The inset for the bottom edge.
  public init(top: CGFloat, leading: CGFloat, bottom: CGFloat) {
    self.init(top: top, leading: leading, bottom: bottom, trailing: 0)
  }

  /// Initializes `EdgeInsets` with top, leading, and trailing insets.
  ///
  /// - Parameters:
  ///   - top: The inset for the top edge.
  ///   - leading: The inset for the leading edge.
  ///   - trailing: The inset for the trailing edge.
  public init(top: CGFloat, leading: CGFloat, trailing: CGFloat) {
    self.init(top: top, leading: leading, bottom: 0, trailing: trailing)
  }

  /// Initializes `EdgeInsets` with only the leading inset.
  ///
  /// - Parameter leading: The inset for the leading edge.
  public init(leading: CGFloat) {
    self.init(top: 0, leading: leading, bottom: 0, trailing: 0)
  }

  /// Initializes `EdgeInsets` with leading and bottom insets.
  ///
  /// - Parameters:
  ///   - leading: The inset for the leading edge.
  ///   - bottom: The inset for the bottom edge.
  public init(leading: CGFloat, bottom: CGFloat) {
    self.init(top: 0, leading: leading, bottom: bottom, trailing: 0)
  }

  /// Initializes `EdgeInsets` with leading and trailing insets.
  ///
  /// - Parameters:
  ///   - leading: The inset for the leading edge.
  ///   - trailing: The inset for the trailing edge.
  public init(leading: CGFloat, trailing: CGFloat) {
    self.init(top: 0, leading: leading, bottom: 0, trailing: trailing)
  }

  /// Initializes `EdgeInsets` with leading, bottom, and trailing insets.
  ///
  /// - Parameters:
  ///   - leading: The inset for the leading edge.
  ///   - bottom: The inset for the bottom edge.
  ///   - trailing: The inset for the trailing edge.
  public init(leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
    self.init(top: 0, leading: leading, bottom: bottom, trailing: trailing)
  }

  /// Initializes `EdgeInsets` with only the bottom inset.
  ///
  /// - Parameter bottom: The inset for the bottom edge.
  public init(bottom: CGFloat) {
    self.init(top: 0, leading: 0, bottom: bottom, trailing: 0)
  }

  /// Initializes `EdgeInsets` with bottom and trailing insets.
  ///
  /// - Parameters:
  ///   - bottom: The inset for the bottom edge.
  ///   - trailing: The inset for the trailing edge.
  public init(bottom: CGFloat, trailing: CGFloat) {
    self.init(top: 0, leading: 0, bottom: bottom, trailing: trailing)
  }

  /// Initializes `EdgeInsets` with only the trailing inset.
  ///
  /// - Parameter trailing: The inset for the trailing edge.
  public init(trailing: CGFloat) {
    self.init(top: 0, leading: 0, bottom: 0, trailing: trailing)
  }

  /// Initializes `EdgeInsets` with the same inset for both horizontal edges (`leading` and `trailing`).
  ///
  /// - Parameter horizontal: The inset for both `leading` and `trailing` edges.
  public init(horizontal: CGFloat) {
    self.init(top: 0, leading: horizontal, bottom: 0, trailing: horizontal)
  }

  /// Initializes `EdgeInsets` with the same inset for both vertical edges (`top` and `bottom`).
  ///
  /// - Parameter vertical: The inset for both `top` and `bottom` edges.
  public init(vertical: CGFloat) {
    self.init(top: vertical, leading: 0, bottom: vertical, trailing: 0)
  }

  /// Initializes `EdgeInsets` with the same horizontal and vertical insets.
  ///
  /// - Parameters:
  ///   - horizontal: The inset for both `leading` and `trailing` edges.
  ///   - vertical: The inset for both `top` and `bottom` edges.
  public init(horizontal: CGFloat, vertical: CGFloat) {
    self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
  }

  /// Initializes `EdgeInsets` with the same inset value for all edges.
  ///
  /// - Parameter inset: The inset for `top`, `leading`, `bottom`, and `trailing` edges.
  public init(_ inset: CGFloat) {
    self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
  }

  /// Adds two `EdgeInsets` values element-wise.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side `EdgeInsets`.
  ///   - rhs: The right-hand side `EdgeInsets`.
  /// - Returns: A new `EdgeInsets` where each side is the sum of the corresponding sides of `lhs` and `rhs`.
  @inlinable public static func + (lhs: EdgeInsets, rhs: EdgeInsets) -> EdgeInsets {
      lhs.appending(rhs)
  }

  /// Subtracts the right-hand side `EdgeInsets` from the left-hand side element-wise.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side `EdgeInsets`.
  ///   - rhs: The right-hand side `EdgeInsets`.
  /// - Returns: A new `EdgeInsets` where each side is the result of subtracting the corresponding sides of `rhs` from `lhs`.
  @inlinable public static func - (lhs: EdgeInsets, rhs: EdgeInsets) -> EdgeInsets {
      lhs.subtracting(rhs)
  }

  /// Multiplies each side of a `EdgeInsets` by a scalar value of type `CGFloat`.
  ///
  /// - Parameters:
  ///   - lhs: The `EdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `CGFloat`.
  /// - Returns: A new `EdgeInsets` where each side is multiplied by `rhs`.
  @inlinable public static func * (lhs: EdgeInsets, rhs: CGFloat) -> EdgeInsets {
      lhs.multiplying(rhs)
  }

  /// Multiplies each side of a `EdgeInsets` by a scalar value of type `Float`.
  ///
  /// - Parameters:
  ///   - lhs: The `EdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `Float`.
  /// - Returns: A new `EdgeInsets` where each side is multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: EdgeInsets, rhs: Float) -> EdgeInsets {
      lhs.multiplying(CGFloat(rhs))
  }

  /// Multiplies each side of a `EdgeInsets` by a scalar value of type `Double`.
  ///
  /// - Parameters:
  ///   - lhs: The `EdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `Double`.
  /// - Returns: A new `EdgeInsets` where each side is multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: EdgeInsets, rhs: Double) -> EdgeInsets {
      lhs.multiplying(CGFloat(rhs))
  }

  /// Multiplies each side of a `EdgeInsets` by a scalar value of type `Int`.
  ///
  /// - Parameters:
  ///   - lhs: The `EdgeInsets` to be multiplied.
  ///   - rhs: The scalar value of type `Int`.
  /// - Returns: A new `EdgeInsets` where each side is multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: EdgeInsets, rhs: Int) -> EdgeInsets {
      lhs.multiplying(CGFloat(rhs))
  }

  /// Negates each side of the `EdgeInsets`, flipping the sign of each inset value.
  ///
  /// - Parameter insets: The `EdgeInsets` to negate.
  /// - Returns: A new `EdgeInsets` where each side is negated.
  @inlinable public static prefix func - (insets: EdgeInsets) -> EdgeInsets {
      insets.negate
  }

  /// Rounds each side of the `EdgeInsets` according to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
  /// - Mutates: The current `EdgeInsets` by rounding each side according to the rule.
  @inlinable public mutating func round(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) {
      self = rounded(rule)
  }

  /// Rounds each side of the `EdgeInsets` according to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
  /// - Returns: A new `EdgeInsets` where each side is rounded according to the rule.
  @inlinable public func rounded(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> EdgeInsets {
      EdgeInsets(
          top: top.rounded(rule),
          leading: leading.rounded(rule),
          bottom: bottom.rounded(rule),
          trailing: trailing.rounded(rule)
      )
  }

  /// Adds the given insets to the current `EdgeInsets`.
  ///
  /// - Parameter insets: The `EdgeInsets` to add.
  /// - Mutates: The current `EdgeInsets` by adding the corresponding values of `insets` to each side.
  @inlinable public mutating func append(_ insets: EdgeInsets) {
      self = appending(insets)
  }

  /// Adds the given insets to the current `EdgeInsets`.
  ///
  /// - Parameter insets: The `EdgeInsets` to add.
  /// - Returns: A new `EdgeInsets` where the corresponding values of `insets` are added to each side.
  @inlinable public func appending(_ insets: EdgeInsets) -> EdgeInsets {
      EdgeInsets(
          top: top + insets.top,
          leading: leading + insets.leading,
          bottom: bottom + insets.bottom,
          trailing: trailing + insets.trailing
      )
  }

  /// Subtracts the given insets from the current `EdgeInsets`.
  ///
  /// - Parameter insets: The `EdgeInsets` to subtract.
  /// - Mutates: The current `EdgeInsets` by subtracting the corresponding values of `insets` from each side.
  @inlinable public mutating func subtract(_ insets: EdgeInsets) {
      self = subtracting(insets)
  }

  /// Subtracts the given insets from the current `EdgeInsets`.
  ///
  /// - Parameter insets: The `EdgeInsets` to subtract.
  /// - Returns: A new `EdgeInsets` where the corresponding values of `insets` are subtracted from each side.
  @inlinable public func subtracting(_ insets: EdgeInsets) -> EdgeInsets {
      EdgeInsets(
          top: top - insets.top,
          leading: leading - insets.leading,
          bottom: bottom - insets.bottom,
          trailing: trailing - insets.trailing
      )
  }

  /// Multiplies each side of the current `EdgeInsets` by the given `CGFloat` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `EdgeInsets` by multiplying each side by `factor`.
  @inlinable public mutating func multiply(_ factor: CGFloat) {
      self = multiplying(factor)
  }

  /// Multiplies each side of the current `EdgeInsets` by the given `Float` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `EdgeInsets` by multiplying each side by `CGFloat(factor)`.
  @inlinable public mutating func multiply(_ factor: Float) {
      self = multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the current `EdgeInsets` by the given `Double` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `EdgeInsets` by multiplying each side by `CGFloat(factor)`.
  @inlinable public mutating func multiply(_ factor: Double) {
      self = multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the current `EdgeInsets` by the given `Int` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Mutates: The current `EdgeInsets` by multiplying each side by `CGFloat(factor)`.
  @inlinable public mutating func multiply(_ factor: Int) {
      self = multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the `EdgeInsets` by the given `CGFloat` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `EdgeInsets` where each side is multiplied by `factor`.
  @inlinable public func multiplying(_ factor: CGFloat) -> EdgeInsets {
      EdgeInsets(
          top: top * factor,
          leading: leading * factor,
          bottom: bottom * factor,
          trailing: trailing * factor
      )
  }

  /// Multiplies each side of the `EdgeInsets` by the given `Float` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `EdgeInsets` where each side is multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Float) -> EdgeInsets {
      multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the `EdgeInsets` by the given `Double` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `EdgeInsets` where each side is multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Double) -> EdgeInsets {
      multiplying(CGFloat(factor))
  }

  /// Multiplies each side of the `EdgeInsets` by the given `Int` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply each side.
  /// - Returns: A new `EdgeInsets` where each side is multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Int) -> EdgeInsets {
      multiplying(CGFloat(factor))
  }
}

// MARK: - CGSize

extension CGSize {
  /// Negates the width and height of the `CGSize`.
  @inlinable public var negate: CGSize {
      CGSize(width: -width, height: -height)
  }

  /// Adds two `CGSize` values element-wise.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side `CGSize`.
  ///   - rhs: The right-hand side `CGSize`.
  /// - Returns: A new `CGSize` where `width` and `height` are the sum of the corresponding dimensions of `lhs` and `rhs`.
  @inlinable public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
      lhs.appending(rhs)
  }

  /// Subtracts the right-hand side `CGSize` from the left-hand side element-wise.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side `CGSize`.
  ///   - rhs: The right-hand side `CGSize`.
  /// - Returns: A new `CGSize` where `width` and `height` are the result of subtracting the corresponding dimensions of `rhs` from `lhs`.
  @inlinable public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
      lhs.subtracting(rhs)
  }

  /// Multiplies each dimension of `CGSize` by a scalar value of type `CGFloat`.
  ///
  /// - Parameters:
  ///   - lhs: The `CGSize` to be multiplied.
  ///   - rhs: The scalar value of type `CGFloat`.
  /// - Returns: A new `CGSize` where `width` and `height` are multiplied by `rhs`.
  @inlinable public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
      lhs.multiplying(rhs)
  }

  /// Multiplies each dimension of `CGSize` by a scalar value of type `Float`.
  ///
  /// - Parameters:
  ///   - lhs: The `CGSize` to be multiplied.
  ///   - rhs: The scalar value of type `Float`.
  /// - Returns: A new `CGSize` where `width` and `height` are multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: CGSize, rhs: Float) -> CGSize {
      lhs.multiplying(CGFloat(rhs))
  }

  /// Multiplies each dimension of `CGSize` by a scalar value of type `Double`.
  ///
  /// - Parameters:
  ///   - lhs: The `CGSize` to be multiplied.
  ///   - rhs: The scalar value of type `Double`.
  /// - Returns: A new `CGSize` where `width` and `height` are multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: CGSize, rhs: Double) -> CGSize {
      lhs.multiplying(CGFloat(rhs))
  }

  /// Multiplies each dimension of `CGSize` by a scalar value of type `Int`.
  ///
  /// - Parameters:
  ///   - lhs: The `CGSize` to be multiplied.
  ///   - rhs: The scalar value of type `Int`.
  /// - Returns: A new `CGSize` where `width` and `height` are multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: CGSize, rhs: Int) -> CGSize {
      lhs.multiplying(CGFloat(rhs))
  }

  /// Negates the `CGSize`, flipping the sign of `width` and `height`.
  ///
  /// - Parameter size: The `CGSize` to negate.
  /// - Returns: A new `CGSize` where `width` and `height` are negated.
  @inlinable public static prefix func - (size: CGSize) -> CGSize {
      size.negate
  }

  /// Rounds each dimension of the `CGSize` according to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
  /// - Mutates: The current `CGSize` by rounding `width` and `height` according to the rule.
  @inlinable public mutating func round(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) {
      self = rounded(rule)
  }

  /// Rounds each dimension of the `CGSize` according to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
  /// - Returns: A new `CGSize` where `width` and `height` are rounded according to the rule.
  @inlinable public func rounded(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> CGSize {
      CGSize(width: width.rounded(rule), height: height.rounded(rule))
  }

  /// Calculates a `CGRect` that fits within the given bounds, centered within the bounds.
  ///
  /// - Parameter bounds: The bounds in which to fit the size.
  /// - Returns: A `CGRect` centered within the bounds and scaled to fit proportionally.
  @inlinable public func thatFits(_ bounds: CGRect) -> CGRect {
      let size = thatFits(bounds.size)
      return CGRect(
        x: bounds.midX - size.width * 0.5,
        y: bounds.midY - size.height * 0.5,
        width: size.width,
        height: size.height
      )
  }

  /// Calculates a `CGSize` that fits within the given size, maintaining the aspect ratio of the original size.
  ///
  /// - Parameter size: The size to fit within.
  /// - Returns: A new `CGSize` scaled proportionally to fit within the given size.
  @inlinable public func thatFits(_ size: CGSize) -> CGSize {
      let ratio = min(size.width / width, size.height / height)
      return CGSize(width: width * ratio, height: height * ratio)
  }

  /// Adds the given `CGSize` to the current size element-wise.
  ///
  /// - Parameter size: The `CGSize` to add.
  /// - Mutates: The current `CGSize` by adding the corresponding values of `size` to `width` and `height`.
  @inlinable public mutating func append(_ size: CGSize) {
      self = appending(size)
  }

  /// Adds the given `CGFloat` to both `width` and `height`.
  ///
  /// - Parameter size: The scalar value to add to both `width` and `height`.
  /// - Mutates: The current `CGSize` by adding `size` to both `width` and `height`.
  @inlinable public mutating func append(_ size: CGFloat) {
      self = appending(size)
  }

  /// Adds the given `CGFloat` to the `width`.
  ///
  /// - Parameter width: The value to add to `width`.
  /// - Mutates: The current `CGSize` by adding `width` to the current `width`.
  @inlinable public mutating func append(width: CGFloat) {
      self = appending(width: width)
  }

  /// Adds the given `CGFloat` to the `height`.
  ///
  /// - Parameter height: The value to add to `height`.
  /// - Mutates: The current `CGSize` by adding `height` to the current `height`.
  @inlinable public mutating func append(height: CGFloat) {
      self = appending(height: height)
  }

  /// Adds the given `CGSize` to the current size element-wise.
  ///
  /// - Parameter size: The `CGSize` to add.
  /// - Returns: A new `CGSize` where `width` and `height` are the sum of the corresponding dimensions of the current size and `size`.
  @inlinable public func appending(_ size: CGSize) -> CGSize {
      CGSize(width: width + size.width, height: height + size.height)
  }

  /// Adds the given `CGFloat` to both `width` and `height`.
  ///
  /// - Parameter size: The scalar value to add to both `width` and `height`.
  /// - Returns: A new `CGSize` where both dimensions are increased by `size`.
  @inlinable public func appending(_ size: CGFloat) -> CGSize {
      CGSize(width: width + size, height: height + size)
  }

  /// Adds the given `CGFloat` to the `width` dimension.
  ///
  /// - Parameter width: The value to add to `width`.
  /// - Returns: A new `CGSize` with `width` increased by `width` while `height` remains unchanged.
  @inlinable public func appending(width w: CGFloat) -> CGSize {
      CGSize(width: width + w, height: height)
  }

  /// Adds the given `CGFloat` to the `height` dimension.
  ///
  /// - Parameter height: The value to add to `height`.
  /// - Returns: A new `CGSize` with `height` increased by `height` while `width` remains unchanged.
  @inlinable public func appending(height h: CGFloat) -> CGSize {
      CGSize(width: width, height: height + h)
  }

  /// Subtracts the given `CGSize` from the current size element-wise.
  ///
  /// - Parameter size: The `CGSize` to subtract.
  /// - Mutates: The current `CGSize` by subtracting the corresponding values of `size` from `width` and `height`.
  @inlinable public mutating func subtract(_ size: CGSize) {
      self = subtracting(size)
  }

  /// Subtracts the given `CGFloat` from both `width` and `height`.
  ///
  /// - Parameter size: The scalar value to subtract from both `width` and `height`.
  /// - Mutates: The current `CGSize` by subtracting `size` from both `width` and `height`.
  @inlinable public mutating func subtract(_ size: CGFloat) {
      self = subtracting(size)
  }

  /// Subtracts the given `CGFloat` from the `width` dimension.
  ///
  /// - Parameter width: The value to subtract from `width`.
  /// - Mutates: The current `CGSize` by subtracting `width` from the current `width`.
  @inlinable public mutating func subtract(width: CGFloat) {
      self = subtracting(width: width)
  }

  /// Subtracts the given `CGFloat` from the `height` dimension.
  ///
  /// - Parameter height: The value to subtract from `height`.
  /// - Mutates: The current `CGSize` by subtracting `height` from the current `height`.
  @inlinable public mutating func subtract(height: CGFloat) {
      self = subtracting(height: height)
  }

  /// Subtracts the given `CGSize` from the current size element-wise.
  ///
  /// - Parameter size: The `CGSize` to subtract.
  /// - Returns: A new `CGSize` where `width` and `height` are the result of subtracting the corresponding dimensions of `size` from the current size.
  @inlinable public func subtracting(_ size: CGSize) -> CGSize {
      CGSize(width: width - size.width, height: height - size.height)
  }

  /// Subtracts the given `CGFloat` from both `width` and `height`.
  ///
  /// - Parameter size: The scalar value to subtract from both `width` and `height`.
  /// - Returns: A new `CGSize` where both dimensions are decreased by `size`.
  @inlinable public func subtracting(_ size: CGFloat) -> CGSize {
      CGSize(width: width - size, height: height - size)
  }

  /// Subtracts the given `CGFloat` from the `width` dimension.
  ///
  /// - Parameter width: The value to subtract from `width`.
  /// - Returns: A new `CGSize` with `width` decreased by `width` while `height` remains unchanged.
  @inlinable public func subtracting(width w: CGFloat) -> CGSize {
      CGSize(width: width - w, height: height)
  }

  /// Subtracts the given `CGFloat` from the `height` dimension.
  ///
  /// - Parameter height: The value to subtract from `height`.
  /// - Returns: A new `CGSize` with `height` decreased by `height` while `width` remains unchanged.
  @inlinable public func subtracting(height h: CGFloat) -> CGSize {
      CGSize(width: width, height: height - h)
  }

  /// Multiplies both dimensions of the current `CGSize` by the given scalar factor.
  ///
  /// - Parameter factor: The scalar by which to multiply both `width` and `height`.
  /// - Mutates: The current `CGSize` by multiplying both dimensions by `factor`.
  @inlinable public mutating func multiply(_ factor: CGFloat) {
      self = multiplying(factor)
  }

  /// Multiplies both dimensions of the `CGSize` by the given scalar factor.
  ///
  /// - Parameter factor: The scalar by which to multiply both `width` and `height`.
  /// - Returns: A new `CGSize` where both dimensions are multiplied by `factor`.
  @inlinable public func multiplying(_ factor: CGFloat) -> CGSize {
      CGSize(width: width * factor, height: height * factor)
  }

  /// Multiplies both dimensions of the `CGSize` by the given `Float` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply both `width` and `height`.
  /// - Returns: A new `CGSize` where both dimensions are multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Float) -> CGSize {
      multiplying(CGFloat(factor))
  }

  /// Multiplies both dimensions of the `CGSize` by the given `Double` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply both `width` and `height`.
  /// - Returns: A new `CGSize` where both dimensions are multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Double) -> CGSize {
      multiplying(CGFloat(factor))
  }

  /// Multiplies both dimensions of the `CGSize` by the given `Int` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply both `width` and `height`.
  /// - Returns: A new `CGSize` where both dimensions are multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Int) -> CGSize {
      multiplying(CGFloat(factor))
  }
}

// MARK: - CGPoint

extension CGPoint {
  /// Negates the `x` and `y` coordinates of the `CGPoint`.
  @inlinable public var negate: CGPoint {
      CGPoint(x: -x, y: -y)
  }

  /// Adds two `CGPoint` values element-wise.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side `CGPoint`.
  ///   - rhs: The right-hand side `CGPoint`.
  /// - Returns: A new `CGPoint` where `x` and `y` are the sum of the corresponding coordinates of `lhs` and `rhs`.
  @inlinable public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
      lhs.appending(rhs)
  }

  /// Subtracts the right-hand side `CGPoint` from the left-hand side element-wise.
  ///
  /// - Parameters:
  ///   - lhs: The left-hand side `CGPoint`.
  ///   - rhs: The right-hand side `CGPoint`.
  /// - Returns: A new `CGPoint` where `x` and `y` are the result of subtracting the corresponding coordinates of `rhs` from `lhs`.
  @inlinable public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
      lhs.subtracting(rhs)
  }

  /// Multiplies each coordinate of `CGPoint` by a scalar value of type `CGFloat`.
  ///
  /// - Parameters:
  ///   - lhs: The `CGPoint` to be multiplied.
  ///   - rhs: The scalar value of type `CGFloat`.
  /// - Returns: A new `CGPoint` where `x` and `y` are multiplied by `rhs`.
  @inlinable public static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
      lhs.multiplying(rhs)
  }

  /// Multiplies each coordinate of `CGPoint` by a scalar value of type `Float`.
  ///
  /// - Parameters:
  ///   - lhs: The `CGPoint` to be multiplied.
  ///   - rhs: The scalar value of type `Float`.
  /// - Returns: A new `CGPoint` where `x` and `y` are multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: CGPoint, rhs: Float) -> CGPoint {
      lhs.multiplying(CGFloat(rhs))
  }

  /// Multiplies each coordinate of `CGPoint` by a scalar value of type `Double`.
  ///
  /// - Parameters:
  ///   - lhs: The `CGPoint` to be multiplied.
  ///   - rhs: The scalar value of type `Double`.
  /// - Returns: A new `CGPoint` where `x` and `y` are multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: CGPoint, rhs: Double) -> CGPoint {
      lhs.multiplying(CGFloat(rhs))
  }

  /// Multiplies each coordinate of `CGPoint` by a scalar value of type `Int`.
  ///
  /// - Parameters:
  ///   - lhs: The `CGPoint` to be multiplied.
  ///   - rhs: The scalar value of type `Int`.
  /// - Returns: A new `CGPoint` where `x` and `y` are multiplied by `CGFloat(rhs)`.
  @inlinable public static func * (lhs: CGPoint, rhs: Int) -> CGPoint {
      lhs.multiplying(CGFloat(rhs))
  }

  /// Negates the `CGPoint`, flipping the sign of `x` and `y`.
  ///
  /// - Parameter point: The `CGPoint` to negate.
  /// - Returns: A new `CGPoint` where `x` and `y` are negated.
  @inlinable static prefix func - (point: CGPoint) -> CGPoint {
      point.negate
  }

  /// Offsets the `CGPoint` by the specified `dx` and `dy`.
  ///
  /// - Parameters:
  ///   - dx: The value to add to the `x` coordinate.
  ///   - dy: The value to add to the `y` coordinate.
  /// - Returns: A new `CGPoint` offset by `dx` and `dy`.
  @inlinable public func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
      CGPoint(x: x + dx, y: y + dy)
  }

  /// Rounds each coordinate of the `CGPoint` according to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
  /// - Mutates: The current `CGPoint` by rounding `x` and `y` according to the rule.
  @inlinable public mutating func round(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) {
      self = rounded(rule)
  }

  /// Rounds each coordinate of the `CGPoint` according to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
  /// - Returns: A new `CGPoint` where `x` and `y` are rounded according to the rule.
  @inlinable public func rounded(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> CGPoint {
      CGPoint(x: x.rounded(rule), y: y.rounded(rule))
  }

  /// Adds the given `CGPoint` to the current point element-wise.
  ///
  /// - Parameter point: The `CGPoint` to add.
  /// - Mutates: The current `CGPoint` by adding the corresponding values of `point` to `x` and `y`.
  @inlinable public mutating func append(_ point: CGPoint) {
      self = appending(point)
  }

  /// Adds the given `CGFloat` to both `x` and `y`.
  ///
  /// - Parameter value: The scalar value to add to both `x` and `y`.
  /// - Mutates: The current `CGPoint` by adding `value` to both `x` and `y`.
  @inlinable public mutating func append(_ value: CGFloat) {
      self = appending(value)
  }

  /// Adds the given `CGFloat` to the `x` coordinate.
  ///
  /// - Parameter x: The value to add to `x`.
  /// - Mutates: The current `CGPoint` by adding `x` to the current `x`.
  @inlinable public mutating func append(x: CGFloat) {
      self = appending(x: x)
  }

  /// Adds the given `CGFloat` to the `y` coordinate.
  ///
  /// - Parameter y: The value to add to `y`.
  /// - Mutates: The current `CGPoint` by adding `y` to the current `y`.
  @inlinable public mutating func append(y: CGFloat) {
      self = appending(y: y)
  }

  /// Adds the given `CGPoint` to the current point element-wise.
  ///
  /// - Parameter point: The `CGPoint` to add.
  /// - Returns: A new `CGPoint` where `x` and `y` are the sum of the corresponding coordinates of the current point and `point`.
  @inlinable public func appending(_ point: CGPoint) -> CGPoint {
      CGPoint(x: x + point.x, y: y + point.y)
  }

  /// Adds the given `CGFloat` to both `x` and `y`.
  ///
  /// - Parameter value: The scalar value to add to both `x` and `y`.
  /// - Returns: A new `CGPoint` where both coordinates are increased by `value`.
  @inlinable public func appending(_ value: CGFloat) -> CGPoint {
      CGPoint(x: x + value, y: y + value)
  }

  /// Adds the given `CGFloat` to the `x` coordinate.
  ///
  /// - Parameter x: The value to add to `x`.
  /// - Returns: A new `CGPoint` with `x` increased by `x` while `y` remains unchanged.
  @inlinable public func appending(x value: CGFloat) -> CGPoint {
      CGPoint(x: x + value, y: y)
  }

  /// Adds the given `CGFloat` to the `y` coordinate.
  ///
  /// - Parameter y: The value to add to `y`.
  /// - Returns: A new `CGPoint` with `y` increased by `y` while `x` remains unchanged.
  @inlinable public func appending(y value: CGFloat) -> CGPoint {
      CGPoint(x: x, y: y + value)
  }

  /// Subtracts the given `CGPoint` from the current point element-wise.
  ///
  /// - Parameter point: The `CGPoint` to subtract.
  /// - Mutates: The current `CGPoint` by subtracting the corresponding values of `point` from `x` and `y`.
  @inlinable public mutating func subtract(_ point: CGPoint) {
      self = subtracting(point)
  }

  /// Subtracts the given `CGFloat` from both `x` and `y`.
  ///
  /// - Parameter value: The scalar value to subtract from both `x` and `y`.
  /// - Mutates: The current `CGPoint` by subtracting `value` from both `x` and `y`.
  @inlinable public mutating func subtract(_ value: CGFloat) {
      self = subtracting(value)
  }

  /// Subtracts the given `CGFloat` from the `x` coordinate.
  ///
  /// - Parameter x: The value to subtract from `x`.
  /// - Mutates: The current `CGPoint` by subtracting `x` from the current `x`.
  @inlinable public mutating func subtract(x: CGFloat) {
      self = subtracting(x: x)
  }

  /// Subtracts the given `CGFloat` from the `y` coordinate.
  ///
  /// - Parameter y: The value to subtract from `y`.
  /// - Mutates: The current `CGPoint` by subtracting `y` from the current `y`.
  @inlinable public mutating func subtract(y: CGFloat) {
      self = subtracting(y: y)
  }

  /// Subtracts the given `CGPoint` from the current point element-wise.
  ///
  /// - Parameter point: The `CGPoint` to subtract.
  /// - Returns: A new `CGPoint` where `x` and `y` are the result of subtracting the corresponding coordinates of `point` from the current point.
  @inlinable public func subtracting(_ point: CGPoint) -> CGPoint {
      CGPoint(x: x - point.x, y: y - point.y)
  }

  /// Subtracts the given `CGFloat` from both `x` and `y`.
  ///
  /// - Parameter value: The scalar value to subtract from both `x` and `y`.
  /// - Returns: A new `CGPoint` where both coordinates are decreased by `value`.
  @inlinable public func subtracting(_ value: CGFloat) -> CGPoint {
      CGPoint(x: x - value, y: y - value)
  }

  /// Subtracts the given `CGFloat` from the `x` coordinate.
  ///
  /// - Parameter value: The value to subtract from `x`.
  /// - Returns: A new `CGPoint` where `x` is decreased by `value`, while `y` remains unchanged.
  @inlinable public func subtracting(x value: CGFloat) -> CGPoint {
      CGPoint(x: x - value, y: y)
  }

  /// Subtracts the given `CGFloat` from the `y` coordinate.
  ///
  /// - Parameter value: The value to subtract from `y`.
  /// - Returns: A new `CGPoint` where `y` is decreased by `value`, while `x` remains unchanged.
  @inlinable public func subtracting(y value: CGFloat) -> CGPoint {
      CGPoint(x: x, y: y - value)
  }

  /// Multiplies both coordinates of the current `CGPoint` by the given scalar factor.
  ///
  /// - Parameter factor: The scalar by which to multiply both `x` and `y`.
  /// - Mutates: The current `CGPoint` by multiplying both coordinates by `factor`.
  @inlinable public mutating func multiply(_ factor: CGFloat) {
      self = multiplying(factor)
  }

  /// Multiplies both coordinates of the `CGPoint` by the given scalar factor.
  ///
  /// - Parameter factor: The scalar by which to multiply both `x` and `y`.
  /// - Returns: A new `CGPoint` where both coordinates are multiplied by `factor`.
  @inlinable public func multiplying(_ factor: CGFloat) -> CGPoint {
      CGPoint(x: x * factor, y: y * factor)
  }

  /// Multiplies both coordinates of the `CGPoint` by the given `Float` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply both `x` and `y`.
  /// - Returns: A new `CGPoint` where both coordinates are multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Float) -> CGPoint {
      multiplying(CGFloat(factor))
  }

  /// Multiplies both coordinates of the `CGPoint` by the given `Double` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply both `x` and `y`.
  /// - Returns: A new `CGPoint` where both coordinates are multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Double) -> CGPoint {
      multiplying(CGFloat(factor))
  }

  /// Multiplies both coordinates of the `CGPoint` by the given `Int` factor.
  ///
  /// - Parameter factor: The scalar by which to multiply both `x` and `y`.
  /// - Returns: A new `CGPoint` where both coordinates are multiplied by `CGFloat(factor)`.
  @inlinable public func multiplying(_ factor: Int) -> CGPoint {
      multiplying(CGFloat(factor))
  }
}

// MARK: - CGRect

extension CGRect {
  /// Returns the top-left point of the rectangle.
  ///
  /// - Returns: A `CGPoint` representing the top-left corner (`minX`, `minY`) of the rectangle.
  @inlinable public var topLeft: CGPoint { CGPoint(x: minX, y: minY) }

  /// Returns the top-center point of the rectangle.
  ///
  /// - Returns: A `CGPoint` representing the top-center point (`midX`, `minY`) of the rectangle.
  @inlinable public var topCenter: CGPoint { CGPoint(x: midX, y: minY) }

  /// Returns the top-right point of the rectangle.
  ///
  /// - Returns: A `CGPoint` representing the top-right corner (`maxX`, `minY`) of the rectangle.
  @inlinable public var topRight: CGPoint { CGPoint(x: maxX, y: minY) }

  /// Returns the bottom-left point of the rectangle.
  ///
  /// - Returns: A `CGPoint` representing the bottom-left corner (`minX`, `maxY`) of the rectangle.
  @inlinable public var bottomLeft: CGPoint { CGPoint(x: minX, y: maxY) }

  /// Returns the bottom-center point of the rectangle.
  ///
  /// - Returns: A `CGPoint` representing the bottom-center point (`midX`, `maxY`) of the rectangle.
  @inlinable public var bottomCenter: CGPoint { CGPoint(x: midX, y: maxY) }

  /// Returns the bottom-right point of the rectangle.
  ///
  /// - Returns: A `CGPoint` representing the bottom-right corner (`maxX`, `maxY`) of the rectangle.
  @inlinable public var bottomRight: CGPoint { CGPoint(x: maxX, y: maxY) }

  /// Returns the center-left point of the rectangle.
  ///
  /// - Returns: A `CGPoint` representing the center-left point (`minX`, `midY`) of the rectangle.
  @inlinable public var centerLeft: CGPoint { CGPoint(x: minX, y: midY) }

  /// Returns the center point of the rectangle.
  ///
  /// - Returns: A `CGPoint` representing the center (`midX`, `midY`) of the rectangle.
  @inlinable public var center: CGPoint { CGPoint(x: midX, y: midY) }

  /// Returns the center-right point of the rectangle.
  ///
  /// - Returns: A `CGPoint` representing the center-right point (`maxX`, `midY`) of the rectangle.
  @inlinable public var centerRight: CGPoint { CGPoint(x: maxX, y: midY) }

  /// Initializes a `CGRect` with a given origin and a size of `.zero`.
  ///
  /// - Parameter origin: The origin point of the rectangle.
  public init(origin: CGPoint) {
      self.init(origin: origin, size: .zero)
  }

  /// Initializes a `CGRect` with a given size and an origin of `.zero`.
  ///
  /// - Parameter size: The size of the rectangle.
  public init(size: CGSize) {
      self.init(origin: .zero, size: size)
  }

  /// Initializes a `CGRect` with a given `x` and `y` coordinates and a size of `0`.
  ///
  /// - Parameters:
  ///   - x: The x-coordinate of the rectangle.
  ///   - y: The y-coordinate of the rectangle.
  public init(x: CGFloat, y: CGFloat) {
      self.init(x: x, y: y, width: 0, height: 0)
  }

  /// Initializes a `CGRect` with a given `x` and `y` coordinates (as `Double`) and a size of `0`.
  ///
  /// - Parameters:
  ///   - x: The x-coordinate of the rectangle.
  ///   - y: The y-coordinate of the rectangle.
  public init(x: Double, y: Double) {
      self.init(x: CGFloat(x), y: CGFloat(y), width: 0, height: 0)
  }

  /// Initializes a `CGRect` with a given `x` and `y` coordinates (as `Int`) and a size of `0`.
  ///
  /// - Parameters:
  ///   - x: The x-coordinate of the rectangle.
  ///   - y: The y-coordinate of the rectangle.
  public init(x: Int, y: Int) {
      self.init(x: CGFloat(x), y: CGFloat(y), width: 0, height: 0)
  }

  /// Initializes a `CGRect` with a given width and height, and an origin of `(0, 0)`.
  ///
  /// - Parameters:
  ///   - width: The width of the rectangle.
  ///   - height: The height of the rectangle.
  public init(width: CGFloat, height: CGFloat) {
      self.init(x: 0, y: 0, width: width, height: height)
  }

  /// Initializes a `CGRect` with a given width and height (as `Double`), and an origin of `(0, 0)`.
  ///
  /// - Parameters:
  ///   - width: The width of the rectangle.
  ///   - height: The height of the rectangle.
  public init(width: Double, height: Double) {
      self.init(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height))
  }

  /// Initializes a `CGRect` with a given width and height (as `Int`), and an origin of `(0, 0)`.
  ///
  /// - Parameters:
  ///   - width: The width of the rectangle.
  ///   - height: The height of the rectangle.
  public init(width: Int, height: Int) {
      self.init(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height))
  }

  /// Rounds the rectangle’s origin and size to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to apply. Defaults to `.toNearestOrAwayFromZero`.
  /// - Mutates: The current `CGRect` by rounding the origin and size.
  @inlinable public mutating func round(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) {
      self = rounded(rule)
  }

  /// Returns a new `CGRect` with the origin and size rounded to the specified rounding rule.
  ///
  /// - Parameter rule: The rounding rule to apply. Defaults to `.toNearestOrAwayFromZero`.
  /// - Returns: A new `CGRect` with the origin and size rounded according to the rule.
  @inlinable public func rounded(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> CGRect {
      CGRect(origin: origin.rounded(rule), size: size.rounded(rule))
  }
}

// MARK: - Metric

@MainActor
extension CGFloat {
  static let noIntrinsicMetric = UIView.noIntrinsicMetric
}

@MainActor
extension CGSize {
  static let noIntrinsicSize = CGSize(width: .noIntrinsicMetric, height: .noIntrinsicMetric)
  static let layoutFittingCompressedSize = UIView.layoutFittingCompressedSize
  static let layoutFittingExpandedSize = UIView.layoutFittingExpandedSize
}
