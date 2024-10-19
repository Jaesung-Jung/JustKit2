//
//  JKProgressView.swift
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

// MARK: - JKProgressView

public final class JKProgressView: Component<JKProgressView.Configuration> {
  let contentView: StatefulHostingView<Configuration>

  public var progress: Double {
    get { configuration.progressValue.progress }
    set { configuration.progressValue = ProgressValue(progress: newValue, animated: false) }
  }

  public override var intrinsicContentSize: CGSize { contentView.intrinsicContentSize }

  public init(style: Style, size: ComponentSize = .regular) {
    let configuration = Configuration(
      progressValue: ProgressValue(progress: 0, animated: false),
      componentSize: size
    )
    switch style {
    case .linear(let thickness, let cornerRadius):
      self.contentView = StatefulHostingView<Configuration>(state: configuration) {
        JustLinearProgressViewStyle.Content(
          label: EmptyView(),
          progress: $0.progressValue.progress,
          thickness: thickness,
          cornerRadius: cornerRadius,
          componentSize: $0.componentSize
        )
        .animation($0.progressValue.animated ? .smooth(duration: 0.3) : nil, value: $0.progressValue.progress)
      }
    case .circular(let thickness):
      self.contentView = StatefulHostingView<Configuration>(state: configuration) {
        JustCircularProgressViewStyle.Content(
          label: EmptyView(),
          progress: $0.progressValue.progress,
          thickness: thickness,
          componentSize: $0.componentSize
        )
        .animation($0.progressValue.animated ? .smooth(duration: 0.3) : nil, value: $0.progressValue.progress)
      }
    }
    super.init(configuration: configuration)
    addSubview(contentView)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = bounds
  }

  public override func updateConfiguration() {
    contentView.state = configuration
  }

  public func setProgress(_ progress: Double, animated: Bool) {
    configuration.progressValue = ProgressValue(progress: progress, animated: animated)
  }
}

// MARK: - JKProgressView.Configuration

extension JKProgressView {
  public struct Configuration {
    var progressValue: ProgressValue
    public var componentSize: ComponentSize
  }
}

// MARK: - JKProgressView.Style

extension JKProgressView {
  public enum Style {
    case linear(thickness: CGFloat? = nil, cornerRadius: CGFloat? = nil)
    case circular(thickness: CGFloat? = nil)
  }
}

// MARK: - ProgressView.ProgressValue

extension JKProgressView {
  struct ProgressValue {
    let progress: Double
    let animated: Bool
  }
}

// MARK: - ProgressView Preview

#if DEBUG

@available(iOS 17.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
  UIStackView(axis: .vertical, alignment: .center, spacing: 40) {
    PreviewView(width: 300) {
      JKProgressView(style: .linear()).then {
        $0.setProgress(0.5, animated: true)
      }
    }
    PreviewView(width: 100, height: 100) {
      JKProgressView(style: .circular()).then {
        $0.setProgress(0.5, animated: true)
      }
    }
  }
}

#endif
