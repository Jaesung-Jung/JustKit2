//
//  UIKit+Extension.swift
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
import JustFoundation

// MARK: - UIView (CALayer)

extension UIView {
  /// The radius to use when drawing rounded corners for the view’s layer.
  @objc public dynamic var cornerRadius: CGFloat {
    get { layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }

  /// The corners of the layer that you want to round.
  @objc public dynamic var maskedCorners: CACornerMask {
    get { layer.maskedCorners }
    set { layer.maskedCorners = newValue }
  }

  /// The style of the corner rounding for the layer.
  @objc public dynamic var cornerCurve: CALayerCornerCurve {
    get { layer.cornerCurve }
    set { layer.cornerCurve = newValue }
  }

  /// The width of the view’s layer border.
  @objc public dynamic var borderWidth: CGFloat {
    get { layer.borderWidth }
    set { layer.borderWidth = newValue }
  }

  /// The color of the view’s layer border.
  @objc public dynamic var borderColor: UIColor? {
    get { layer.borderColor.map { UIColor(cgColor: $0) } }
    set { layer.borderColor = newValue?.cgColor }
  }

  /// Adds the specified `CALayer` as a sublayer of the view’s layer.
  ///
  /// - Parameter sublayer: The `CALayer` to add as a sublayer to the view's layer.
  @inlinable public func addSublayer(_ sublayer: CALayer) {
    layer.addSublayer(sublayer)
  }
}

// MARK: - UIView (Shadow)

extension UIView {
  /// Accesses the `Shadow` object for modifying the shadow properties of the view's layer.
  public var shadow: UIView.Shadow { UIView.Shadow(layer) }

  /// A class that encapsulates the shadow-related properties of a `CALayer`.
  public class Shadow {
    let layer: CALayer

    /// Initializes the `Shadow` object with the provided `CALayer`.
    init(_ layer: CALayer) {
      self.layer = layer
    }

    /// The color of the shadow.
    public var color: UIColor? {
      get { layer.shadowColor.map { UIColor(cgColor: $0) } }
      set { layer.shadowColor = newValue?.cgColor }
    }

    /// The opacity of the shadow.
    public var opacity: Float {
      get { layer.shadowOpacity }
      set { layer.shadowOpacity = newValue }
    }

    /// The offset of the shadow.
    public var offset: CGSize {
      get { layer.shadowOffset }
      set { layer.shadowOffset = newValue }
    }

    /// The blur radius used to render the shadow.
    public var radius: CGFloat {
      get { layer.shadowRadius }
      set { layer.shadowRadius = newValue }
    }

    /// The shape of the shadow cast by the layer.
    public var path: UIBezierPath? {
      get { layer.shadowPath.map { UIBezierPath(cgPath: $0) } }
      set { layer.shadowPath = newValue?.cgPath }
    }
  }
}

// MARK: - UIView (Convert)

extension UIView {
  /// Converts an `NSDirectionalEdgeInsets` to a `UIEdgeInsets`, adjusting for the view's layout direction.
  /// This method converts the `NSDirectionalEdgeInsets` (which accounts for leading and trailing directions) to a
  /// `UIEdgeInsets` by taking into consideration the view's current layout direction (left-to-right or right-to-left).
  ///
  /// - Parameter directionalEdgeInsets: The `NSDirectionalEdgeInsets` to be converted.
  /// - Returns: A `UIEdgeInsets` object where the `leading` and `trailing` values are mapped to `left` and `right`, based on the view's layout direction.
  public func convert(_ directionalEdgeInsets: NSDirectionalEdgeInsets) -> UIEdgeInsets {
    switch effectiveUserInterfaceLayoutDirection {
    case .rightToLeft:
      return UIEdgeInsets(
        top: directionalEdgeInsets.top,
        left: directionalEdgeInsets.trailing,
        bottom: directionalEdgeInsets.bottom,
        right: directionalEdgeInsets.leading
      )
    default:
      return UIEdgeInsets(
        top: directionalEdgeInsets.top,
        left: directionalEdgeInsets.leading,
        bottom: directionalEdgeInsets.bottom,
        right: directionalEdgeInsets.trailing
      )
    }
  }
}

// MARK: - UIResponder (Scene)

extension UIResponder {
  /// This computed property traverses the responder chain to find a `UIWindowScene` instance.
  public var windowScene: UIWindowScene? {
    func findWindowScene(_ responder: UIResponder?) -> UIWindowScene? {
      guard let responder else {
        return nil
      }
      if let windowScene = responder as? UIWindowScene {
        return windowScene
      }
      // Tail Recursion Optimize
      return findWindowScene(responder.next)
    }
    return findWindowScene(self)
  }
}

// MARK: - UIControl.State

extension UIControl.State {
  /// A Boolean value that indicates whether the control is currently highlighted.
  @inlinable public var isHighlighted: Bool { contains(.highlighted) }

