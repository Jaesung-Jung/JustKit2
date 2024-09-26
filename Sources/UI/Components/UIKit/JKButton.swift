//
//  JKButton.swift
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

// MARK: - JKButton

@MainActor
public class JKButton: ControlComponent<JKButton.Configuration> {
  let contentView: StatefulHostingView<Configuration>

  public var menu: UIMenu? {
    didSet {
      isContextMenuInteractionEnabled = menu != nil
    }
  }

  public override var intrinsicContentSize: CGSize {
    contentView.intrinsicContentSize
  }

  public init() {
    let configuration = Configuration()
    self.contentView = StatefulHostingView(state: configuration) {
      Content(configuration: $0)
    }
    self.contentView.isUserInteractionEnabled = false
    super.init(configuration: configuration)
    addSubview(contentView)
  }

  public convenience init(image: UIImage?, style: Style? = nil, role: Role = .default, size: ComponentSize? = nil) {
    self.init()
    self.configuration.image = image
    self.configuration.role = role
    if let style {
      self.configuration.style = style
    }
    if let size {
      self.configuration.componentSize = size
    }
  }

  public convenience init(title: String?, style: Style? = nil, role: Role = .default, size: ComponentSize? = nil) {
    self.init()
    self.configuration.title = title
    self.configuration.role = role
    if let style {
      self.configuration.style = style
    }
    if let size {
      self.configuration.componentSize = size
    }
  }

  public convenience init(localizedTitle: String.LocalizationValue, style: Style? = nil, role: Role = .default, size: ComponentSize? = nil) {
    self.init(title: String(localized: localizedTitle), style: style, role: role, size: size)
  }

  public convenience init(image: UIImage?, title: String?, style: Style? = nil, role: Role = .default, size: ComponentSize? = nil) {
    self.init()
    self.configuration.image = image
    self.configuration.title = title
    self.configuration.role = role
    if let style {
      self.configuration.style = style
    }
    if let size {
      self.configuration.componentSize = size
    }
  }

  public convenience init(image: UIImage?, localizedTitle: String.LocalizationValue, style: Style? = nil, role: Role = .default, size: ComponentSize? = nil) {
    self.init(image: image, title: String(localized: localizedTitle), style: style, role: role, size: size)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = bounds
  }

  public override func updateConfiguration() {
    var mutableConfiguration = configuration
    mutableConfiguration.controlState = state
    contentView.state = mutableConfiguration
  }

  public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard gestureRecognizer is UITapGestureRecognizer else {
      return true
    }
    return false
  }

  public override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
    guard let menu else {
      return nil
    }
    return UIContextMenuConfiguration(previewProvider: nil) { _ in menu }
  }
}

// MARK: - JKButton.Configuration

extension JKButton {
  public struct Configuration {
    public var image: UIImage?
    public var imageAlignment: NSDirectionalRectEdge = .leading
    public var imageRenderingMode: UIImage.RenderingMode = .alwaysTemplate
    public var title: String?
    public var style: Style = .plain
    public var role: Role = .default
    public var componentSize: ComponentSize = .regular
    public var showsActivityIndicator: Bool = false

    var controlState: UIControl.State = .normal

    var fontWeight: UIFont.Weight {
      switch componentSize {
      case .mini, .small:
        return .regular
      case .large, .extraLarge:
        return role == .cancel ? .regular : .bold
      default:
        return role == .cancel ? .regular : .semibold
      }
    }
  }
}

// MARK: - JKButton.Style

extension JKButton {
  public enum Style {
    case plain
    case picker
    case filled
    case tinted
    case bordered
  }
}

// MARK: - JKButton.Role

extension JKButton {
  public enum Role {
    case `default`
    case destructive
    case cancel

    var buttonRole: ButtonRole? {
      switch self {
      case .default:
        return nil
      case .destructive:
        return .destructive
      case .cancel:
        return .cancel
      }
    }
  }
}

// MARK: - JKButton.Content

extension JKButton {
  struct Content: View {
    let configuration: Configuration
    @inlinable var componentSize: ComponentSize { configuration.componentSize }

    @inlinable var activityIndicatorSize: ControlSize {
      switch componentSize {
      case .mini, .small, .regular:
        return .mini
      default:
        return .regular
      }
    }

