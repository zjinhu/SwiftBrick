//
//  JHLog.swift
//  SwiftBrick
//
//  Created by iOS on 2020/3/27.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit

#if DEBUG
private let shouldLog: Bool = true
#else
private let shouldLog: Bool = false
#endif
 
/// log等级划分最高级 ❌
/// - Parameters:
///   - message: 信息
///   - file: 文件位置
///   - function: 方法名
///   - line: 所在行
@inlinable public func JHLogError(_ message: @autoclosure () -> String,
                       file: StaticString = #file,
                       function: StaticString = #function,
                       line: UInt = #line) {
    JHLog.log(message(), type: .error, file: file, function: function, line: line)
}

/// log等级划分警告级 ⚠️
/// - Parameters:
///   - message: 信息
///   - file: 文件位置
///   - function: 方法名
///   - line: 所在行
@inlinable public func JHLogWarn(_ message: @autoclosure () -> String,
                      file: StaticString = #file,
                      function: StaticString = #function,
                      line: UInt = #line) {
    JHLog.log(message(), type: .warning, file: file, function: function, line: line)
}

/// log等级划分信息级 🔔
/// - Parameters:
///   - message: 信息
///   - file: 文件位置
///   - function: 方法名
///   - line: 所在行
@inlinable public func JHLogInfo(_ message: @autoclosure () -> String,
                      file: StaticString = #file,
                      function: StaticString = #function,
                      line: UInt = #line) {
    JHLog.log(message(), type: .info, file: file, function: function, line: line)
}

/// log等级划分开发级 ✅
/// - Parameters:
///   - message: 信息
///   - file: 文件位置
///   - function: 方法名
///   - line: 所在行
@inlinable public func JHLogDebug(_ message: @autoclosure () -> String,
                       file: StaticString = #file,
                       function: StaticString = #function,
                       line: UInt = #line) {
    JHLog.log(message(), type: .debug, file: file, function: function, line: line)
}
 
/// log等级划分最低级 ⚪ 可忽略
/// - Parameters:
///   - message: 信息
///   - file: 文件位置
///   - function: 方法名
///   - line: 所在行
@inlinable public func JHLogIgnore(_ message: @autoclosure () -> String,
                         file: StaticString = #file,
                         function: StaticString = #function,
                         line: UInt = #line) {
    JHLog.log(message(), type: .ignore, file: file, function: function, line: line)
}

public enum LogDegree : Int{
    case ignore = 0
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4
}

public class JHLog {
    
    /// 日志打印级别，小于此级别忽略
    public static var defaultLogDegree : LogDegree = .ignore
    
    public static func log(_ message: @autoclosure () -> String,
                           type: LogDegree,
                           file: StaticString,
                           function: StaticString,
                           line: UInt) {
        guard shouldLog else { return }
        if type.rawValue < defaultLogDegree.rawValue{ return }
        
        let fileName = String(describing: file).lastPathComponent
        let formattedMsg = String(format: "所在类:%@ \n 方法名:%@ \n 所在行:%d \n<<<<<<<<<<<<<<<<信息>>>>>>>>>>>>>>>>\n\n %@ \n\n<<<<<<<<<<<<<<<<END>>>>>>>>>>>>>>>>\n\n", fileName, String(describing: function), line, message())
        JHLogFormatter.shared.log(message: formattedMsg, type: type)
    }
    
}

private extension String {

    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }

    var pathExtension: String {
        return fileURL.pathExtension
    }

    var lastPathComponent: String {
        return fileURL.lastPathComponent
    }

}

class JHLogFormatter: NSObject {

    static let shared = JHLogFormatter()
    let dateFormatter: DateFormatter
    
    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        super.init()
    }
    
    func log(message logMessage: String, type: LogDegree) {
        var logLevelStr: String
        switch type {
        case .error:
            logLevelStr = "❌ Error ❌"
        case .warning:
            logLevelStr = "⚠️ Warning ⚠️"
        case .info:
            logLevelStr = "🔔 Info 🔔"
        case .debug:
            logLevelStr = "✅ Debug ✅"
        case .ignore:
            logLevelStr = "⚪ Ignore ⚪"
        }
        
        let dateStr = dateFormatter.string(from: Date())
        let finalMessage = String(format: "\n%@ | %@ \n %@", logLevelStr, dateStr, logMessage)
        print(finalMessage)
    }
}
