//
//  FormatStyleTests.swift
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
import Testing
@testable import JustFoundation

@Suite struct FormatStyleTests {
  @Test func testFormatHertz() {
    let formatter = RadioFrequencyFormatStyle()
    let result = formatter.format(500)
    #expect(result == "500.0 Hz")
  }

  @Test func testFormatKilohertz() {
    let formatter = RadioFrequencyFormatStyle()
    let result = formatter.format(1500)
    #expect(result == "1.5 kHz")
  }

  @Test func testFormatMegahertz() {
    let formatter = RadioFrequencyFormatStyle()
    let result = formatter.format(1_500_000)
    #expect(result == "1.5 MHz")
  }

  @Test func testFormatGigahertz() {
    let formatter = RadioFrequencyFormatStyle()
    let result = formatter.format(1_500_000_000)
    #expect(result == "1.5 GHz")
  }

  @Test func testFormatTerahertz() {
    let formatter = RadioFrequencyFormatStyle()
    let result = formatter.format(1_500_000_000_000)
    #expect(result == "1.5 THz")
  }

  @Test func testFractionLength() {
    let formatter = RadioFrequencyFormatStyle(fractionLength: 2)
    let result = formatter.format(1500)
    #expect(result == "1.50 kHz")
  }

  @Test func testLocaleSpecificFormatting() {
    let formatter = RadioFrequencyFormatStyle(locale: Locale(identifier: "fr_FR"))
    let result = formatter.format(1500)
    #expect(result == "1,5 kHz")  // Comma as decimal separator in French
  }

  @Test func testFormatExactHertz() {
    let formatter = RadioFrequencyFormatStyle()
    let result = formatter.format(1000)
    #expect(result == "1.0 kHz")
  }

  @Test func testFormatExactMegahertz() {
    let formatter = RadioFrequencyFormatStyle()
    let result = formatter.format(1_000_000)
    #expect(result == "1.0 MHz")
  }

  @Test func testFormatZeroFrequency() {
    let formatter = RadioFrequencyFormatStyle()
    let result = formatter.format(0)
    #expect(result == "0.0 Hz")
  }
}
