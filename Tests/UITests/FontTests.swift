//
//  FontTests.swift
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
import SwiftUI
@testable import JustUI

final class FontsTests {
  // MARK: - Font.JustFont Tests

  @Test(arguments: [
    Font.FontConfiguration.largeTitle,
    Font.FontConfiguration.title,
    Font.FontConfiguration.title2,
    Font.FontConfiguration.title3,
    Font.FontConfiguration.title4,
    Font.FontConfiguration.headline,
    Font.FontConfiguration.subheadline,
    Font.FontConfiguration.body,
    Font.FontConfiguration.footnote,
    Font.FontConfiguration.caption,
    Font.FontConfiguration.caption2
  ])
  func testScaledFont(configuration: Font.FontConfiguration) {
    let font = Font.just.scaledFont(configuration)
    let expectedFont = Font
      .custom(".AppleSystemUIFont", size: configuration.size, relativeTo: configuration.style)
      .weight(configuration.weight)
    #expect(font == expectedFont)
  }

  // MARK: - UIFont.JustFont Tests

  @Test(arguments: [
    Font.FontConfiguration.largeTitle,
    Font.FontConfiguration.title,
    Font.FontConfiguration.title2,
    Font.FontConfiguration.title3,
    Font.FontConfiguration.title4,
    Font.FontConfiguration.headline,
    Font.FontConfiguration.subheadline,
    Font.FontConfiguration.body,
    Font.FontConfiguration.footnote,
    Font.FontConfiguration.caption,
    Font.FontConfiguration.caption2
  ])
  func testScaledUIFont(configuration: Font.FontConfiguration) throws {
    let font = UIFont.just.scaledFont(configuration: configuration, weight: nil, width: .standard)
    #expect(font.pointSize == configuration.size)
    let traits = try #require(font.fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any])
    let weight = try #require(traits[.weight] as? CGFloat)
    #expect(weight == UIFont.JustFont.fontWeight(configuration.weight).rawValue)
  }

  // MARK: - FontWeight Mapping Tests

  @Test(arguments: [
    (Font.Weight.black, UIFont.Weight.black),
    (Font.Weight.heavy, UIFont.Weight.heavy),
    (Font.Weight.bold, UIFont.Weight.bold),
    (Font.Weight.semibold, UIFont.Weight.semibold),
    (Font.Weight.medium, UIFont.Weight.medium),
    (Font.Weight.regular, UIFont.Weight.regular),
    (Font.Weight.light, UIFont.Weight.light),
    (Font.Weight.thin, UIFont.Weight.thin),
    (Font.Weight.ultraLight, UIFont.Weight.ultraLight)
  ])
  func testUIFontJustFontWeightMapping(weight1: Font.Weight, weight2: UIFont.Weight) {
    let uiFontWeight = UIFont.JustFont.fontWeight(weight1)
    #expect(uiFontWeight == weight2)
  }
}
