//
//  JKGradient.swift
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

// MARK: - JKGradient

public struct JKGradient {
  public typealias UnitPoint = SwiftUI.UnitPoint

  let shapeStyle: AnyShapeStyle

  init(_ shapeStyle: some ShapeStyle) {
    self.shapeStyle = AnyShapeStyle(shapeStyle)
  }

  @MainActor
  public static func linear(colors: [UIColor], start: UnitPoint, end: UnitPoint) -> JKGradient {
    JKGradient(
      .linearGradient(
        colors: colors.map(Color.init),
        startPoint: start,
        endPoint: end
      )
    )
  }

  @MainActor
  public static func linear(stops: [JKGradient.Stop], start: UnitPoint, end: UnitPoint) -> JKGradient {
    JKGradient(
      .linearGradient(
        stops: stops.map(\.stop),
        startPoint: start,
        endPoint: end
      )
    )
  }

  @MainActor
  public static func angular(colors: [UIColor], center: UnitPoint, startAngle: Double, endAngle: Double) -> JKGradient {
    JKGradient(
      .angularGradient(
        colors: colors.map(Color.init),
        center: center,
        startAngle: .radians(startAngle),
        endAngle: .radians(endAngle)
      )
    )
  }

  @MainActor
  public static func angular(stops: [JKGradient.Stop], center: UnitPoint, startAngle: Double, endAngle: Double) -> JKGradient {
    JKGradient(
      .angularGradient(
        stops: stops.map(\.stop),
        center: center,
        startAngle: .radians(startAngle),
        endAngle: .radians(endAngle)
      )
    )
  }

  @MainActor
  public static func conic(colors: [UIColor], center: UnitPoint, angle: Double = 0) -> JKGradient {
    JKGradient(
      .conicGradient(
        colors: colors.map(Color.init),
        center: center,
        angle: .radians(angle)
      )
    )
  }

  @MainActor
  public static func conic(stops: [JKGradient.Stop], center: UnitPoint, angle: Double = 0) -> JKGradient {
    JKGradient(
      .conicGradient(
        stops: stops.map(\.stop),
        center: center,
        angle: .radians(angle)
      )
    )
  }

  @MainActor
  public static func elliptical(colors: [UIColor], center: UnitPoint = .center, startRadiusFraction: CGFloat = 0, endRadiusFraction: CGFloat = 0.5) -> JKGradient {
    JKGradient(
      .ellipticalGradient(
        colors: colors.map(Color.init),
        center: center,
        startRadiusFraction: startRadiusFraction,
        endRadiusFraction: endRadiusFraction
      )
    )
  }

  @MainActor
  public static func elliptical(stops: [JKGradient.Stop], center: UnitPoint = .center, startRadiusFraction: CGFloat = 0, endRadiusFraction: CGFloat = 0.5) -> JKGradient {
    JKGradient(
      .ellipticalGradient(
        stops: stops.map(\.stop),
        center: center,
        startRadiusFraction: startRadiusFraction,
        endRadiusFraction: endRadiusFraction
      )
    )
  }

  @MainActor
  public static func radial(colors: [UIColor], center: UnitPoint, startRadius: CGFloat, endRadius: CGFloat) -> JKGradient {
    JKGradient(
      .radialGradient(
        colors: colors.map(Color.init),
        center: center,
        startRadius: startRadius,
        endRadius: endRadius
      )
    )
  }

  @MainActor
  public static func radial(stops: [JKGradient.Stop], center: UnitPoint, startRadius: CGFloat, endRadius: CGFloat) -> JKGradient {
    JKGradient(
      .radialGradient(
        stops: stops.map(\.stop),
        center: center,
        startRadius: startRadius,
        endRadius: endRadius
      )
    )
  }

  @available(iOS 18.0, *)
  @MainActor
  public static func mesh(width: Int, height: Int, points: [SIMD2<Float>], colors: [UIColor], background: UIColor = .clear, smoothsColors: Bool = true) -> JKGradient {
    let gradient = MeshGradient(
      width: width,
      height: height,
      points: points,
      colors: colors.map(Color.init),
      background: Color(background),
      smoothsColors: smoothsColors
    )
    return JKGradient(gradient)
  }
}

// MARK: - JKGradient.Stop

extension JKGradient {
  public struct Stop {
    let stop: Gradient.Stop

    public init(color: UIColor, location: CGFloat) {
      self.stop = Gradient.Stop(color: Color(uiColor: color), location: location)
    }
  }
}