  /// A Boolean value that indicates whether the control is currently selected.
  @inlinable public var isSelected: Bool { contains(.selected) }

  /// A Boolean value that indicates whether the control is currently enabled.
  @inlinable public var isEnabled: Bool { !contains(.disabled) }

  /// A Boolean value that indicates whether the control is currently disabled.
  @inlinable public var isDisabled: Bool { contains(.disabled) }

  /// A Boolean value that indicates whether the control is currently focused.
  @inlinable public var isFocued: Bool { contains(.focused) }
}

// MARK: - UIStackView

extension UIStackView {
  /// Initializes a `UIStackView` with specified axis, distribution, alignment, spacing, and optional arranged subviews.
  ///
  /// - Parameters:
  ///   - axis: The axis along which the arranged views are laid out. Either `.horizontal` or `.vertical`.
  ///   - distribution: The distribution of the arranged views along the stack view’s axis. Defaults to `.fill`.
  ///   - alignment: The alignment of the arranged views perpendicular to the stack view’s axis. Defaults to `.fill`.
  ///   - spacing: The distance between adjacent arranged views. Defaults to `0`.
  ///   - arrangedSubviews: An optional array of views to be added as arranged subviews. Defaults to `nil`.
  public convenience init(
    axis: NSLayoutConstraint.Axis,
    distribution: UIStackView.Distribution = .fill,
    alignment: UIStackView.Alignment = .fill,
    spacing: CGFloat = 0,
    arrangedSubviews: [UIView]? = nil
  ) {
    self.init(frame: .zero)
    self.axis = axis
    self.distribution = distribution
    self.alignment = alignment
    self.spacing = spacing
    if let arrangedSubviews {
      addArrangedSubviews(arrangedSubviews)
    }
  }

  /// Initializes a `UIStackView` with the specified axis, distribution, alignment, spacing, and arranged subviews built using an `@ArrayBuilder`.
  ///
  /// - Parameters:
  ///   - axis: The axis along which the arranged views are laid out. Either `.horizontal` or `.vertical`.
  ///   - distribution: The distribution of the arranged views along the stack view’s axis. Defaults to `.fill`.
  ///   - alignment: The alignment of the arranged views perpendicular to the stack view’s axis. Defaults to `.fill`.
  ///   - spacing: The distance between adjacent arranged views. Defaults to `0`.
  ///   - build: A closure that returns an array of `UIView` instances to be added as arranged subviews, built using the `@ArrayBuilder` syntax.
  public convenience init(
    axis: NSLayoutConstraint.Axis,
    distribution: UIStackView.Distribution = .fill,
    alignment: UIStackView.Alignment = .fill,
    spacing: CGFloat = 0,
    @ArrayBuilder<UIView> build: () -> [UIView]
  ) {
    self.init(
      axis: axis,
      distribution: distribution,
      alignment: alignment,
      spacing: spacing,
      arrangedSubviews: build()
    )
  }