    var body: some View {
      Group {
        switch configuration.style {
        case .plain:
          JustPlainButtonStyle.Content(
            label: makeLabel(),
            role: configuration.role.buttonRole,
            componentSize: componentSize,
            isPressed: configuration.controlState.isHighlighted,
            isEnabled: configuration.controlState.isEnabled && !configuration.showsActivityIndicator
          )
        case .picker:
          JustPickerButtonStyle.Content(
            label: makeLabel(),
            role: configuration.role.buttonRole,
            componentSize: componentSize,
            isPressed: configuration.controlState.isHighlighted,
            isEnabled: configuration.controlState.isEnabled && !configuration.showsActivityIndicator
          )
        case .filled:
          JustFilledButtonStyle.Content(
            label: makeLabel(),
            role: configuration.role.buttonRole,
            componentSize: componentSize,
            isPressed: configuration.controlState.isHighlighted,
            isEnabled: configuration.controlState.isEnabled && !configuration.showsActivityIndicator
          )
        case .tinted:
          JustTintedButtonStyle.Content(
            label: makeLabel(),
            role: configuration.role.buttonRole,
            componentSize: componentSize,
            isPressed: configuration.controlState.isHighlighted,
            isEnabled: configuration.controlState.isEnabled && !configuration.showsActivityIndicator
          )
        case .bordered:
          JustBorderedButtonStyle.Content(
            label: makeLabel(),
            role: configuration.role.buttonRole,
            componentSize: componentSize,
            isPressed: configuration.controlState.isHighlighted,
            isEnabled: configuration.controlState.isEnabled && !configuration.showsActivityIndicator
          )
        }
      }
      .overlay {
        if configuration.showsActivityIndicator {
          ProgressView()
            .controlSize(activityIndicatorSize)
        }
      }
    }

    @inlinable func makeImage() -> (some View)? {
      configuration.image
        .map { ButtonImage(image: $0, configuration: configuration).layoutPriority(-1) }
    }

    @inlinable func makeText() -> Text? {
      configuration.title.map { Text($0) }
    }

    @inlinable func makeContent() -> some View {
      Group {
        switch configuration.imageAlignment {
        case .top:
          VStack(spacing: 4) {
            makeImage()
            makeText()
          }
        case .bottom:
          VStack(spacing: 4) {
            makeText()
            makeImage()
          }
        case .trailing:
          HStack(spacing: 6) {
            makeText()
            makeImage()
          }
        default:
          HStack(spacing: 6) {
            makeImage()
            makeText()
          }
        }
      }
    }

    func makeLabel() -> some View {
      HStack(spacing: 0) {
        Spacer(minLength: 0)
        makeContent()
          .opacity(configuration.showsActivityIndicator ? 0 : 1)
        Spacer(minLength: 0)
      }
    }
  }
}

// MARK: - JKButton.ButtonImage

extension JKButton {
  struct ButtonImage: UIViewRepresentable {
    let image: UIImage
    let configuration: Configuration

    func makeUIView(context: Context) -> UIImageView {
      UIImageView(image: image.withRenderingMode(configuration.imageRenderingMode))
    }

    func updateUIView(_ imageView: UIImageView, context: Context) {
      var symbolConfiguration = UIImage.SymbolConfiguration(
        font: configuration.componentSize.preferredUIFont.weight(configuration.fontWeight)
      )
      if !configuration.controlState.isEnabled {
        symbolConfiguration = symbolConfiguration.applying(.hierarchicalColor(.tertiaryLabel))
      } else if configuration.style == .filled {
        symbolConfiguration = symbolConfiguration.applying(.hierarchicalColor(.white))
      } else {
        switch configuration.role {
        case .destructive:
          symbolConfiguration = symbolConfiguration.applying(.hierarchicalColor(.red))
        default:
          symbolConfiguration = symbolConfiguration.applying(.hierarchicalColor(imageView.tintColor))
        }
      }
      imageView.preferredSymbolConfiguration = symbolConfiguration
    }

    func sizeThatFits(_ proposal: ProposedViewSize, imageView: UIImageView, context: Context) -> CGSize? {
      imageView.intrinsicContentSize
    }
  }
}

// MARK: - FUButton Preview

@available(iOS 17.0, macCatalyst 17.0, *)
#Preview {
  UIStackView(axis: .vertical, alignment: .center, spacing: 20) {
    JKButton(image: UIImage(systemName: "apple.logo"), title: "Button", style: .plain)
    JKButton(image: UIImage(systemName: "apple.logo"), title: "Button", style: .picker)
    JKButton(image: UIImage(systemName: "apple.logo"), title: "Button", style: .filled)
    JKButton(image: UIImage(systemName: "apple.logo"), title: "Button", style: .tinted)
    JKButton(image: UIImage(systemName: "apple.logo"), title: "Button", style: .bordered)
  }
}
