//
//  FoundationExtensionTests.swift
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

// MARK: - ProcessInfoExtensionTests

@Suite struct ProcessInfoExtensionTests {
  @Test func testIsPreview() {
#if DEBUG
    let environmentKey = "XCODE_RUNNING_FOR_PREVIEWS"
    // 기존 환경 변수를 저장합니다.
    let originalValue = ProcessInfo.processInfo.environment[environmentKey]
    
    // 테스트를 위해 환경 변수를 설정합니다.
    setenv(environmentKey, "1", 1)
    #expect(ProcessInfo.processInfo.isPreview == true)
    
    setenv(environmentKey, "0", 1)
    #expect(ProcessInfo.processInfo.isPreview == false)
    
    unsetenv(environmentKey)
    #expect(ProcessInfo.processInfo.isPreview == false)
    
    if let originalValue = originalValue {
      setenv(environmentKey, originalValue, 1)
    } else {
      unsetenv(environmentKey)
    }
#else
    #expect(true, "isPreview is not available in Release build")
#endif
  }
}

// MARK: - URLExtensionsTests

@Suite struct URLExtensionsTests {
  @Test func testUserDocumentURL() {
    let expectedURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    #expect(URL.userDocument == expectedURL)
  }
  
  @Test func testUserCachesURL() {
    let expectedURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    #expect(URL.userCaches == expectedURL)
  }
  
  @Test func testUserLibraryURL() {
    let expectedURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
    #expect(URL.userLibrary == expectedURL)
  }
  
  @Test func testURLsExistence() {
    let fileManager = FileManager.default
    #expect(fileManager.fileExists(atPath: URL.userDocument.path, isDirectory: nil))
    #expect(fileManager.fileExists(atPath: URL.userCaches.path, isDirectory: nil))
    #expect(fileManager.fileExists(atPath: URL.userLibrary.path, isDirectory: nil))
  }
}