  /// Adds an array of views to the arrangedSubviews of the stack view.
  ///
  /// - Parameter subviews: An array of `UIView` instances to be added as arranged subviews.
  @inlinable public func addArrangedSubviews(_ subviews: [UIView]) {
    for subview in subviews {
      addArrangedSubview(subview)
    }
  }

  /// Adds a variadic list of views to the arrangedSubviews of the stack view.
  ///
  /// - Parameter subviews: A variadic list of `UIView` instances to be added as arranged subviews.
  @inlinable public func addArrangedSubviews(_ subviews: UIView...) {
    for subview in subviews {
      addArrangedSubview(subview)
    }
  }

  /// Adds arranged subviews to the stack view using an `@ArrayBuilder` closure.
  ///
  /// - Parameter build: A closure that returns an array of `UIView` instances to be added as arranged subviews, constructed using the `@ArrayBuilder` syntax.
  @inlinable public func addArrangedSubviews(@ArrayBuilder<UIView> build: () -> [UIView]) {
    addArrangedSubviews(build())
  }
}

// MARK: - UIColor (Components)

extension UIColor {
  /// Extracts the RGBA components (red, green, blue, and alpha) of the color.
  ///
  /// - Returns: The `RGBAComponents` of the color, containing the red, green, blue, and alpha values as `CGFloat`s.
  public func rgba() -> UIColor.RGBAComponents {
    var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
    getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    return UIColor.RGBAComponents(red: red, green: green, blue: blue, alpha: alpha)
  }

  /// Extracts the HSBA components (hue, saturation, brightness, and alpha) of the color.
  ///
  /// - Returns: The `HSBAComponents` of the color, containing the hue, saturation, brightness, and alpha values as `CGFloat`s.
  public func hsba() -> UIColor.HSBAComponents {
    var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
    return UIColor.HSBAComponents(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
  }

  /// A structure representing the red, green, blue, and alpha components of a color.
  public struct RGBAComponents {
    public let red: CGFloat
    public let green: CGFloat
    public let blue: CGFloat
    public let alpha: CGFloat

    /// A `UIColor` from the RGBA components.
    @inlinable public var color: UIColor {
      UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
  }

  /// A structure representing the hue, saturation, brightness, and alpha components of a color.
  public struct HSBAComponents {
    public let hue: CGFloat
    public let saturation: CGFloat
    public let brightness: CGFloat
    public let alpha: CGFloat

    /// A `UIColor` from the HSBA components.
    @inlinable public var color: UIColor {
      UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
  }
}

// MARK: - UIFont (Weight)

extension UIFont {
  /// Returns a new font with the specified weight applied.
  ///
  /// - Parameter weight: The `UIFont.Weight` to apply to the font.
  /// - Returns: A new `UIFont` instance with the specified weight.
  public func weight(_ weight: UIFont.Weight) -> UIFont {
    return UIFont(
      descriptor: fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]]),
      size: pointSize
    )
  }
}

// MARK: - UIImage (Color)

extension UIImage {
  /// Creates a `UIImage` of the specified color, size, and scale.
  ///
  /// - Parameters:
  ///   - color: The `UIColor` to use for filling the image.
  ///   - size: The size of the generated image. Defaults to `CGSize(width: 1, height: 1)`.
  ///   - scale: The scale factor to apply to the image. Defaults to `1`.
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1), scale: CGFloat = 1) {
    let opaque = color.rgba().alpha == 1 ? true : false
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
    defer {
      UIGraphicsEndImageContext()
    }
    guard let context = UIGraphicsGetCurrentContext() else {
      return nil
    }
    context.setFillColor(color.cgColor)
    context.fill(CGRect(origin: .zero, size: size))
    guard let cgImage = context.makeImage() else {
      return nil
    }
    self.init(cgImage: cgImage)
  }
}

// MARK: - UIImage (Grayscale)

