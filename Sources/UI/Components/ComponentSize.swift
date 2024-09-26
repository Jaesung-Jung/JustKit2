//
//  ComponentSize.swift
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

// MARK: - ComponentSize

/// An enumeration representing component size.
public enum ComponentSize: CaseIterable {
  /// An array of all `ComponentSize` values.
  public static var allCases: [ComponentSize] {
    if #available(iOS 17.0, macCatalyst 17.0, *) {
      return [.mini, .small, .regular, .large, .extraLarge]
    } else {
      return [.mini, .small, .regular, .large]
    }
  }

  /// A mini-sized component./
  case mini
  // A small-sized component.
  case small
  // A regular-sized component.
  case regular
  // A large-sized component.
  case large
  @available(iOS 17.0, macCatalyst 17.0, *)
  // A extra-large component.
  case extraLarge

  /// Initializes a `ComponentSize` based on the provided `ControlSize`.
  ///
  /// - Parameter controlSize: The `ControlSize` to map to a `ComponentSize`.
  public init(_ controlSize: ControlSize) {
    if #available(iOS 17.0, macCatalyst 17.0, *) {
      switch controlSize {
      case .mini:
        self = .mini
      case .small:
        self = .small
      case .large:
        self = .large
      case .extraLarge:
        self = .extraLarge
      default:
        self = .regular
      }
    } else {
      switch controlSize {
      case .mini:
        self = .mini
      case .small:
        self = .small
      case .large:
        self = .large
      default:
        self = .regular
      }
    }
  }

  var preferredFont: Font {
    switch self {
    case .mini, .small:
      return .subheadline
    case .large:
      return .title3
    case .extraLarge:
      return .title2
    default:
      return .body
    }
  }

  var preferredUIFont: UIFont {
    switch self {
    case .mini:
      return .preferredFont(forTextStyle: .footnote)
    case .small:
      return .preferredFont(forTextStyle: .subheadline)
    case .large:
      return .preferredFont(forTextStyle: .title3)
    case .extraLarge:
      return .preferredFont(forTextStyle: .title2)
    default:
      return .preferredFont(forTextStyle: .body)
    }
  }
}
