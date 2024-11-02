//
//  SwiftUI+Extension.swift
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

// MARK: - Animation (JustAnimation)

extension Animation {
  public static let just = JustAnimation.self

  public enum JustAnimation {
    /// A snappy spring animation
    public static var snappy: Animation {
      .snappy(duration: 0.3)
    }

    /// A smooth spring animation
    public static var smooth: Animation {
      .smooth(duration: 0.3)
    }

    /// A bouncy spring animation
    public static var bouncy: Animation {
      .bouncy(duration: 0.5)
    }
  }
}

// MARK: - View (Modifier)

extension View {
  /// Conditionally applies a transformation to the view if a non-nil value is provided.
  ///
  /// This view modifier checks if the given optional value is non-nil. If it is, the provided transformation is applied, passing the view and the unwrapped value. If the value is nil, the original view is returned without any modifications.
  ///
  /// - Parameters:
  ///   - value: An optional value of type `T`. If non-nil, `transform` is applied.
  ///   - transform: A closure that takes the view (`Self`) and the unwrapped value (`T`) to produce a transformed view.
  /// - Returns: The transformed view if `value` is non-nil; otherwise, the original view.
  @ViewBuilder public func ifLet<T, Content: View>(_ value: T?, transform: (Self, T) -> Content) -> some View {
    if let value {
      transform(self, value)
    } else {
      self
    }
  }
}
