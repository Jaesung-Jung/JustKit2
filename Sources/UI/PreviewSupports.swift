//
//  PreviewSupports.swift
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

#if DEBUG

import SwiftUI

// MARK: - UIKitView

public struct UIKitView<View: UIView>: UIViewRepresentable {
  let view: View

  public init(_ builder: () -> View) {
    view = builder()
  }

  public func makeUIView(context: Context) -> View {
    return view
  }

  public func updateUIView(_ uiView: View, context: Context) {
    view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    view.setContentHuggingPriority(.defaultHigh, for: .vertical)
  }
}

// MARK: - PreviewContentView

public final class PreviewView<Content: UIView>: UIView {
  let width: SizeStrategy
  let height: SizeStrategy

  let contentView: Content
  let contentInsets: NSDirectionalEdgeInsets
  var isConstraintSet: Bool = false

  public convenience init(size: SizeStrategy, contentInsets: NSDirectionalEdgeInsets = .zero, makeContentView: () -> Content) {
    self.init(width: size, height: size, contentInsets: contentInsets, makeContentView: makeContentView)
  }

  public init(width: SizeStrategy = .fit, height: SizeStrategy = .fit, contentInsets: NSDirectionalEdgeInsets = .zero, makeContentView: () -> Content) {
    self.width = width
    self.height = height
    self.contentView = makeContentView().then {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    self.contentInsets = contentInsets
    super.init(frame: .zero)
    addSubview(contentView)
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
      contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func didMoveToWindow() {
    super.didMoveToWindow()
    guard let window, !isConstraintSet else {
      return
    }
    if case .fill = width {
      NSLayoutConstraint.activate([
        contentView.widthAnchor.constraint(equalToConstant: window.bounds.width - contentInsets.horizontal)
      ])
    } else if case .constant(let width) = width {
      NSLayoutConstraint.activate([
        contentView.widthAnchor.constraint(equalToConstant: width)
      ])
    }

    if case .fill = height {
      NSLayoutConstraint.activate([
        contentView.widthAnchor.constraint(equalToConstant: window.bounds.height - contentInsets.vertical)
      ])
    } else if case .constant(let height) = height {
      NSLayoutConstraint.activate([
        contentView.heightAnchor.constraint(equalToConstant: height)
      ])
    }
  }

  public enum SizeStrategy: ExpressibleByIntegerLiteral {
    case fit
    case fill
    case constant(CGFloat)

    public init(integerLiteral value: Int) {
      self = .constant(CGFloat(value))
    }
  }
}

// MARK: - PreviewViewController

public final class PreviewViewController: UINavigationController {
  let presentationStyle: PresentationStyle
  let viewController: UIViewController

  public init(presentationStyle: PresentationStyle = .root, prefersLargeTitles: Bool = true, makeViewController: () -> UIViewController) {
    self.presentationStyle = presentationStyle
    self.viewController = makeViewController()
    super.init(nibName: nil, bundle: nil)
    self.navigationBar.prefersLargeTitles = prefersLargeTitles
  }

  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    switch presentationStyle {
    case .root:
      pushViewController(viewController, animated: false)
    default:
      pushViewController(RootViewController(), animated: false)
    }
  }

  public override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    windowScene?.keyWindow?.backgroundColor = .black
    switch presentationStyle {
    case .present(let presentationStyle):
      viewController.modalPresentationStyle = presentationStyle
      present(viewController, animated: false)
    case .push:
      pushViewController(viewController, animated: false)
    case .root:
      break
    }
  }

  public enum PresentationStyle {
    case root
    case push
    case present(UIModalPresentationStyle = .automatic)
  }

  class RootViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .systemBackground
      navigationItem.backButtonDisplayMode = .minimal
    }
  }
}

#endif