extension UIImage {
  /// Converts the current image to grayscale.
  ///
  /// - Returns: A new `UIImage` in grayscale, or `nil` if the conversion fails.
  public func grayscale() -> UIImage? {
    guard let cgImage else {
      return nil
    }
    let width = cgImage.width
    let height = cgImage.height
    let context = CGContext(
      data: nil,
      width: width,
      height: height,
      bitsPerComponent: 8,
      bytesPerRow: width,
      space: CGColorSpaceCreateDeviceGray(),
      bitmapInfo: CGImageAlphaInfo.none.rawValue
    )
    guard let context else {
      return nil
    }
    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    return context.makeImage().map { UIImage(cgImage: $0) }
  }
}

// MARK: - UIImage (Resize)

extension UIImage {
  /// Resizes the image to fit within the given bounds, maintaining the original aspect ratio.
  ///
  /// - Parameter boundsSize: The size within which the image should fit.
  /// - Returns: A new resized `UIImage`, or `nil` if the resizing fails.
  public func resize(in boundsSize: CGSize) -> UIImage? {
    let ratio = min(boundsSize.width / size.width, boundsSize.height / size.height)
    return resize(to: CGSize(width: size.width * ratio, height: size.height * ratio))
  }

  /// Resizes the image to the specified size.
  ///
  /// - Parameter size: The new size of the image.
  /// - Returns: A new resized `UIImage`, or `nil` if the resizing fails.
  public func resize(to size: CGSize) -> UIImage? {
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }
}

// MARK: - UIImage (Crop)

extension UIImage {
  /// Crops the image to the specified rectangle.
  ///
  /// - Parameter rect: A `CGRect` specifying the area of the image to crop.
  /// - Returns: A new cropped `UIImage`, or `nil` if the cropping fails.
  public func cropping(to rect: CGRect) -> UIImage? {
    let transformedRect: CGRect
    switch imageOrientation {
    case .left, .leftMirrored:
      transformedRect = CGRect(
        x: size.height - rect.maxY,
        y: rect.minX,
        width: rect.height,
        height: rect.width
      )
    case .right, .rightMirrored:
      transformedRect = CGRect(
        x: rect.minY,
        y: size.width - rect.maxX,
        width: rect.height,
        height: rect.width
      )
    case .down, .downMirrored:
      transformedRect = CGRect(
        x: size.width - rect.maxX,
        y: size.height - rect.maxY,
        width: rect.width,
        height: rect.height
      )
    default:
      transformedRect = rect
    }
    return cgImage
      .flatMap { $0.cropping(to: transformedRect) }
      .map { UIImage(cgImage: $0, scale: scale, orientation: imageOrientation) }
  }
}

// MARK: - UIImage.Configuration (Creation)

