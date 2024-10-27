//
//  FeedbackGenerator.swift
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

// MARK: - FeedbackGenerator

@MainActor
public class FeedbackGenerator<Generator: UIFeedbackGenerator> {
  let generator: Generator

  init(_ generator: Generator) {
    self.generator = generator
  }

  public func prepare() {
    generator.prepare()
  }
}

// MARK: - FeedbackGenerator (Creation)

extension FeedbackGenerator {
  public static func selection(view: UIView? = nil) -> FeedbackGenerator<UISelectionFeedbackGenerator> {
    let generator = if #available(iOS 17.5, *), let view {
      UISelectionFeedbackGenerator(view: view)
    } else {
      UISelectionFeedbackGenerator()
    }
    return FeedbackGenerator<UISelectionFeedbackGenerator>(generator)
  }

  public static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle, view: UIView? = nil) -> FeedbackGenerator<UIImpactFeedbackGenerator> {
    let generator = if #available(iOS 17.5, *), let view {
      UIImpactFeedbackGenerator(style: style, view: view)
    } else {
      UIImpactFeedbackGenerator(style: style)
    }
    return FeedbackGenerator<UIImpactFeedbackGenerator>(generator)
  }

  public static func notification(view: UIView? = nil) -> FeedbackGenerator<UINotificationFeedbackGenerator> {
    let generator = if #available(iOS 17.5, *), let view {
      UINotificationFeedbackGenerator(view: view)
    } else {
      UINotificationFeedbackGenerator()
    }
    return FeedbackGenerator<UINotificationFeedbackGenerator>(generator)
  }

  @available(iOS 17.5, *)
  public static func canvase(view: UIView) -> FeedbackGenerator<UICanvasFeedbackGenerator> {
    return FeedbackGenerator<UICanvasFeedbackGenerator>(UICanvasFeedbackGenerator(view: view))
  }
}

// MARK: - FeedbackGenerator<UISelectionFeedbackGenerator>

extension FeedbackGenerator where Generator == UISelectionFeedbackGenerator {
  public func selectionChanged(at location: CGPoint? = nil) {
    if #available(iOS 17.5, *), let location {
      generator.selectionChanged(at: location)
    } else {
      generator.selectionChanged()
    }
  }
}

// MARK: - FeedbackGenerator<UIImpactFeedbackGenerator>

extension FeedbackGenerator where Generator == UIImpactFeedbackGenerator {
  public func impactOccurred(intensity: CGFloat? = nil, at location: CGPoint? = nil) {
    if #available(iOS 17.5, *), let intensity, let location {
      generator.impactOccurred(intensity: intensity, at: location)
    } else if #available(iOS 17.5, *), let location {
      generator.impactOccurred(at: location)
    } else if let intensity {
      generator.impactOccurred(intensity: intensity)
    }  else {
      generator.impactOccurred()
    }
  }
}

// MARK: - FeedbackGenerator<UINotificationFeedbackGenerator>

extension FeedbackGenerator where Generator == UINotificationFeedbackGenerator {
  public func notificationOccurred(_ notificationType: UINotificationFeedbackGenerator.FeedbackType, at location: CGPoint? = nil) {
    if #available(iOS 17.5, *), let location {
      generator.notificationOccurred(notificationType, at: location)
    } else {
      generator.notificationOccurred(notificationType)
    }
  }
}

// MARK: - FeedbackGenerator<UICanvasFeedbackGenerator>

@available(iOS 17.5, *)
extension FeedbackGenerator where Generator == UICanvasFeedbackGenerator {
  public func alignmentOccurred(at location: CGPoint) {
    generator.alignmentOccurred(at: location)
  }

  public func pathCompleted(at location: CGPoint) {
    generator.pathCompleted(at: location)
  }
}
