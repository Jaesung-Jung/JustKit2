//
//  UIKitExtensionTests.swift
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

import UIKit
import Testing
@testable import JustUI

@MainActor
@Suite struct UIKitExtensionsTests {
  // MARK: - UIView (CALayer) Tests

  @Test func testCornerRadius() {
    let view = UIView()
    view.cornerRadius = 10
    #expect(view.layer.cornerRadius == 10)
  }

  @Test func testMaskedCorners() {
    let view = UIView()
    view.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    #expect(view.layer.maskedCorners == [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
  }

  @Test func testCornerCurve() {
    let view = UIView()
    view.cornerCurve = .continuous
    #expect(view.layer.cornerCurve == .continuous)
  }

  @Test func testBorderWidth() {
    let view = UIView()
    view.borderWidth = 2
    #expect(view.layer.borderWidth == 2)
  }

  @Test func testBorderColor() {
    let view = UIView()
    view.borderColor = UIColor.red
    #expect(view.layer.borderColor == UIColor.red.cgColor)
  }

  @Test func testAddSublayer() {
    let view = UIView()
    let sublayer = CALayer()
    view.addSublayer(sublayer)
    #expect(view.layer.sublayers?.contains(sublayer) == true)
  }

  // MARK: - UIView (Shadow) Tests

  @Test func testShadowProperties() {
    let view = UIView()
    view.shadow.color = UIColor.black
    view.shadow.opacity = 0.5
    view.shadow.offset = CGSize(width: 2, height: 2)
    view.shadow.radius = 5
    #expect(view.layer.shadowColor == UIColor.black.cgColor)
    #expect(view.layer.shadowOpacity == 0.5)
    #expect(view.layer.shadowOffset == CGSize(width: 2, height: 2))
    #expect(view.layer.shadowRadius == 5)
  }

  // MARK: - UIView (Convert) Tests

  @Test func testConvertDirectionalEdgeInsets() {
    let view = UIView()
    let directionalInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
    // Assuming Left-to-Right layout direction
    let insets = view.convert(directionalInsets)
    #expect(insets.top == 10)
    #expect(insets.left == 20)
    #expect(insets.bottom == 30)
    #expect(insets.right == 40)
  }

  // MARK: - UIControl.State Tests

  @Test func testUIControlStateProperties() {
    let state: UIControl.State = [.highlighted, .selected]
    #expect(state.isHighlighted == true)
    #expect(state.isSelected == true)
    #expect(state.isEnabled == true)
    #expect(state.isDisabled == false)
    #expect(state.isFocued == false)
  }

  // MARK: - UIStackView Tests

  @Test func testUIStackViewConvenienceInit() {
    let subviews = [UIView(), UIView()]
    let stackView = UIStackView(
      axis: .horizontal,
      distribution: .fillEqually,
      alignment: .center,
      spacing: 10,
      arrangedSubviews: subviews
    )
    #expect(stackView.axis == .horizontal)
    #expect(stackView.distribution == .fillEqually)
    #expect(stackView.alignment == .center)
    #expect(stackView.spacing == 10)
    #expect(stackView.arrangedSubviews == subviews)
  }

  @Test func testUIStackViewConvenienceInitWithBuilder() {
    let subview1 = UIImageView()
    let subview2 = UILabel()
    let stackView = UIStackView(axis: .vertical) {
      subview1
      subview2
    }
    #expect(stackView.arrangedSubviews == [subview1, subview2])
  }

  @Test func testAddArrangedSubviews() {
    let stackView = UIStackView()
    let subviews = [UIView(), UIView()]
    stackView.addArrangedSubviews(subviews)
    #expect(stackView.arrangedSubviews == subviews)
  }

  @Test(arguments: [true, false]) func testAddArrangedSubviewsWithArrayBuilder(condition: Bool) {
    let stackView = UIStackView()
    stackView.addArrangedSubviews {
      if condition {
        UILabel()
      }
      UIImageView()
    }
    if condition {
      #expect(stackView.arrangedSubviews.count == 2)
      #expect(stackView.arrangedSubviews[0] is UILabel && stackView.arrangedSubviews[1] is UIImageView)
    } else {
      #expect(stackView.arrangedSubviews.count == 1)
      #expect(stackView.arrangedSubviews[0] is UIImageView)
    }
  }

  // MARK: - UIColor (Components) Tests

  @Test func testUIColorRGBAComponents() {
    let color = UIColor(red: 0.5, green: 0.6, blue: 0.7, alpha: 0.8)
    let components = color.rgba()
    #expect(components.red == 0.5)
    #expect(components.green == 0.6)
    #expect(components.blue == 0.7)
    #expect(components.alpha == 0.8)
  }

  @Test func testUIColorHSBAComponents() {
    let color = UIColor(hue: 0.5, saturation: 0.6, brightness: 0.7, alpha: 0.8)
    let components = color.hsba()
    #expect(components.hue == 0.5)
    #expect(components.saturation == 0.6)
    #expect(components.brightness == 0.7)
    #expect(components.alpha == 0.8)
  }

  // MARK: - UIImage (Color) Tests

  @Test func testUIImageInitWithColor() {
    let color = UIColor.red
    let size = CGSize(width: 10, height: 10)
    let image = UIImage(color: color, size: size)
    #expect(image != nil)
    #expect(image?.size == size)
  }

  // MARK: - UIImage (Grayscale) Tests

  @Test func testUIImageGrayscale() {
    let image = UIImage(color: .red, size: CGSize(width: 10, height: 10))
    let grayImage = image?.grayscale()
    #expect(grayImage != nil)
    #expect(grayImage?.size == image?.size)
  }

  // MARK: - UIImage (Resize) Tests

  @Test func testUIImageResizeToSize() {
    let image = UIImage(color: .blue, size: CGSize(width: 100, height: 100))
    let newSize = CGSize(width: 50, height: 50)
    let resizedImage = image?.resize(to: newSize)
    #expect(resizedImage != nil)
    #expect(resizedImage?.size == newSize)
  }

  @Test func testUIImageResizeInBounds() {
    let image = UIImage(color: .blue, size: CGSize(width: 200, height: 100))
    let boundsSize = CGSize(width: 100, height: 50)
    let resizedImage = image?.resize(in: boundsSize)
    #expect(resizedImage != nil)
    #expect(resizedImage?.size == CGSize(width: 100, height: 50))
  }

  // MARK: - UIImage (Crop) Tests

  @Test func testUIImageCropping() {
    let image = UIImage(color: .green, size: CGSize(width: 100, height: 100))
    let cropRect = CGRect(x: 25, y: 25, width: 50, height: 50)
    let croppedImage = image?.cropping(to: cropRect)
    #expect(croppedImage != nil)
    #expect(croppedImage?.size == CGSize(width: 50, height: 50))
  }
}
