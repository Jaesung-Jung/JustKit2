//
//  GeometryExtensionTests.swift
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
import Testing
@testable import JustUI

@Suite struct GeometryExtensionTests {
  // MARK: - UIEdgeInsets Tests

  @Test func testUIEdgeInsetsVerticalHorizontal() {
    let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
    #expect(insets.vertical == 40)
    #expect(insets.horizontal == 60)
  }

  @Test func testUIEdgeInsetsNegate() {
    let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
    let negated = insets.negate
    #expect(negated.top == -10)
    #expect(negated.left == -20)
    #expect(negated.bottom == -30)
    #expect(negated.right == -40)
  }

  @Test func testUIEdgeInsetsAddition() {
    let insets1 = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
    let insets2 = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    let result = insets1 + insets2
    #expect(result.top == 15)
    #expect(result.left == 25)
    #expect(result.bottom == 35)
    #expect(result.right == 45)
  }

  @Test func testUIEdgeInsetsSubtraction() {
    let insets1 = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
    let insets2 = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    let result = insets1 - insets2
    #expect(result.top == 5)
    #expect(result.left == 15)
    #expect(result.bottom == 25)
    #expect(result.right == 35)
  }

  @Test func testUIEdgeInsetsMultiplication() {
    let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
    let result = insets * 2
    #expect(result.top == 20)
    #expect(result.left == 40)
    #expect(result.bottom == 60)
    #expect(result.right == 80)
  }

  @Test func testUIEdgeInsetsInitVariants() {
    let insets1 = UIEdgeInsets(top: 10)
    #expect(insets1.top == 10)
    #expect(insets1.left == 0)
    #expect(insets1.bottom == 0)
    #expect(insets1.right == 0)

    let insets2 = UIEdgeInsets(horizontal: 15)
    #expect(insets2.left == 15)
    #expect(insets2.right == 15)
    #expect(insets2.top == 0)
    #expect(insets2.bottom == 0)
  }

  // MARK: - NSDirectionalEdgeInsets Tests

  @Test func testNSDirectionalEdgeInsetsVerticalHorizontal() {
    let insets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
    #expect(insets.vertical == 40)
    #expect(insets.horizontal == 60)
  }

  @Test func testNSDirectionalEdgeInsetsNegate() {
    let insets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
    let negated = insets.negate
    #expect(negated.top == -10)
    #expect(negated.leading == -20)
    #expect(negated.bottom == -30)
    #expect(negated.trailing == -40)
  }

  @Test func testNSDirectionalEdgeInsetsAddition() {
    let insets1 = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
    let insets2 = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    let result = insets1 + insets2
    #expect(result.top == 15)
    #expect(result.leading == 25)
    #expect(result.bottom == 35)
    #expect(result.trailing == 45)
  }

  @Test func testNSDirectionalEdgeInsetsSubtraction() {
    let insets1 = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
    let insets2 = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    let result = insets1 - insets2
    #expect(result.top == 5)
    #expect(result.leading == 15)
    #expect(result.bottom == 25)
    #expect(result.trailing == 35)
  }

  @Test func testNSDirectionalEdgeInsetsMultiplication() {
    let insets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
    let result = insets * 2
    #expect(result.top == 20)
    #expect(result.leading == 40)
    #expect(result.bottom == 60)
    #expect(result.trailing == 80)
  }

  // MARK: - EdgeInsets Tests

  @Test func testEdgeInsetsVerticalHorizontal() {
    let insets = EdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
    #expect(insets.vertical == 40)
    #expect(insets.horizontal == 60)
  }

  @Test func testEdgeInsetsNegate() {
    let insets = EdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
    let negated = insets.negate
    #expect(negated.top == -10)
    #expect(negated.leading == -20)
    #expect(negated.bottom == -30)
    #expect(negated.trailing == -40)
  }

  @Test func testEdgeInsetsAddition() {
    let insets1 = EdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
    let insets2 = EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    let result = insets1 + insets2
    #expect(result.top == 15)
    #expect(result.leading == 25)
    #expect(result.bottom == 35)
    #expect(result.trailing == 45)
  }

  @Test func testEdgeInsetsSubtraction() {
    let insets1 = EdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
    let insets2 = EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    let result = insets1 - insets2
    #expect(result.top == 5)
    #expect(result.leading == 15)
    #expect(result.bottom == 25)
    #expect(result.trailing == 35)
  }

  @Test func testEdgeInsetsMultiplication() {
    let insets = EdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
    let result = insets * 2
    #expect(result.top == 20)
    #expect(result.leading == 40)
    #expect(result.bottom == 60)
    #expect(result.trailing == 80)
  }

