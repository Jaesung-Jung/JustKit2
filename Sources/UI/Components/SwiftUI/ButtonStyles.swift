//
//  ButtonStyles.swift
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

// MARK: - ButtonContent

@MainActor protocol ButtonContent {
  associatedtype Label: View

  var componentSize: ComponentSize { get }
  var isEnabled: Bool { get }
  var label: Label { get }
  var role: ButtonRole? { get }
  var isPressed: Bool { get }
}

extension ButtonContent {
  func configuredLabel<Label: View>(@ViewBuilder label: () -> Label) -> some View {
    label()
      .font(componentSize.preferredFont.weight(weight))
      .scaleEffect(isPressed ? CGSize(width: 0.92, height: 0.92) : CGSize(width: 1, height: 1))
  }

  var animation: Animation { .smooth(duration: 0.3) }

  var weight: Font.Weight {
    switch componentSize {
    case .mini, .small:
      return .regular
    case .large, .extraLarge:
      return role == .cancel ? .regular : .bold
    default:
      return role == .cancel ? .regular : .semibold
    }
  }

  var padding: EdgeInsets {
    switch componentSize {
    case .mini, .small:
      return EdgeInsets(horizontal: 8, vertical: 6)
    case .large, .extraLarge:
      return EdgeInsets(horizontal: 12, vertical: 12)
    default:
      return EdgeInsets(horizontal: 10, vertical: 8)
    }
  }

  var baseShape: some ShapeStyle {
    guard isEnabled else {
      return AnyShapeStyle(.tertiary)
    }
    switch role {
    case .destructive:
      return AnyShapeStyle(.red)
    default:
      return AnyShapeStyle(.tint)
    }
  }
}

struct JustPrimitiveButton<Content: View>: View {
  @Environment(\.controlSize) var controlSize
  @Environment(\.isEnabled) var isEnabled
  @GestureState var isPressed: Bool = false
  @ViewBuilder var content: (ComponentSize, Bool, Bool) -> Content

  var body: some View {
    content(ComponentSize(controlSize), isPressed, isEnabled)
      .simultaneousGesture(DragGesture(minimumDistance: 0).updating($isPressed) { value, isPressed, _ in
        isPressed = value.translation == .zero
      })
  }
}

// MARK: - JustPlainButtonStyle

struct JustPlainButtonStyle: PrimitiveButtonStyle {
  @Environment(\.controlSize) var controlSize
  @Environment(\.isEnabled) var isEnabled

  func makeBody(configuration: Configuration) -> some View {
    JustPrimitiveButton {
      Content(
        label: configuration.label,
        role: configuration.role,
        componentSize: $0,
        isPressed: $1,
        isEnabled: $2
      )
    }
  }

  struct Content<Label: View>: ButtonContent, View {
    let label: Label
    let role: ButtonRole?
    let componentSize: ComponentSize
    let isPressed: Bool
    let isEnabled: Bool

    var body: some View {
      configuredLabel { label }
        .foregroundStyle(baseShape)
        .opacity(isPressed ? 0.5 : 1)
        .animation(animation, value: isPressed)
    }
  }
}

// MARK: - JustPickerButtonStyle

struct JustPickerButtonStyle: PrimitiveButtonStyle {
  @Environment(\.controlSize) var controlSize
  @Environment(\.isEnabled) var isEnabled

  func makeBody(configuration: Configuration) -> some View {
    JustPrimitiveButton {
      Content(
        label: configuration.label,
        role: configuration.role,
        componentSize: $0,
        isPressed: $1,
        isEnabled: $2
      )
    }
  }

  struct Content<Label: View>: ButtonContent, View {
    let label: Label
    let role: ButtonRole?
    let componentSize: ComponentSize
    let isPressed: Bool
    let isEnabled: Bool

    var body: some View {
      ZStack {
        if isPressed {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.systemGray5))
        }
        configuredLabel { label }
          .layoutPriority(1)
      }
      .foregroundStyle(baseShape)
      .animation(animation, value: isPressed)
    }
  }
}

// MARK: - JustFilledButtonStyle