extension UIImage.Configuration {
  /// Creates a configuration object with the specified scale information.
  ///
  /// - Parameter scale: The symbol image scale variant to select. Use this parameter to make the image appear bigger or smaller than surrounding content. For a list of possible values, see UIImage.SymbolScale.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func pointSize(_ scale: UIImage.SymbolScale) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(scale: scale)
  }

  /// Creates a configuration object with the specified point-size information.
  ///
  /// - Parameter pointSize: The system font point size to use for the configuration.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func pointSize(_ pointSize: CGFloat) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(pointSize: pointSize)
  }

  /// Creates a configuration object with the specified weight information.
  ///
  /// - Parameter weight: The symbol image weight variant to select. Specify a value that is comparable to the font weight of any matching text. For a list of possible values, see UIImage.SymbolWeight.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func weight(_ weight: UIImage.SymbolWeight) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(weight: weight)
  }

  /// Creates a configuration object with the specified point-size and weight information.
  ///
  /// - Parameters:
  ///   - pointSize: The system font point size to use for the configuration.
  ///   - weight: The symbol image weight variant to select. Specify a value that is comparable to the font weight of any matching text. For a list of possible values, see UIImage.SymbolWeight.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func pointSize(_ pointSize: CGFloat, weight: UIImage.SymbolWeight) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight)
  }

  /// Creates a configuration object with the specified point-size and weight information.
  ///
  /// - Parameters:
  ///   - pointSize: The system font point size to use for the configuration.
  ///   - weight: The symbol image weight variant to select. Specify a value that is comparable to the font weight of any matching text. For a list of possible values, see UIImage.SymbolWeight.
  ///   - scale: The symbol image scale variant to select. Use this parameter to make the image appear bigger or smaller than text that uses the same point size. For a list of possible values, see UIImage.SymbolScale.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func pointSize(_ pointSize: CGFloat, weight: UIImage.SymbolWeight, scale: UIImage.SymbolScale) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
  }

  /// Creates a configuration object with the specified point-size and weight information.
  ///
  /// - Parameter textStyle: The system text styles that support Dynamic Type. For a list of possible values, see UIFont.TextStyle.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func textStyle(_ textStyle: UIFont.TextStyle) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(textStyle: textStyle)
  }

  /// Creates a configuration object with the specified point-size and weight information.
  ///
  /// - Parameters:
  ///   - textStyle: The system text styles that support Dynamic Type. For a list of possible values, see UIFont.TextStyle.
  ///   - scale: The symbol image scale variant to select. Use this parameter to make the image appear bigger or smaller than text that uses the same text style. For a list of possible values, see UIImage.SymbolScale.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func textStyle(_ textStyle: UIFont.TextStyle, scale: UIImage.SymbolScale) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(textStyle: textStyle, scale: scale)
  }

  /// Creates a configuration object with the specified point-size and weight information.
  ///
  /// - Parameter font: The font from which to derive the configuration attributes.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func font(_ font: UIFont) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(font: font)
  }

  /// Creates a configuration object with the specified point-size and weight information.
  ///
  /// - Parameters:
  ///   - font: The font from which to derive the configuration attributes.
  ///   - scale: The symbol image scale variant to select. Use this parameter to make the image appear bigger or smaller than text that uses the same font. For a list of possible values, see UIImage.SymbolScale.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func font(_ font: UIFont, scale: UIImage.SymbolScale) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(font: font, scale: scale)
  }

  /// Creates a configuration object with the specified point-size and weight information.
  ///
  /// - Parameter hierarchicalColor: The colors to apply to the symbol.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func hierarchicalColor(_ hierarchicalColor: UIColor) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(hierarchicalColor: hierarchicalColor)
  }

  /// Creates a configuration object with the specified point-size and weight information.
  ///
  /// - Parameter paletteColors: The colors to apply to the symbol.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func paletteColors(_ paletteColors: [UIColor]) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(paletteColors: paletteColors)
  }

  /// Creates a configuration object with the specified point-size and weight information.
  ///
  /// - Parameter scale: The symbol image scale variant to select. Use this parameter to make the image appear bigger or smaller than surrounding content. For a list of possible values, see UIImage.SymbolScale.
  /// - Returns: A new symbol configuration object with the specified information.
  @inlinable public static func scale(_ scale: UIImage.SymbolScale) -> UIImage.SymbolConfiguration {
    UIImage.SymbolConfiguration(scale: scale)
  }
}

// MARK: - UISpringTimingParameters

