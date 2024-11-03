//
//  JKShadowView.swift
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

// MARK: - JKShadowView

public final class JKShadowView: Component<JKShadowView.Configuration> {
  public init(
    color: UIColor? = nil,
    opacity: Float? = nil,
    offset: CGSize? = nil,
    radius: CGFloat? = nil,
    cornerRadius: CGFloat? = nil
  ) {
    super.init(
      configuration: Configuration(
        shadowColor: color ?? .secondarySystemFill,
        shadowOpacity: opacity ?? 1,
        shadowOffset: offset ?? .zero,
        shadowRadius: radius ?? 8,
        shadowCornerRadius: cornerRadius ?? 0
      )
    )
    layer.shouldRasterize = true

    if #available(iOS 17.0, *) {
      registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (`self`: Self, _) in
        self.layer.shadowColor = self.configuration.shadowColor.cgColor
      }
    }
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: configuration.shadowCornerRadius).cgPath
  }

  public override func updateConfiguration() {
    traitCollection.performAsCurrent {
      layer.shadowColor = configuration.shadowColor.cgColor
    }
    layer.shadowOpacity = configuration.shadowOpacity
    layer.shadowOffset = configuration.shadowOffset
    layer.shadowRadius = configuration.shadowRadius
    if previousConfiguration?.shadowCornerRadius != configuration.shadowCornerRadius {
      layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: configuration.shadowCornerRadius).cgPath
    }
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    guard #unavailable(iOS 17.0) else {
      return
    }
    layer.shadowColor = configuration.shadowColor.cgColor
  }
}

// MARK: - JKShadowView.Configuration

extension JKShadowView {
  public struct Configuration {
    public var shadowColor: UIColor
    public var shadowOpacity: Float
    public var shadowOffset: CGSize
    public var shadowRadius: CGFloat
    public var shadowCornerRadius: CGFloat
  }
}

// MARK: - JKShadowView Preview

#if DEBUG

@available(iOS 17.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
  PreviewView(size: 100) {
    JKShadowView().then {
      $0.shadowCornerRadius = 8
    }
  }
}

#endif
