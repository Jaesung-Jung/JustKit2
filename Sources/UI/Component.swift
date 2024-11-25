//
//  Component.swift
//  Reader
//
//  Created by 정재성 on 5/24/24.
//

import UIKit

@MainActor
@dynamicMemberLookup
open class Component<Configuration>: UIView {
  private var _needsUpdateConfiguration = false

  public private(set) var previousConfiguration: Configuration?

  @available(iOS 17.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, *)
  open var supportedTraits: [UITrait] { [] }

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

  open override func willMove(toWindow newWindow: UIWindow?) {
    super.willMove(toWindow: newWindow)
    if newWindow != nil {
      updateConfigurationIfNeeded()
    }
  }

  open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    if #unavailable(iOS 17.0, macCatalyst 17.0, tvOS 17.0) {
      setNeedsUpdateConfiguration()
    }
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
