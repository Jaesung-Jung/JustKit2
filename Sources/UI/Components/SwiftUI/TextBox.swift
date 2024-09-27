//
//  TextBox.swift
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

// MARK: - TextBox

public struct TextBox<Label: View>: View {
  @Environment(\.font) var font
  @Environment(\.textBoxStyle) var textBoxStyle
  @FocusState var isFocused: Bool

  let label: Label
  let text: Binding<String>
  let textField: TextField<EmptyView>

  public var body: some View {
    textBoxStyle.makeBody(
      configuration: TextBoxStyleConfiguration(
        label: TextBoxStyleConfiguration.Label(content: label),
        textField: textField,
        text: text.wrappedValue,
        isFocused: isFocused
      )
    )
    .font(font ?? .body)
    .focused($isFocused)
  }
}

// MARK: - TextBox<Label> (Initializer)

extension TextBox {
  public init(text: Binding<String>, label: () -> Label) {
    self.label = label()
    self.text = text
    self.textField = TextField(text: text, prompt: nil, label: { EmptyView() })
  }

  public init(text: Binding<String>, axis: Axis, @ViewBuilder label: () -> Label) {
    self.label = label()
    self.text = text
    self.textField = TextField(text: text, prompt: nil, axis: axis, label: { EmptyView() })
  }

  public init<V>(value: Binding<V>, formatter: Formatter, @ViewBuilder label: () -> Label) {
    self.label = label()
    self.text = Binding(get: { formatter.string(for: value.wrappedValue) ?? "" }, set: { _ in })
    self.textField = TextField(value: value, formatter: formatter, prompt: nil, label: { EmptyView() })
  }

  public init<F: ParseableFormatStyle>(value: Binding<F.FormatInput>, format: F, @ViewBuilder label: () -> Label) where F.FormatOutput == String {
    self.label = label()
    self.text = Binding(get: { format.format(value.wrappedValue) }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
  }

  public init<F: ParseableFormatStyle>(value: Binding<F.FormatInput?>, format: F, @ViewBuilder label: () -> Label) where F.FormatOutput == String {
    let textFieldLabel = label()
    self.label = textFieldLabel
    self.text = Binding(get: { value.wrappedValue.map { format.format($0) } ?? "" }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
  }
}

// MARK: - TextBox<Text> (Initializer)

extension TextBox where Label == Text {
  public init(_ titleKey: LocalizedStringKey, text: Binding<String>) {
    self.label = Text(titleKey)
    self.text = text
    self.textField = TextField(text: text, prompt: nil, label: { EmptyView() })
  }

  public init<S: StringProtocol>(_ title: S, text: Binding<String>) {
    self.label = Text(title)
    self.text = text
    self.textField = TextField(text: text, prompt: nil, label: { EmptyView() })
  }

  public init(_ titleKey: LocalizedStringKey, text: Binding<String>, axis: Axis) {
    let textFieldLabel = Text(titleKey)
    self.label = textFieldLabel
    self.text = text
    self.textField = TextField(text: text, prompt: nil, axis: axis, label: { EmptyView() })
  }

  public init<S: StringProtocol>(_ title: S, text: Binding<String>, axis: Axis) {
    self.label = Text(title)
    self.text = text
    self.textField = TextField(text: text, prompt: nil, axis: axis, label: { EmptyView() })
  }

  public init<V>(_ titleKey: LocalizedStringKey, value: Binding<V>, formatter: Formatter) {
    self.label = Text(titleKey)
    self.text = Binding(get: { formatter.string(for: value.wrappedValue) ?? "" }, set: { _ in })
    self.textField = TextField(value: value, formatter: formatter, prompt: nil, label: { EmptyView() })
  }

  public init<S: StringProtocol, V>(_ title: S, value: Binding<V>, formatter: Formatter) {
    self.label = Text(title)
    self.text = Binding(get: { formatter.string(for: value.wrappedValue) ?? "" }, set: { _ in })
    self.textField = TextField(value: value, formatter: formatter, prompt: nil, label: { EmptyView() })
  }

  public init<F: ParseableFormatStyle>(_ titleKey: LocalizedStringKey, value: Binding<F.FormatInput>, format: F) where F.FormatOutput == String {
    self.label = Text(titleKey)
    self.text = Binding(get: { format.format(value.wrappedValue) }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
  }

  public init<F: ParseableFormatStyle>(_ titleKey: LocalizedStringKey, value: Binding<F.FormatInput?>, format: F) where F.FormatOutput == String {
    self.label = Text(titleKey)
    self.text = Binding(get: { value.wrappedValue.map { format.format($0) } ?? "" }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
  }

  public init<S: StringProtocol, F: ParseableFormatStyle>(_ title: S, value: Binding<F.FormatInput>, format: F) where F.FormatOutput == String {
    self.label = Text(title)
    self.text = Binding(get: { format.format(value.wrappedValue) }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
  }

  public init<S: StringProtocol, F: ParseableFormatStyle>(_ title: S, value: Binding<F.FormatInput?>, format: F) where F.FormatOutput == String {
    self.label = Text(title)
    self.text = Binding(get: { value.wrappedValue.map { format.format($0) } ?? "" }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
  }
}
