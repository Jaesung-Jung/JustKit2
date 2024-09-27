//
//  JKTextField.swift
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

// MARK: - JKTextField

@MainActor
open class JKTextField: UITextField {
  let placeholderLabel = UILabel()
  let decorationView: TextFieldDecorationView

  open override var placeholder: String? {
    get { placeholderLabel.text }
    set { placeholderLabel.text = newValue }
  }

  open override var attributedPlaceholder: NSAttributedString? {
    get { placeholderLabel.attributedText }
    set { placeholderLabel.attributedText = newValue }
  }

  open override var intrinsicContentSize: CGSize {
    decorationView.intrinsicContentSize(
      textFieldSize: super.intrinsicContentSize,
      placeholderSize: placeholderLabel.intrinsicContentSize
    )
  }

  public override init(frame: CGRect) {
    self.decorationView = TextFieldDecorationView(placeholderLabel: placeholderLabel)
    super.init(frame: frame)
    setup()

  }

  public required init?(coder: NSCoder) {
    self.decorationView = TextFieldDecorationView(placeholderLabel: placeholderLabel)
    super.init(coder: coder)
    setup()
  }

  public init(style: Style) {
    switch style {
    case .plain:
      self.decorationView = TextFieldDecorationView(placeholderLabel: placeholderLabel)
    case .underline:
      self.decorationView = UnderlineTextFieldDecorationView(placeholderLabel: placeholderLabel)
    case .bordered:
      self.decorationView = BorderedTextFieldDecorationView(placeholderLabel: placeholderLabel)
    case .rounded:
      self.decorationView = RoundedTextFieldDecorationView(placeholderLabel: placeholderLabel)
    case .floatingLabel:
      self.decorationView = FloatingTextFieldDecorationView(placeholderLabel: placeholderLabel)
    }
    super.init(frame: .zero)
    setup()
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    decorationView.frame = bounds
  }

  open override func textRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.textRect(forBounds: bounds)
    return decorationView.textRect(for: rect)
  }

  open override func editingRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.editingRect(forBounds: bounds)
    return decorationView.textRect(for: rect)
  }

  open override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.clearButtonRect(forBounds: bounds)
    return decorationView.rightViewRect(for: rect)
  }

  open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.leftViewRect(forBounds: bounds)
    return decorationView.leftViewRect(for: rect)
  }

  open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.rightViewRect(forBounds: bounds)
    return decorationView.rightViewRect(for: rect)
  }
}

// MARK: - JKTextField (Internal)

extension JKTextField {
  func setup() {
    decorationView.textField = self
    decorationView.configure()
    insertSubview(decorationView, at: 0)

    placeholderLabel.textColor = .placeholderText
    addSubview(placeholderLabel)
  }
}

// MARK: - JKTextField Preview

@available(iOS 17.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
  let styles: [JKTextField.Style] = [.plain, .underline, .bordered, .rounded, .floatingLabel]
  let makeTextField: (JKTextField.Style) -> JKTextField = { style in
    let textField = JKTextField(style: style)
    textField.placeholder = "\(style)"
    return textField
  }
  let stackView = UIStackView(arrangedSubviews: styles.map { makeTextField($0) })
  stackView.axis = .vertical
  stackView.spacing = 20
  stackView.translatesAutoresizingMaskIntoConstraints = false

  let vieWController = UIViewController()
  vieWController.view.addSubview(stackView)
  NSLayoutConstraint.activate([
    stackView.centerYAnchor.constraint(equalTo: vieWController.view.centerYAnchor),
    stackView.leadingAnchor.constraint(equalTo: vieWController.view.leadingAnchor, constant: 20),
    stackView.trailingAnchor.constraint(equalTo: vieWController.view.trailingAnchor, constant: -20)
  ])
  return vieWController
}
