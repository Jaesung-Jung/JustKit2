//
//  Log.swift
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

import OSLog

// MARK: - Log

/// A logging utility that allows you to log messages with different log levels, such as `debug`, `info`, `fault`, and `error`.
/// The `Log` provides static methods to log messages with different levels of severity. It also supports custom destinations for log outputs.
public enum Log {
  public typealias LogType = OSLogType
  
  /// The destinations where log messages will be sent. By default, this includes `ConsoleDestination`.
  nonisolated(unsafe) public static var destinations: [Destination] = [ConsoleDestination()]
  
  /// The set of log types that should be ignored.
  nonisolated(unsafe) public static var ignoredTypes: Set<LogType.RawValue> = []
  
  /// Logs a message with the default log level (`.default`).
  ///
  /// - Parameters:
  ///   - message: The message to be logged. This is evaluated lazily using `@autoclosure`.
  @inlinable
  public static func log(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    dispatch(type: .default, message: message, file: file, function: function, line: line)
  }
  
  /// Logs a message with the debug log level (`.debug`).
  ///
  /// - Parameters:
  ///   - message: The message to be logged. This is evaluated lazily using `@autoclosure`.
  @inlinable
  public static func debug(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    dispatch(type: .debug, message: message, file: file, function: function, line: line)
  }
  
  /// Logs a message with the info log level (`.info`).
  ///
  /// - Parameters:
  ///   - message: The message to be logged. This is evaluated lazily using `@autoclosure`.
  @inlinable
  public static func info(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    dispatch(type: .info, message: message, file: file, function: function, line: line)
  }
  
  /// Logs a message with the fault log level (`.fault`).
  ///
  /// - Parameters:
  ///   - message: The message to be logged. This is evaluated lazily using `@autoclosure`.
  @inlinable
  public static func fault(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    dispatch(type: .fault, message: message, file: file, function: function, line: line)
  }
  
  /// Logs a message with the error log level (`.error`).
  ///
  /// - Parameters:
  ///   - message: The message to be logged. This is evaluated lazily using `@autoclosure`.
  @inlinable
  public static func error(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    dispatch(type: .error, message: message, file: file, function: function, line: line)
  }
}

// MARK: - Log (Private)

extension Log {
  /// Dispatches a log message to the specified destinations, respecting the log type and any ignored types.
  ///
  /// - Parameters:
  ///   - type: The log type to dispatch.
  ///   - message: A closure that provides the log message. It is evaluated lazily.
  ///   - file: The file where the log is being called, used for extracting the class name.
  ///   - function: The function where the log is being called.
  ///   - line: The line number where the log is being called.
  public static func dispatch(type: OSLogType, message: () -> Any, file: String, function: String, line: Int) {
    #if DEBUG
    guard !ignoredTypes.contains(type.rawValue) else {
      return
    }
    destinations.forEach {
      $0.dispatch(
        message: message,
        type: type,
        cls: className(from: file),
        function: function,
        line: line
      )
    }
    #endif
  }

  @inlinable static func className(from fileName: String) -> String {
    let startIndex = fileName.reversed().firstIndex(of: "/")?.base ?? fileName.startIndex
    guard let endIndex = fileName.reversed().firstIndex(of: ".")?.base else {
      return fileName
    }
    return String(fileName[startIndex..<fileName.index(before: endIndex)])
  }
}

// MARK: - Log.Destination

extension Log {
  /// A protocol that defines a destination for log messages. Any type that conforms to `Log.Destination` can serve as a destination for
  /// log messages. Destinations are responsible for handling the log message, type, class name, function, and line number.
  public protocol Destination {
    func dispatch(message: () -> Any, type: OSLogType, cls: String, function: String, line: Int)
  }
}

// MARK: - Log.ConsoleDestination

extension Log {
  struct ConsoleDestination: Destination {
    @inlinable func dispatch(message: () -> Any, type: OSLogType, cls: String, function: String, line: Int) {
      let logger = Logger(subsystem: cls, category: "\(function):\(line)")
      let log = "\(message())"
      logger.log(level: type, "\(log)")
    }
  }
}
