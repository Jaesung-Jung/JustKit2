//
//  JKTextFieldStyles.swift
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

// MARK: - JKTextField.Style

extension JKTextField {
  public enum Style {
    case plain
    case underline
    case bordered
    case rounded
    case floatingLabel
  }
}

// MARK: - JKTextField.TextFieldDecorationView

extension JKTextField {
  class TextFieldDecorationView: UIView {
    let placeholderLabel: UILabel
    var textObservation: NSKeyValueObservation?
    weak var textField: UITextField?
    var contentInsets: NSDirectionalEdgeInsets { .zero }

    init(placeholderLabel: UILabel) {
      self.placeholderLabel = placeholderLabel
      super.init(frame: .zero)
      self.isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    func animator() -> UIViewPropertyAnimator { .smooth() }

    func configure() {
      guard let textField else {
        return
      }
      textObservation = textField.observe(\.text, options: .new) { [weak self] _, change in
        guard let self else {
          return
        }
        if let newValue = change.newValue {
          Task {
            await MainActor.run {
              self.didChangeText(newValue)
            }
          }
        }
      }
      textField.addTarget(self, action: #selector(Self.editingDidBegin(_:)), for: .editingDidBegin)
      textField.addTarget(self, action: #selector(Self.editingDidEnd(_:)), for: .editingDidEnd)
      textField.addTarget(self, action: #selector(Self.editingChanged(_:)), for: .editingChanged)
    }

    override func layoutSubviews() {
      super.layoutSubviews()
      guard let textField else {
        return
      }
      placeholderLabel.frame = textField.textRect(forBounds: bounds)
    }

    func intrinsicContentSize(textFieldSize: CGSize, placeholderSize: CGSize) -> CGSize {
      let size = CGSize(
        width: max(textFieldSize.width, placeholderSize.width),
        height: max(textFieldSize.height, placeholderSize.height)
      )
      return CGSize(width: size.width + contentInsets.horizontal, height: size.height + contentInsets.vertical)
    }

    func textRect(for rect: CGRect) -> CGRect {
      return rect
    }

    func leftViewRect(for rect: CGRect) -> CGRect {
      return rect
    }

    func rightViewRect(for rect: CGRect) -> CGRect {
      return rect
    }

    func didChangeText(_ text: String?) {
      placeholderLabel.isHidden = text.map { !$0.isEmpty } ?? false
    }

    @objc func editingDidBegin(_ textField: UITextField) {
    }

    @objc func editingDidEnd(_ textField: UITextField) {
    }

    @objc func editingChanged(_ textField: UITextField) {
      didChangeText(textField.text)
    }
  }
}

// MARK: - JKTextField.UnderlineTextFieldDecorationView

extension JKTextField {
  class UnderlineTextFieldDecorationView: TextFieldDecorationView {
    let separatorView = UIView()
    let tintSeparatorView = UIView()
    override var contentInsets: NSDirectionalEdgeInsets { NSDirectionalEdgeInsets(bottom: 9) }

    override func configure() {
      super.configure()

      separatorView.backgroundColor = .placeholderText
      addSubview(separatorView)

      tintSeparatorView.backgroundColor = tintColor
      addSubview(tintSeparatorView)
    }

    override func tintColorDidChange() {
      super.tintColorDidChange()
      tintSeparatorView.backgroundColor = tintColor
    }

    override func layoutSubviews() {
      super.layoutSubviews()
      guard let textField else {
        return
      }
      separatorView.frame = CGRect(x: bounds.minX, y: bounds.maxY - 1, width: bounds.width, height: 1)
      if textField.isEditing {
        tintSeparatorView.frame = CGRect(x: bounds.minX, y: bounds.maxY - 2, width: bounds.width, height: 2)
      } else {
        tintSeparatorView.frame = CGRect(x: bounds.midX, y: bounds.maxY - 2, width: 0, height: 2)
      }
    }

    override func textRect(for rect: CGRect) -> CGRect {
      return CGRect(x: rect.minX, y: rect.minY - contentInsets.vertical * 0.5, width: rect.width, height: rect.height)
    }

    override func leftViewRect(for rect: CGRect) -> CGRect {
      return CGRect(x: rect.minX, y: rect.minY - contentInsets.vertical * 0.5, width: rect.width, height: rect.height)
    }

    override func rightViewRect(for rect: CGRect) -> CGRect {
      return CGRect(x: rect.minX, y: rect.minY - contentInsets.vertical * 0.5, width: rect.width, height: rect.height)
    }

    override func editingDidBegin(_ textField: UITextField) {
      super.editingDidBegin(textField)
      setNeedsLayout()

      let animator = animator()
      animator.addAnimations {
        self.layoutIfNeeded()
      }
      animator.startAnimation()
    }

    override func editingDidEnd(_ textField: UITextField) {
      super.editingDidEnd(textField)
      setNeedsLayout()

      let animator = animator()
      animator.addAnimations {
        self.layoutIfNeeded()
      }
      animator.startAnimation()
    }
  }
}

// MARK: - JKTextField.BorderedTextFieldDecorationView

extension JKTextField {
  class BorderedTextFieldDecorationView: TextFieldDecorationView {
    let tintBorderView = UIView()
    override var contentInsets: NSDirectionalEdgeInsets { NSDirectionalEdgeInsets(10) }

    override func configure() {
      super.configure()
      traitCollection.performAsCurrent {
        borderColor = .placeholderText
      }
      borderWidth = 1
      cornerRadius = 8
      cornerCurve = .continuous

      traitCollection.performAsCurrent {
        tintBorderView.borderColor = tintColor
      }
      tintBorderView.borderWidth = 2
      tintBorderView.cornerRadius = 8
      tintBorderView.cornerCurve = .continuous
      tintBorderView.alpha = 0
      addSubview(tintBorderView)
    }

    override func layoutSubviews() {
      super.layoutSubviews()
      tintBorderView.frame = bounds
    }

    override func textRect(for rect: CGRect) -> CGRect {
      guard let textField else {
        return rect
      }
      let hasLeftView = textField.leftView != nil
      let hasRightView = textField.rightView != nil
      return CGRect(
        x: rect.minX + (hasLeftView ? 0 : contentInsets.leading),
        y: rect.minY,
        width: rect.width - contentInsets.leading - (hasRightView ? 0 : contentInsets.trailing),
        height: rect.height
      )
    }

    override func leftViewRect(for rect: CGRect) -> CGRect {
      return CGRect(x: rect.minX + contentInsets.leading, y: rect.minY, width: rect.width, height: rect.height)
    }

    override func rightViewRect(for rect: CGRect) -> CGRect {
      return CGRect(x: rect.minX - contentInsets.trailing, y: rect.minY, width: rect.width, height: rect.height)
    }

    override func tintColorDidChange() {
      super.tintColorDidChange()
      traitCollection.performAsCurrent {
        tintBorderView.borderColor = tintColor
      }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      super.traitCollectionDidChange(previousTraitCollection)
      traitCollection.performAsCurrent {
        borderColor = .placeholderText
        tintBorderView.borderColor = tintColor
      }
    }

    override func editingDidBegin(_ textField: UITextField) {
      super.editingDidBegin(textField)
      let animator = animator()
      animator.addAnimations {
        self.tintBorderView.alpha = 1
      }
      animator.startAnimation()
    }

    override func editingDidEnd(_ textField: UITextField) {
      super.editingDidEnd(textField)
      let animator = animator()
      animator.addAnimations {
        self.tintBorderView.alpha = 0
      }
      animator.startAnimation()
    }
  }
}

// MARK: - JKTextField.RoundedTextFieldDecorationView

extension JKTextField {
  class RoundedTextFieldDecorationView: TextFieldDecorationView {
    override var contentInsets: NSDirectionalEdgeInsets { NSDirectionalEdgeInsets(10) }

    override func configure() {
      super.configure()
      backgroundColor = .gray.withAlphaComponent(0.12)
      cornerRadius = 8
      cornerCurve = .continuous
    }

    override func textRect(for rect: CGRect) -> CGRect {
      guard let textField else {
        return rect
      }
      let hasLeftView = textField.leftView != nil
      let hasRightView = textField.rightView != nil
      return CGRect(
        x: rect.minX + (hasLeftView ? 0 : contentInsets.leading),
        y: rect.minY,
        width: rect.width - contentInsets.leading - (hasRightView ? 0 : contentInsets.trailing),
        height: rect.height
      )
    }

    override func leftViewRect(for rect: CGRect) -> CGRect {
      return CGRect(x: rect.minX + contentInsets.leading, y: rect.minY, width: rect.width, height: rect.height)
    }

    override func rightViewRect(for rect: CGRect) -> CGRect {
      return CGRect(x: rect.minX - contentInsets.trailing, y: rect.minY, width: rect.width, height: rect.height)
    }
  }
}

// MARK: - JKTextField.FloatingTextFieldDecorationView

extension JKTextField {
  class FloatingTextFieldDecorationView: TextFieldDecorationView {
    let floatingScale: CGFloat = 0.75
    var isFloating: Bool {
      guard let textField else {
        return false
      }
      let hasText = textField.text.map { !$0.isEmpty } ?? false
      return textField.isEditing || hasText
    }

    override func layoutSubviews() {
      super.layoutSubviews()
      placeholderLabel.frame = placeholderRect(isFloating: isFloating)
    }

    override func intrinsicContentSize(textFieldSize: CGSize, placeholderSize: CGSize) -> CGSize {
      let width = max(textFieldSize.width, placeholderSize.width)
      let height = max(textFieldSize.height, placeholderSize.height)
      return CGSize(width: width, height: height + placeholderSize.height)
    }

    override func textRect(for rect: CGRect) -> CGRect {
      let placeholderSize = placeholderLabel.intrinsicContentSize
      return CGRect(x: rect.minX, y: rect.minY + placeholderSize.height * 0.5, width: rect.width, height: rect.height)
    }

    override func leftViewRect(for rect: CGRect) -> CGRect {
      let placeholderSize = placeholderLabel.intrinsicContentSize
      return CGRect(x: rect.minX, y: rect.minY + placeholderSize.height * 0.5, width: rect.width, height: rect.height)
    }

    override func rightViewRect(for rect: CGRect) -> CGRect {
      let placeholderSize = placeholderLabel.intrinsicContentSize
      return CGRect(x: rect.minX, y: rect.minY + placeholderSize.height * 0.5, width: rect.width, height: rect.height)
    }

    override func didChangeText(_ text: String?) {
      let animated = window != nil
      setFloating(isFloating, animated: animated)
    }

    override func editingDidBegin(_ textField: UITextField) {
      super.editingDidBegin(textField)
      setFloating(true, animated: true)
    }

    override func editingDidEnd(_ textField: UITextField) {
      super.editingDidEnd(textField)
      setFloating(isFloating, animated: true)
    }

    override func editingChanged(_ textField: UITextField) {
      didChangeText(textField.text)
    }

    func setFloating(_ isFloating: Bool, animated: Bool) {
      let transform = isFloating ? CGAffineTransform(scaleX: floatingScale, y: floatingScale) : .identity
      let color = isFloating ? tintColor : .placeholderText
      let frame = placeholderRect(isFloating: isFloating)
      let block: () -> Void = {
        self.placeholderLabel.transform = transform
        self.placeholderLabel.textColor = color
        self.placeholderLabel.frame = frame
      }
      if animated {
        let animator = animator()
        animator.addAnimations(block)
        animator.startAnimation()
      } else {
        block()
      }
    }

    func placeholderRect(isFloating: Bool) -> CGRect {
      guard let textField else {
        return .zero
      }
      let size = placeholderLabel.intrinsicContentSize
      let textRect = textField.textRect(forBounds: bounds)
      if isFloating {
        return CGRect(
          x: bounds.minX,
          y: bounds.minY,
          width: min(bounds.width, size.width),
          height: size.height
        )
      } else {
        return CGRect(
          x: textRect.minX,
          y: textRect.midY - size.height * 0.5,
          width: min(textRect.width, size.width),
          height: size.height
        )
      }
    }
  }
}