  // MARK: - CGSize Tests

  @Test func testCGSizeNegate() {
    let size = CGSize(width: 50, height: 100)
    let negated = size.negate
    #expect(negated.width == -50)
    #expect(negated.height == -100)
  }

  @Test func testCGSizeAddition() {
    let size1 = CGSize(width: 50, height: 100)
    let size2 = CGSize(width: 10, height: 20)
    let result = size1 + size2
    #expect(result.width == 60)
    #expect(result.height == 120)
  }

  @Test func testCGSizeSubtraction() {
    let size1 = CGSize(width: 50, height: 100)
    let size2 = CGSize(width: 10, height: 20)
    let result = size1 - size2
    #expect(result.width == 40)
    #expect(result.height == 80)
  }

  @Test func testCGSizeMultiplication() {
    let size = CGSize(width: 50, height: 100)
    let result = size * 2
    #expect(result.width == 100)
    #expect(result.height == 200)
  }

  @Test func testCGSizeThatFits() {
    let size = CGSize(width: 200, height: 100)
    let bounds = CGSize(width: 100, height: 50)
    let result = size.thatFits(bounds)
    #expect(result.width == 100)
    #expect(result.height == 50)
  }

  // MARK: - CGPoint Tests

  @Test func testCGPointNegate() {
    let point = CGPoint(x: 50, y: 100)
    let negated = point.negate
    #expect(negated.x == -50)
    #expect(negated.y == -100)
  }

  @Test func testCGPointAddition() {
    let point1 = CGPoint(x: 50, y: 100)
    let point2 = CGPoint(x: 10, y: 20)
    let result = point1 + point2
    #expect(result.x == 60)
    #expect(result.y == 120)
  }

  @Test func testCGPointSubtraction() {
    let point1 = CGPoint(x: 50, y: 100)
    let point2 = CGPoint(x: 10, y: 20)
    let result = point1 - point2
    #expect(result.x == 40)
    #expect(result.y == 80)
  }

  @Test func testCGPointMultiplication() {
    let point = CGPoint(x: 50, y: 100)
    let result = point * 2
    #expect(result.x == 100)
    #expect(result.y == 200)
  }

  // MARK: - CGRect Tests

  @Test func testCGRectProperties() {
    let rect = CGRect(x: 10, y: 20, width: 100, height: 200)
    #expect(rect.topLeft == CGPoint(x: 10, y: 20))
    #expect(rect.topCenter == CGPoint(x: 60, y: 20))
    #expect(rect.topRight == CGPoint(x: 110, y: 20))
    #expect(rect.bottomLeft == CGPoint(x: 10, y: 220))
    #expect(rect.bottomCenter == CGPoint(x: 60, y: 220))
    #expect(rect.bottomRight == CGPoint(x: 110, y: 220))
    #expect(rect.centerLeft == CGPoint(x: 10, y: 120))
    #expect(rect.center == CGPoint(x: 60, y: 120))
    #expect(rect.centerRight == CGPoint(x: 110, y: 120))
  }

  @Test func testCGRectInitVariants() {
    let rect1 = CGRect(origin: CGPoint(x: 10, y: 20))
    #expect(rect1.origin.x == 10)
    #expect(rect1.origin.y == 20)
    #expect(rect1.size.width == 0)
    #expect(rect1.size.height == 0)

    let rect2 = CGRect(size: CGSize(width: 100, height: 200))
    #expect(rect2.origin.x == 0)
    #expect(rect2.origin.y == 0)
    #expect(rect2.size.width == 100)
    #expect(rect2.size.height == 200)
  }

  // MARK: - Rounding Tests

  @Test func testRounding() {
    var size = CGSize(width: 10.5, height: 20.7)
    size.round()
    #expect(size.width == 11)
    #expect(size.height == 21)

    let roundedPoint = CGPoint(x: 10.3, y: 20.8).rounded()
    #expect(roundedPoint.x == 10)
    #expect(roundedPoint.y == 21)
  }

  // MARK: - Metric Tests

  @MainActor
  @Test func testNoIntrinsicMetric() {
    #expect(CGFloat.noIntrinsicMetric == UIView.noIntrinsicMetric)
  }

  @MainActor
  @Test func testNoIntrinsicSize() {
    #expect(CGSize.noIntrinsicSize.width == CGFloat.noIntrinsicMetric)
    #expect(CGSize.noIntrinsicSize.height == CGFloat.noIntrinsicMetric)
  }
}
