//
//  TextBoxStyles.swift
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

// MARK: - TextBoxStyle

public protocol TextBoxStyle {
  associatedtype Body: View
  typealias Configuration = TextBoxStyleConfiguration

  func makeBody(configuration: Configuration) -> Body
}

// MARK: - TextBoxStyleConfiguration

public struct TextBoxStyleConfiguration {
  let label: TextBoxStyleConfiguration.Label
  let textField: TextField<EmptyView>
  let text: String
  let isFocused: Bool

  var placeholderShape: some ShapeStyle {
    if #available(iOS 17.0, macCatalyst 17.0, *) {
      return .placeholder
    } else {
      return Color(.placeholderText)
    }
  }

  struct Label: View {
    var body: AnyView

    init<Content: View>(content: Content) {
      body = AnyView(content)
    }
  }
}

// MARK: - PlainTextBoxStyle

public struct PlainTextBoxStyle: TextBoxStyle {
  public init() {
  }

  public func makeBody(configuration: Configuration) -> some View {
    ZStack(alignment: .leading) {
      if configuration.text.isEmpty {
        configuration.label
          .foregroundStyle(configuration.placeholderShape)
      }
      configuration.textField
    }
  }
}

extension TextBoxStyle where Self == PlainTextBoxStyle {
  public static var plain: PlainTextBoxStyle { PlainTextBoxStyle() }
}

// MARK: - UnderlineTextBoxStyle

public struct UnderlineTextBoxStyle: TextBoxStyle {
  public init() {
  }

  public func makeBody(configuration: Configuration) -> some View {
    VStack(spacing: 8) {
      PlainTextBoxStyle()
        .makeBody(configuration: configuration)
      Rectangle()
        .fill(configuration.placeholderShape)
        .frame(height: 1)
        .overlay {
          Rectangle()
            .fill(.tint)
            .frame(height: 2)
            .scaleEffect(CGSize(width: configuration.isFocused ? 1 : 0, height: 1), anchor: .center)
        }
    }
    .animation(.just.smooth, value: configuration.isFocused)
  }
}

extension TextBoxStyle where Self == UnderlineTextBoxStyle {
  public static var underline: UnderlineTextBoxStyle { UnderlineTextBoxStyle() }
}

// MARK: - BorderedTextBoxStyle

public struct BorderedTextBoxStyle: TextBoxStyle {
  public init() {
  }

  public func makeBody(configuration: Configuration) -> some View {
    PlainTextBoxStyle()
      .makeBody(configuration: configuration)
      .padding(10)
      .background {
        ZStack {
          RoundedRectangle(cornerRadius: 8, style: .continuous)
            .strokeBorder(configuration.placeholderShape)
          RoundedRectangle(cornerRadius: 8, style: .continuous)
            .strokeBorder(.tint, lineWidth: 2)
            .opacity(configuration.isFocused ? 1 : 0)
        }
      }
      .animation(.just.smooth, value: configuration.isFocused)
  }
}

extension TextBoxStyle where Self == BorderedTextBoxStyle {
  public static var bordered: BorderedTextBoxStyle { BorderedTextBoxStyle() }
}

// MARK: - RoundedTextBoxStyle

public struct RoundedTextBoxStyle: TextBoxStyle {
  public init() {
  }

  public func makeBody(configuration: Configuration) -> some View {
    PlainTextBoxStyle()
      .makeBody(configuration: configuration)
      .padding(10)
      .background {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
          .fill(.gray.opacity(0.12))
      }
  }
}

extension TextBoxStyle where Self == RoundedTextBoxStyle {
  public static var rounded: RoundedTextBoxStyle { RoundedTextBoxStyle() }
}

// MARK: - FloatingLabelTextBoxStyle

public struct FloatingLabelTextBoxStyle: TextBoxStyle {
  let floatingScale: CGFloat = 0.75

  public init() {
  }

  func isFloating(_ configuration: Configuration) -> Bool {
    configuration.isFocused || !configuration.text.isEmpty
  }

  func scaleSize(_ configuration: Configuration) -> CGSize {
    isFloating(configuration) ? CGSize(width: floatingScale, height: floatingScale) : CGSize(width: 1, height: 1)
  }

  public func makeBody(configuration: Configuration) -> some View {
    FloatingLabelLayout(isFloating: isFloating(configuration), scale: floatingScale) {
      configuration.label
        .foregroundStyle(isFloating(configuration) ? AnyShapeStyle(.tint) : AnyShapeStyle(configuration.placeholderShape))
        .scaleEffect(scaleSize(configuration), anchor: .topLeading)
      configuration.textField
    }
    .animation(.just.smooth, value: configuration.isFocused)
  }

