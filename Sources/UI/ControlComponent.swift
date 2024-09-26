//
//  ControlComponent.swift
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

@MainActor
@dynamicMemberLookup
open class ControlComponent<Configuration>: UIControl {
  private var _needsUpdateConfiguration = false

  public private(set) var previousConfiguration: Configuration?

  public private(set) var hitTestOutset: NSDirectionalEdgeInsets = .zero

  @available(iOS 17.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, *)
  open var supportedTraits: [UITrait] { [] }

  open override var isHighlighted: Bool {
    didSet {
      setNeedsUpdateConfiguration()
    }
  }

  open override var isSelected: Bool {
    didSet {
      setNeedsUpdateConfiguration()
    }
  }

  open override var isEnabled: Bool {
    didSet {
      setNeedsUpdateConfiguration()
    }
  }

  open var configuration: Configuration {
    didSet {
      if !_needsUpdateConfiguration {
        previousConfiguration = oldValue
      }
      setNeedsUpdateConfiguration()
    }
  }

  public init(configuration: Configuration) {
    self.configuration = configuration
    super.init(frame: .zero)
    setNeedsUpdateConfiguration()
    if #available(iOS 17.0, macCatalyst 17.0, *), !supportedTraits.isEmpty {
      registerForTraitChanges(supportedTraits) { (self: Self, _) in
        self.setNeedsUpdateConfiguration()
      }
    }
  }

  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    if #unavailable(iOS 17.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0) {
      setNeedsUpdateConfiguration()
    }
  }

  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    guard hitTestOutset != .zero else {
      return super.point(inside: point, with: event)
    }
    return bounds.inset(by: -convert(hitTestOutset)).contains(point)
  }

  open func setNeedsUpdateConfiguration() {
    guard !_needsUpdateConfiguration else {
      return
    }
    _needsUpdateConfiguration = true
    DispatchQueue.main.async {
      self.updateConfigurationIfNeeded()
    }
  }

  open func updateConfigurationIfNeeded() {
    guard _needsUpdateConfiguration else {
      return
    }
    updateConfiguration()
    _needsUpdateConfiguration = false
    invalidateIntrinsicContentSize()
  }

  open func updateConfiguration() {
  }

  open func setHitTestOutset(_ outset: NSDirectionalEdgeInsets) {
    hitTestOutset = outset
  }

  open func setHitTestOutset(_ outset: CGFloat) {
    hitTestOutset = NSDirectionalEdgeInsets(top: outset, leading: outset, bottom: outset, trailing: outset)
  }

  public subscript<T>(dynamicMember keyPath: KeyPath<Configuration, T>) -> T {
    configuration[keyPath: keyPath]
  }

  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Configuration, T>) -> T {
    get {
      configuration[keyPath: keyPath]
    }
    set {
      configuration[keyPath: keyPath] = newValue
    }
  }
}
