//
//  Fonts.swift
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

// MARK: - Font (FontConfiguration)

extension Font {
  struct FontConfiguration {
    let size: CGFloat
    let style: Font.TextStyle
    let weight: Font.Weight

    init(size: CGFloat, style: Font.TextStyle, weight: Font.Weight) {
      self.size = size
      self.style = style
      self.weight = weight
    }

    static let largeTitle = Self(size: 30, style: .largeTitle, weight: .heavy)

    static let title = Self(size: 26, style: .title, weight: .bold)
    static let title2 = Self(size: 24, style: .title2, weight: .bold)
    static let title3 = Self(size: 22, style: .title3, weight: .bold)
    static let title4 = Self(size: 20, style: .title3, weight: .bold)

    static let headline = Self(size: 17, style: .headline, weight: .bold)
    static let subheadline = Self(size: 16, style: .subheadline, weight: .semibold)

    static let body = Self(size: 16, style: .body, weight: .medium)
    static let footnote = Self(size: 14, style: .body, weight: .regular)

    static let caption = Self(size: 13, style: .caption, weight: .regular)
    static let caption2 = Self(size: 12, style: .caption2, weight: .regular)
  }
}

// MARK: - Font (JustFont)

extension Font {
  public static let just = JustFont.self

  public enum JustFont {
    /// `30pt` size, `heavy` weight.
    public static let largeTitle = scaledFont(.largeTitle)
    /// `26pt` size, `bold` weight.
    public static let title = scaledFont(.title)
    /// `24pt` size, `bold` weight.
    public static let title2 = scaledFont(.title2)
    /// `22pt` size, `bold` weight.
    public static let title3 = scaledFont(.title3)
    /// `20pt` size, `bold` weight.
    public static let title4 = scaledFont(.title4)

    /// `17pt` size, `bold` weight.
    public static let headline = scaledFont(.headline)
    /// `16pt` size, `semibold` weight.
    public static let subheadline = scaledFont(.subheadline)

    /// `16pt` size, `medium` weight.
    public static let body = scaledFont(.body)
    /// `14pt` size, `regular` weight.
    public static let footnote = scaledFont(.footnote)

    /// `13pt` size, `regular` weight.
    public static let caption = scaledFont(.caption)
    /// `12pt` size, `regular` weight.
    public static let caption2 = scaledFont(.caption2)

    static func scaledFont(_ configuration: FontConfiguration) -> Font {
      return .custom(".AppleSystemUIFont", size: configuration.size, relativeTo: configuration.style).weight(configuration.weight)
    }
  }
}

// MARK: - UIFont (JustFont)

extension UIFont {
  typealias FontConfiguration = Font.FontConfiguration
  public static let just = JustFont.self

  public enum JustFont {
    /// `30pt` size, `heavy` weight.
    public static func largeTitle(weight: UIFont.Weight? = nil, width: UIFont.Width = .standard, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return scaledFont(configuration: .largeTitle, weight: weight, width: width, compatibleWith: traitCollection)
    }

    /// `26pt` size, `bold` weight.
    public static func title(weight: UIFont.Weight? = nil, width: UIFont.Width = .standard, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return scaledFont(configuration: .title, weight: weight, width: width, compatibleWith: traitCollection)
    }

    /// `24pt` size, `bold` weight.
    public static func title2(weight: UIFont.Weight? = nil, width: UIFont.Width = .standard, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return scaledFont(configuration: .title2, weight: weight, width: width, compatibleWith: traitCollection)
    }

    /// `22pt` size, `bold` weight.
    public static func title3(weight: UIFont.Weight? = nil, width: UIFont.Width = .standard, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return scaledFont(configuration: .title3, weight: weight, width: width, compatibleWith: traitCollection)
    }

    /// `20pt` size, `bold` weight.
    public static func title4(weight: UIFont.Weight? = nil, width: UIFont.Width = .standard, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return scaledFont(configuration: .title4, weight: weight, width: width, compatibleWith: traitCollection)
    }

    /// `17pt` size, `bold` weight.
    public static func headline(weight: UIFont.Weight? = nil, width: UIFont.Width = .standard, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return scaledFont(configuration: .headline, weight: weight, width: width, compatibleWith: traitCollection)
    }

    /// `16pt` size, `semibold` weight.
    public static func subheadline(weight: UIFont.Weight? = nil, width: UIFont.Width = .standard, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return scaledFont(configuration: .subheadline, weight: weight, width: width, compatibleWith: traitCollection)
    }

    /// `16pt` size, `medium` weight.
    public static func body(weight: UIFont.Weight? = nil, width: UIFont.Width = .standard, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return scaledFont(configuration: .body, weight: weight, width: width, compatibleWith: traitCollection)
    }

    /// `14pt` size, `regular` weight.
    public static func footnote(weight: UIFont.Weight? = nil, width: UIFont.Width = .standard, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return scaledFont(configuration: .footnote, weight: weight, width: width, compatibleWith: traitCollection)
    }

    /// `13pt` size, `regular` weight.
    public static func caption(weight: UIFont.Weight? = nil, width: UIFont.Width = .standard, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return scaledFont(configuration: .caption, weight: weight, width: width, compatibleWith: traitCollection)
    }

    /// `12pt` size, `regular` weight.
    public static func caption2(weight: UIFont.Weight? = nil, width: UIFont.Width = .standard, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return scaledFont(configuration: .caption2, weight: weight, width: width, compatibleWith: traitCollection)
    }

    static func scaledFont(configuration: Font.FontConfiguration, weight: UIFont.Weight?, width: UIFont.Width, compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
      return UIFontMetrics.default.scaledFont(
        for: .systemFont(
          ofSize: configuration.size,
          weight: weight ?? fontWeight(configuration.weight),
          width: width
        ),
        compatibleWith: traitCollection
      )
    }

    static func fontWeight(_ weight: Font.Weight) -> UIFont.Weight {
      switch weight {
      case .black:
        return .black
      case .heavy:
        return .heavy
      case .bold:
        return .bold
      case .semibold:
        return .semibold
      case .medium:
        return .medium
      case .light:
        return .light
      case .thin:
        return .thin
      case .ultraLight:
        return .ultraLight
      default:
        return .regular
      }
    }
  }
}
