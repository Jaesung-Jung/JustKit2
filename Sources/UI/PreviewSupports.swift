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

  public init(_ builder: @escaping () -> View) {
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

public final class PreviewContentView<Content: UIView>: UIView {
  public init(width: CGFloat? = nil, height: CGFloat? = nil, contentInsets: NSDirectionalEdgeInsets = .zero, contentView: () -> Content) {
    super.init(frame: .zero)

    let contentView = contentView()
    addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: topAnchor).then {
        $0.priority = UILayoutPriority(1)
      },
      contentView.leadingAnchor.constraint(equalTo: leadingAnchor).then {
        $0.priority = UILayoutPriority(1)
      },
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor).then {
        $0.priority = UILayoutPriority(1)
      },
      contentView.trailingAnchor.constraint(equalTo: trailingAnchor).then {
        $0.priority = UILayoutPriority(1)
      },
      contentView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: contentInsets.top),
      contentView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: contentInsets.leading),
      contentView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -contentInsets.bottom),
      contentView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -contentInsets.trailing)
    ])

    if let width {
      NSLayoutConstraint.activate([
        contentView.widthAnchor.constraint(equalToConstant: width)
      ])
    }
    if let height {
      NSLayoutConstraint.activate([
        contentView.heightAnchor.constraint(equalToConstant: height)
      ])
    }
  }

  public convenience init(size: CGSize, contentInsets: NSDirectionalEdgeInsets = .zero, contentView: @escaping () -> Content) {
    self.init(width: size.width, height: size.height, contentView: contentView)
  }

  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
}

// MARK: - PreviewViewController.PresentationStyle

extension PreviewViewController {
  public enum PresentationStyle {
    case root
    case push
    case present(UIModalPresentationStyle = .automatic)
  }
}

// MARK: - PreviewViewController.RootViewController

extension PreviewViewController {
  class RootViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .systemBackground
      navigationItem.backButtonDisplayMode = .minimal
    }
  }
}

#endif
