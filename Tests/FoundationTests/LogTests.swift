//
//  LogTests.swift
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

import Testing
@testable import JustFoundation

// MARK: - LogTests

@Suite(.serialized) struct LogTests {
  let mockDestination = MockDestination()

  init() {
    Log.destinations.append(mockDestination)
  }

  @Test func testDefaultLog() {
    Log.log("default log")
    #expect(mockDestination.messages.last?.message == "default log")
    #expect(mockDestination.messages.last?.type == .default)
  }

  @Test func testDebugLog() {
    Log.debug("debug log")
    #expect(mockDestination.messages.last?.message == "debug log")
    #expect(mockDestination.messages.last?.type == .debug)
  }

  @Test func testInfoLog() {
    Log.info("info log")
    #expect(mockDestination.messages.last?.message == "info log")
    #expect(mockDestination.messages.last?.type == .info)
  }

  @Test func testFaultLog() {
    Log.fault("fault log")
    #expect(mockDestination.messages.last?.message == "fault log")
    #expect(mockDestination.messages.last?.type == .fault)
  }

  @Test func testErrorLog() {
    Log.error("error log")
    #expect(mockDestination.messages.last?.message == "error log")
    #expect(mockDestination.messages.last?.type == .error)
  }
}

// MARK: - LogTests.MockDestination

extension LogTests {
  final class MockDestination: Log.Destination {
    struct LogMessage: Sendable {
      let message: String
      let type: Log.LogType
      let cls: String
      let function: String
      let line: Int
    }

    private(set) var messages: [LogMessage] = []

    func dispatch(message: () -> Any, type: Log.LogType, cls: String, function: String, line: Int) {
      let logMessage = LogMessage(
        message: "\(message())",
        type: type,
        cls: cls,
        function: function,
        line: line
      )
      messages.append(logMessage)
    }
  }
}
