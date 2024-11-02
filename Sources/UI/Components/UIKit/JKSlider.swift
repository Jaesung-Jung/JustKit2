////
////  JKSlider.swift
////
////  Copyright © 2024 Jaesung Jung. All rights reserved.
////
////  Permission is hereby granted, free of charge, to any person obtaining a copy
////  of this software and associated documentation files (the "Software"), to deal
////  in the Software without restriction, including without limitation the rights
////  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
////  copies of the Software, and to permit persons to whom the Software is
////  furnished to do so, subject to the following conditions:
////
////  The above copyright notice and this permission notice shall be included in
////  all copies or substantial portions of the Software.
////
////  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
////  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
////  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
////  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
////  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
////  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
////  THE SOFTWARE.

import SwiftUI

// MARK: - JKSlider

public final class JKSlider: ControlComponent<JKSlider.Configuration> {
  private(set) var initialValue: Double?
  private lazy var feedback = FeedbackGenerator.selection(view: self)

  let contentView: StatefulHostingView<Configuration>

  public var value: Double {
    get { configuration.sliderValue.value }
    set {
      configuration.sliderValue = SliderValue(
        value: min(max(0, newValue), 1),
        animated: false
      )
    }
  }

  public override var intrinsicContentSize: CGSize {
    CGSize(width: UIView.noIntrinsicMetric, height: contentView.intrinsicContentSize.height)
  }

  public init() {
    let configuration = Configuration()
    self.contentView = StatefulHostingView(state: configuration) {
      ContentView(state: $0)
    }
    self.contentView.isUserInteractionEnabled = false
    super.init(configuration: configuration)
    addSubview(contentView)
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
    addGestureRecognizer(panGesture)
  }

  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    feedback.selectionChanged(at: touches.first?.location(in: touches.first?.view))
    configuration.isActive = true
    initialValue = configuration.sliderValue.value
  }

  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    configuration.isActive = false
    initialValue = nil
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = bounds
  }

  public override func updateConfiguration() {
    contentView.state = configuration
  }

  public func setValue(_ value: Double, animated: Bool) {
    configuration.sliderValue = SliderValue(
      value: min(max(0, value), 1),
      animated: animated
    )
  }

  @objc func handlePanGestureRecognizer(_ panGestureRecognizer: UIPanGestureRecognizer) {
    switch panGestureRecognizer.state {
    case .changed:
      guard let initialValue else {
        return
      }
      let translation = panGestureRecognizer.translation(in: panGestureRecognizer.view)
      let insetLeft: CGFloat = configuration.leadingImage == nil ? 0 : 28
      let insetRight: CGFloat = configuration.trailingImage == nil ? 0 : 28
      let rect = bounds.inset(by: UIEdgeInsets(left: insetLeft, right: insetRight))
      let adjustedValue = translation.x / rect.width
      let newValue = min(max(0, initialValue + adjustedValue), 1)
      if configuration.sliderValue.value != newValue {
        configuration.sliderValue = SliderValue(value: newValue, animated: false)
        if newValue == 0 || newValue == 1 {
          feedback.selectionChanged(at: panGestureRecognizer.location(in: panGestureRecognizer.view))
        }
        sendActions(for: .valueChanged)
      }
    case .ended, .cancelled, .failed:
      configuration.isActive = false
      initialValue = nil
    default:
      break
    }
  }
}

// MARK: - JKSlider.Configuration

extension JKSlider {
  public struct Configuration {
    var sliderValue = SliderValue(value: 0, animated: false)
    var isActive: Bool = false

    public var leadingImage: UIImage?
    public var trailingImage: UIImage?
  }
}

// MARK: - JKSlider.SliderValue

extension JKSlider {
  struct SliderValue {
    let value: Double
    let animated: Bool
  }
}

// MARK: - JKSlider.ContentView

extension JKSlider {
  struct ContentView: View {
    let state: Configuration

    var body: some View {
      ZStack {
        HStack(spacing: 8) {
          if let leadingImage = state.leadingImage {
            Image(uiImage: leadingImage)
              .resizable()
              .renderingMode(.template)
              .aspectRatio(contentMode: .fit)
              .foregroundStyle(.tint)
              .frame(width: 20, height: 20)
          }

          ZStack {
            GeometryReader { proxy in
              Rectangle()
                .fill(.tint)
                .frame(width: proxy.size.width * state.sliderValue.value)
            }
          }
          .background(.tint.opacity(0.15))
          .frame(height: state.isActive ? 24 : 10)
          .clipShape(RoundedRectangle(cornerRadius: 12))

          if let trailingImage = state.trailingImage {
            Image(uiImage: trailingImage)
              .resizable()
              .renderingMode(.template)
              .aspectRatio(contentMode: .fit)
              .foregroundStyle(.tint)
              .frame(width: 20, height: 20)
          }
        }
        .animation(.just.smooth, value: state.isActive)
      }
      .frame(height: 40)
    }
  }
}

// MARK: - JKSlider Preview

@available(iOS 17.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
  JKSlider().then {
    $0.configuration.leadingImage = UIImage(systemName: "sun.min")
    $0.configuration.trailingImage = UIImage(systemName: "sun.max")
    $0.configuration.sliderValue = JKSlider.SliderValue(value: 0.5, animated: false)
  }
}
