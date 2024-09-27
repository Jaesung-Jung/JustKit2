//
//  JKActivityIndicatorView.swift
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

// MARK: - JKActivityIndicatorView

public class JKActivityIndicatorView: Component<JKActivityIndicatorView.Configuration> {
  let contentView: StatefulHostingView<Configuration>

  public override var intrinsicContentSize: CGSize {  contentView.intrinsicContentSize }

  public init(style: Style = .default, size: ComponentSize = .regular) {
    let configuration = Configuration(style: style, componentSize: size)
    self.contentView = StatefulHostingView(state: configuration) {
      ContentView(state: $0)
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

  public func startAnimating() {
    configuration.isAnimating = true
  }

  public func stopAnimating() {
    configuration.isAnimating = false
  }
}

// MARK: - JKActivityIndicatorView.Configuration

extension JKActivityIndicatorView {
  public struct Configuration {
    var isAnimating: Bool = false
    public var style: Style
    public var componentSize: ComponentSize
    public var hidesWhenStopped: Bool = true
  }
}

// MARK: - JKActivityIndicatorView.Style

extension JKActivityIndicatorView {
  public enum Style {
    case `default`
    case circleFade
    case circleScale
  }
}

// MARK: - JKActivityIndicatorView.Content

extension JKActivityIndicatorView {
  struct ContentView: View {
    let state: Configuration

    var body: some View {
      if state.isAnimating {
        switch state.style {
        case .default:
          ProgressView().controlSize(state.componentSize.controlSize)
        case .circleFade:
          CircleFadeProgressViewStyle.Content(label: EmptyView(), componentSize: state.componentSize)
        case .circleScale:
          CircleScaleProgressViewStyle.Content(label: EmptyView(), componentSize: state.componentSize)
        }
      }
    }
  }
}

// MARK: - FUActivityIndicatorView Preview

@available(iOS 17.0, macCatalyst 17.0, *)
#Preview {
  let styles: [JKActivityIndicatorView.Style] = [.default, .circleFade, .circleScale]
  let makeActivityIndicator: (JKActivityIndicatorView.Style) -> JKActivityIndicatorView = { style in
    let activityIndicator = JKActivityIndicatorView()
    activityIndicator.configuration.style = style
    activityIndicator.startAnimating()
    return activityIndicator
  }
  let stackView = UIStackView(arrangedSubviews: styles.map { makeActivityIndicator($0) })
  stackView.axis = .vertical
  stackView.spacing = 20
  stackView.alignment = .center
  return stackView
}