struct JustFilledButtonStyle: PrimitiveButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    JustPrimitiveButton {
      Content(
        label: configuration.label,
        role: configuration.role,
        componentSize: $0,
        isPressed: $1,
        isEnabled: $2
      )
    }
  }

  struct Content<Label: View>: ButtonContent, View {
    let label: Label
    let role: ButtonRole?
    let componentSize: ComponentSize
    let isPressed: Bool
    let isEnabled: Bool

    var body: some View {
      ZStack {
        configuredLabel {
          RoundedRectangle(cornerRadius: 8)
            .fill(.primary)
          label
            .padding(padding)
            .foregroundStyle(.white)
            .layoutPriority(1)
        }
      }
      .foregroundStyle(baseShape)
      .animation(animation, value: isPressed)
    }
  }
}

// MARK: - JustTintedButtonStyle

struct JustTintedButtonStyle: PrimitiveButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    JustPrimitiveButton {
      Content(
        label: configuration.label,
        role: configuration.role,
        componentSize: $0,
        isPressed: $1,
        isEnabled: $2
      )
    }
  }

  struct Content<Label: View>: ButtonContent, View {
    let label: Label
    let role: ButtonRole?
    let componentSize: ComponentSize
    let isPressed: Bool
    let isEnabled: Bool

    var body: some View {
      ZStack {
        configuredLabel {
          RoundedRectangle(cornerRadius: 8)
            .fill(.quaternary)
          label
            .padding(padding)
            .layoutPriority(1)
        }
      }
      .foregroundStyle(baseShape)
      .animation(animation, value: isPressed)
    }
  }
}

// MARK: - JustBorderedButtonStyle

struct JustBorderedButtonStyle: PrimitiveButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    JustPrimitiveButton {
      Content(
        label: configuration.label,
        role: configuration.role,
        componentSize: $0,
        isPressed: $1,
        isEnabled: $2
      )
    }
  }

  struct Content<Label: View>: ButtonContent, View {
    let label: Label
    let role: ButtonRole?
    let componentSize: ComponentSize
    let isPressed: Bool
    let isEnabled: Bool

    var borderWidth: CGFloat {
      switch componentSize {
      case .mini, .small:
        return 1
      case .large, .extraLarge:
        return role == .cancel ? 2 : 2.5
      default:
        return role == .cancel ? 1 : 2
      }
    }

    var body: some View {
      ZStack {
        configuredLabel {
          RoundedRectangle(cornerRadius: 8)
            .strokeBorder(lineWidth: borderWidth)
          label
            .padding(padding)
            .layoutPriority(1)
          if isPressed {
            RoundedRectangle(cornerRadius: 8)
              .fill(.quaternary)
          }
        }
      }
      .foregroundStyle(baseShape)
      .animation(animation, value: isPressed)
    }
  }
}

// MARK: - ButtonStyle (Just)

extension PrimitiveButtonStyle where Self == JustButtonStyles  {
  public static var just: JustButtonStyles.Type { JustButtonStyles.self }
}

public struct JustButtonStyles: PrimitiveButtonStyle {
  public static var plain: some PrimitiveButtonStyle { JustPlainButtonStyle() }
  public static var picker: some PrimitiveButtonStyle { JustPickerButtonStyle() }
  public static var filled: some PrimitiveButtonStyle { JustFilledButtonStyle() }
  public static var tinted: some PrimitiveButtonStyle { JustTintedButtonStyle() }
  public static var bordered: some PrimitiveButtonStyle { JustBorderedButtonStyle() }

  public func makeBody(configuration: Configuration) -> some View {
    EmptyView()
  }
}

// MARK: - JustButtonStyle Preview

#Preview {
  let buttons: () -> some View = {
    VStack(spacing: 16) {
      ForEach(ControlSize.allCases, id: \.self) { controlSize in
        HStack {
          Spacer()

          Button("\(controlSize) Button") {
          }
          .controlSize(controlSize)

          Spacer()
        }
      }
    }
    .padding(.vertical, 16)
  }
  return NavigationStack {
    List {
      Section(".just.plain") {
        buttons()
      }
      .buttonStyle(.just.plain)
      .textCase(nil)

      Section(".just.picker") {
        buttons()
      }
      .buttonStyle(.just.picker)
      .textCase(nil)

      Section(".just.filled") {
        buttons()
      }
      .buttonStyle(.just.filled)
      .textCase(nil)

      Section(".just.tinted") {
        buttons()
      }
      .buttonStyle(.just.tinted)
      .textCase(nil)

      Section(".just.bordered") {
        buttons()
      }
      .buttonStyle(.just.bordered)
      .textCase(nil)
    }
    .navigationBarTitle("JustButtonStyles")
  }
}