extension UISpringTimingParameters {
  /// Creates a spring animation timing parameter with the specified duration, bounce, and initial velocity.
  ///
  /// - Parameters:
  ///   - duration: The total duration of the animation.
  ///   - bounce: The amount of bounce for the animation. A positive value indicates less damping, while a negative value increases damping.
  ///   - initialVelocity: The initial velocity of the animation, expressed as a `CGVector`.
  /// - Returns: A `UISpringTimingParameters` object configured with the specified duration, bounce, and initial velocity.
  @inlinable static func spring(duration: TimeInterval, bounce: CGFloat, initialVelocity: CGVector) -> UISpringTimingParameters {
    if #available(iOS 17.0, macCatalyst 17.0, *) {
      return UISpringTimingParameters(duration: duration, bounce: bounce, initialVelocity: initialVelocity)
    }
    let dampingRatio: CGFloat
    if bounce >= 0 {
      dampingRatio = 1 - bounce
    } else {
      dampingRatio = 1 / (1 + bounce)
    }
    return UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
  }

  /// Creates a smooth spring animation with a given duration and optional initial velocity.
  ///
  /// - Parameters:
  ///   - duration: The total duration of the animation.
  ///   - initialVelocity: The initial velocity of the animation, expressed as a `CGVector`. Defaults to `.zero`.
  /// - Returns: A `UISpringTimingParameters` object configured for a smooth animation.
  public static func smooth(duration: CGFloat, initialVelocity: CGVector = .zero) -> UISpringTimingParameters {
    spring(duration: duration, bounce: 0.0, initialVelocity: initialVelocity)
  }

  /// Creates a snappy spring animation with a given duration and optional initial velocity.
  ///
  /// - Parameters:
  ///   - duration: The total duration of the animation.
  ///   - initialVelocity: The initial velocity of the animation, expressed as a `CGVector`. Defaults to `.zero`.
  /// - Returns: A `UISpringTimingParameters` object configured for a snappy animation.
  public static func snappy(duration: CGFloat, initialVelocity: CGVector = .zero) -> UISpringTimingParameters {
    spring(duration: duration, bounce: 0.15, initialVelocity: initialVelocity)
  }

  /// Creates a bouncy spring animation with a given duration and optional initial velocity.
  ///
  /// - Parameters:
  ///   - duration: The total duration of the animation.
  ///   - initialVelocity: The initial velocity of the animation, expressed as a `CGVector`. Defaults to `.zero`.
  /// - Returns: A `UISpringTimingParameters` object configured for a bouncy animation.
  public static func bouncy(duration: CGFloat, initialVelocity: CGVector = .zero) -> UISpringTimingParameters {
    spring(duration: duration, bounce: 0.3, initialVelocity: initialVelocity)
  }
}

// MARK: - UIViewPropertyAnimator

extension UIViewPropertyAnimator {
  /// Creates and returns a `UIViewPropertyAnimator` with a snappy spring animation.
  ///
  /// - Returns: A `UIViewPropertyAnimator` configured with a snappy animation.
  @inlinable public static func snappy() -> UIViewPropertyAnimator {
    return UIViewPropertyAnimator(
      duration: 0.3,
      timingParameters: UISpringTimingParameters.snappy(duration: 0.25)
    )
  }

  /// Creates and returns a `UIViewPropertyAnimator` with a smooth spring animation.
  ///
  /// - Returns: A `UIViewPropertyAnimator` configured with a smooth animation.
  @inlinable public static func smooth() -> UIViewPropertyAnimator {
    return UIViewPropertyAnimator(
      duration: 0.3,
      timingParameters: UISpringTimingParameters.smooth(duration: 0.3)
    )
  }

  /// Creates and returns a `UIViewPropertyAnimator` with a bouncy spring animation.
  ///
  /// - Returns: A `UIViewPropertyAnimator` configured with a bouncy animation.
  @inlinable public static func bouncy() -> UIViewPropertyAnimator {
    return UIViewPropertyAnimator(
      duration: 0.5,
      timingParameters: UISpringTimingParameters.bouncy(duration: 0.5)
    )
  }

  /// Performs a snappy spring animation for the provided animation block.
  ///
  /// - Parameter animation: A closure containing the animations to perform.
  public static func snappy(_ animation: @escaping () -> Void) {
    let animator = snappy()
    animator.addAnimations(animation)
    animator.startAnimation()
  }

  /// Performs a smooth spring animation for the provided animation block.
  ///
  /// - Parameter animation: A closure containing the animations to perform.
  public static func smooth(_ animation: @escaping () -> Void) {
    let animator = smooth()
    animator.addAnimations(animation)
    animator.startAnimation()
  }

  /// Performs a bouncy spring animation for the provided animation block.
  ///
  /// - Parameter animation: A closure containing the animations to perform.
  public static func bouncy(_ animation: @escaping () -> Void) {
    let animator = bouncy()
    animator.addAnimations(animation)
    animator.startAnimation()
  }
}
