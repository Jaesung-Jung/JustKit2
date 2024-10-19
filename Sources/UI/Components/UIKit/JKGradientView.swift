//
//  JKGradientView.swift
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

// MARK: - JKGradientView

public final class JKGradientView: Component<JKGradientView.Configuration> {
  let contentView: StatefulHostingView<Configuration>

  public init() {
    let configuration = Configuration()
    self.contentView = StatefulHostingView(state: configuration) { state in
      if let gradient = state.gradient?.shapeStyle {
        Rectangle().fill(gradient)
      }
    }
    super.init(configuration: configuration)
    addSubview(contentView)
  }

  public convenience init(_ gradient: JKGradient) {
    self.init()
    self.configuration.gradient = gradient
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = bounds
  }

  public override func updateConfiguration() {
    contentView.state = configuration
  }
}

// MARK: - JKGradientView.Configuration

extension JKGradientView {
  public struct Configuration {
    public var gradient: JKGradient?
  }
}

// MARK: - GradientView Preview

#if DEBUG

@available(iOS 17.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
  let colors: [UIColor] = [
    .systemPink,
    .systemGreen,
    .systemBlue
  ]
  return PreviewView(height: 400, contentInsets: NSDirectionalEdgeInsets(horizontal: 20)) {
    UIStackView(axis: .vertical, distribution: .fillEqually, spacing: 20) {
      UIStackView(axis: .horizontal, distribution: .fillEqually, spacing: 20) {
        JKGradientView(.linear(colors: colors, start: .topLeading, end: .bottomTrailing))
        JKGradientView(.angular(colors: colors, center: .center, startAngle: Angle(degrees: -20).radians, endAngle: Angle(degrees: 360 - 20).radians))
      }
      UIStackView(axis: .horizontal, distribution: .fillEqually, spacing: 20) {
        JKGradientView(.conic(colors: colors, center: .center))
        JKGradientView(.elliptical(colors: colors))
      }
    }
  }
}

#endif