  struct FloatingLabelLayout: Layout {
    let isFloating: Bool
    let scale: CGFloat

    struct Cache {
      var x: CGFloat
      var y: CGFloat
      var width: CGFloat
      var height: CGFloat
    }

    func makeCache(subviews: Subviews) -> Cache {
      Cache(x: .zero, y: .zero, width: .zero, height: .zero)
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
      guard let label = subviews.first, let textField = subviews.last else {
        return .zero
      }
      let labelSize = label.sizeThatFits(proposal)
      let textFieldSize = textField.sizeThatFits(proposal)
      cache.x = 0
      cache.y = labelSize.height
      cache.width = max(labelSize.width, textFieldSize.width)
      cache.height = max(labelSize.height, textFieldSize.height)
      return CGSize(
        width: cache.width,
        height: cache.height + labelSize.height
      )
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
      guard let label = subviews.first, let textField = subviews.last else {
        return
      }
      let rect = CGRect(
        x: bounds.minX + cache.x,
        y: bounds.minY + cache.y,
        width: cache.width,
        height: cache.height
      )
      let anchorPoint = CGPoint(x: rect.minX, y: rect.midY)
      textField.place(at: anchorPoint, anchor: .leading, proposal: proposal)

      if isFloating {
        label.place(at: bounds.topLeft, anchor: .topLeading, proposal: proposal)
      } else {
        label.place(at: anchorPoint, anchor: .leading, proposal: proposal)
      }
    }
  }
}

extension TextBoxStyle where Self == FloatingLabelTextBoxStyle {
  public static var floatingLabel: FloatingLabelTextBoxStyle { FloatingLabelTextBoxStyle() }
}

// MARK: - AnyTextBoxStyle

struct AnyTextBoxStyle: TextBoxStyle {
  private let body: (Configuration) -> AnyView

  init<S: TextBoxStyle>(_ style: S) {
    self.body = { AnyView(style.makeBody(configuration: $0)) }
  }

  func makeBody(configuration: Configuration) -> some View {
    body(configuration)
  }
}

// MARK: - TextBoxStyle Environment

struct TextBoxStyleKey: EnvironmentKey {
  static var defaultValue: AnyTextBoxStyle { AnyTextBoxStyle(PlainTextBoxStyle()) }
}

extension EnvironmentValues {
  var textBoxStyle: AnyTextBoxStyle {
    get { self[TextBoxStyleKey.self] }
    set { self[TextBoxStyleKey.self] = newValue }
  }
}

// MARK: - TextBoxStyle Modifier

extension View {
  public func textBoxStyle<S: TextBoxStyle>(_ style: S) -> some View {
    environment(\.textBoxStyle, AnyTextBoxStyle(style))
  }
}

// MARK: - TextBoxStyle Preview

@available(iOS 17.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
  let header: (String) -> some View = {
    Text($0)
      .font(.caption)
      .fontDesign(.monospaced)
      .textCase(nil)
      .padding(4)
      .foregroundStyle(.tint)
      .background(.tint.opacity(0.12))
      .cornerRadius(4)
      .listRowInsets(EdgeInsets(bottom: 8))
  }
  return NavigationStack {
    List {
      Section {
        TextBox("TextBox", text: .constant(""))
        TextBox("TextBox", text: .constant("Text"))
      } header: {
        header(".plain")
      }
      .textBoxStyle(.plain)
      .listRowSeparator(.hidden)

      Section {
        TextBox("TextBox", text: .constant(""))
        TextBox("TextBox", text: .constant("Text"))
      } header: {
        header(".underline")
      }
      .textBoxStyle(.underline)
      .listRowSeparator(.hidden)

      Section {
        TextBox("TextBox", text: .constant(""))
        TextBox("TextBox", text: .constant("Text"))
      } header: {
        header(".bordered")
      }
      .textBoxStyle(.bordered)
      .listRowSeparator(.hidden)

      Section {
        TextBox("TextBox", text: .constant(""))
        TextBox("TextBox", text: .constant("Text"))
      } header: {
        header(".rounded")
      }
      .textBoxStyle(.rounded)
      .listRowSeparator(.hidden)

      Section {
        TextBox("TextBox", text: .constant(""))
        TextBox("TextBox", text: .constant("Text"))
      } header: {
        header(".floatingLabel")
      }
      .textBoxStyle(.floatingLabel)
      .listRowSeparator(.hidden)
    }
    .navigationTitle("TextBox Preview")
  }
}
