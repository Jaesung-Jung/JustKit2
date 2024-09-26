//
//  ComponentSizeTests.swift
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
import Testing
@testable import JustUI

@Suite struct ComponentSizeTests {
  @Test func testAllCases() {
    let allCases = ComponentSize.allCases
    if #available(iOS 17.0, macCatalyst 17.0, *) {
      #expect(allCases == [.mini, .small, .regular, .large, .extraLarge])
    } else {
      #expect(allCases == [.mini, .small, .regular, .large])
    }
  }

  @Test func testInitWithControlSize() {
    let controlSizes: [ControlSize] = [.mini, .small, .regular, .large]
    for controlSize in controlSizes {
      let componentSize = ComponentSize(controlSize)
      switch controlSize {
      case .mini:
        #expect(componentSize == .mini)
      case .small:
        #expect(componentSize == .small)
      case .large:
        #expect(componentSize == .large)
      default:
        #expect(componentSize == .regular)
      }
    }

    if #available(iOS 17.0, macCatalyst 17.0, *) {
      let controlSize = ControlSize.extraLarge
      let componentSize = ComponentSize(controlSize)
      #expect(componentSize == .extraLarge)
    }
  }

  @Test func testPreferredFont() {
    let componentSizes: [ComponentSize] = [.mini, .small, .regular, .large]
    for componentSize in componentSizes {
      let font = componentSize.preferredFont
      switch componentSize {
      case .mini:
        #expect(font == .just.caption)
      case .small:
        #expect(font == .just.footnote)
      case .large:
        #expect(font == .just.headline)
      default:
        #expect(font == .just.body)
      }
    }

    if #available(iOS 17.0, macCatalyst 17.0, *) {
      let componentSize = ComponentSize.extraLarge
      let font = componentSize.preferredFont
      #expect(font == .just.title4)
    }
  }

  @Test func testPreferredUIFont() {
    let componentSizes: [ComponentSize] = [.mini, .small, .regular, .large]
    for componentSize in componentSizes {
      let uiFont = componentSize.preferredUIFont
      switch componentSize {
      case .mini:
        #expect(uiFont == UIFont.just.caption())
      case .small:
        #expect(uiFont == UIFont.just.footnote())
      case .large:
        #expect(uiFont == UIFont.just.headline())
      default:
        #expect(uiFont == UIFont.just.body())
      }
    }

    if #available(iOS 17.0, macCatalyst 17.0, *) {
      let componentSize = ComponentSize.extraLarge
      let uiFont = componentSize.preferredUIFont
      #expect(uiFont == UIFont.just.title4())
    }
  }
}
