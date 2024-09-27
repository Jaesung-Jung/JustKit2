//
//  RadioFrequencyFormatStyle.swift
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

import Foundation

// MARK: - RadioFrequencyFormatStyle

/// A format style for formatting radio frequencies with different units based on the magnitude of the frequency.
public struct RadioFrequencyFormatStyle: FormatStyle, Sendable {
  let locale: Locale
  let fractionLength: Int

  /// Initializes the `RadioFrequencyFormatStyle` with a specified locale and fraction length for formatting.
  ///
  /// - Parameters:
  ///   - locale: The locale used for formatting the number. Defaults to `.current`.
  ///   - fractionLength: The number of decimal places to include in the formatted result. Defaults to `1`.
  public init(locale: Locale = .current, fractionLength: Int = 1) {
    self.locale = locale
    self.fractionLength = fractionLength
  }

  /// Formats the given frequency value as a string with the appropriate frequency unit.
  ///
  /// - Parameter value: The frequency value in hertz to format.
  /// - Returns: A string representing the formatted frequency with the appropriate unit.
  public func format(_ value: Int) -> String {
    let frequency = Double(value)
    let units = Units.allCases
    let unit = value > 0 ? units[min(Int(log10(frequency) / 3), units.count - 1)] : .hertz

    let hertz = Measurement<UnitFrequency>(value: frequency, unit: .hertz)
    let convertedHertz = hertz.converted(to: unit.unitFrequency)
    let formattedFrequency = convertedHertz.value
      .formatted(
        FloatingPointFormatStyle(locale: locale).precision(.fractionLength(fractionLength))
      )
    return "\(formattedFrequency) \(unit)"
  }
}

// MARK: - RadioFrequencyFormatStyle.Units

extension RadioFrequencyFormatStyle {
  /// An enumeration representing different units of frequency.
  enum Units: CaseIterable, CustomStringConvertible {
    /// Hertz (Hz).
    case hertz
    /// Kilohertz (kHz).
    case kilohertz
    /// Megahertz (MHz).
    case megahertz
    /// Gigahertz (GHz).
    case gigahertz
    /// Terahertz (THz).
    case terahertz

    var description: String {
      switch self {
      case .hertz:
        return "Hz"
      case .kilohertz:
        return "kHz"
      case .megahertz:
        return "MHz"
      case .gigahertz:
        return "GHz"
      case .terahertz:
        return "THz"
      }
    }

    var unitFrequency: UnitFrequency {
      switch self {
      case .hertz:
        return .hertz
      case .kilohertz:
        return .kilohertz
      case .megahertz:
        return .megahertz
      case .gigahertz:
        return .gigahertz
      case .terahertz:
        return .terahertz
      }
    }
  }
}

// MARK: - FormatStyle (RadioFrequencyFormatStyle)

extension FormatStyle where Self == RadioFrequencyFormatStyle {
  /// Creates a `RadioFrequencyFormatStyle` with the specified fractional length.
  ///
  /// - Parameter fractionLength: The number of decimal places to include in the formatted result. Defaults to `1`.
  /// - Returns: A `RadioFrequencyFormatStyle` configured with the specified fractional length.
  public static func radioFrequency(fractionLength: Int = 1) -> Self {
    RadioFrequencyFormatStyle(fractionLength: fractionLength)
  }
}
