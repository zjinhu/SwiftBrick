//
//  BrickLog.swift
//  Brick_SwiftUI
//
//  Created by iOS on 2023/6/15.
//
 
import os

@available(iOS 14.0, *)
public let logger = BrickLog()

@available(iOS 14.0, *)
public struct BrickLog {
    private let logger: Logger
 
    public init(subsystem: String = "Brick", category: String = "Brick") {
        self.logger = Logger(subsystem: subsystem, category: category)
    }
}
 
@available(iOS 14.0, *)
public extension BrickLog {
    func log(_ message: String, level: OSLogType = .default,  isPrivate: Bool = false) {
        if isPrivate {
            logger.log(level: level, "🎾\(message, privacy: .private)")
        } else {
            logger.log(level: level, "🎾\(message, privacy: .public)")
        }
    }
    //默认的日志级别
    func log(_ message: String){
        logger.log("🎾\(message)")
    }
    //调用此函数来捕获可能对故障排除有用但不是必需的信息
    func info(_ message: String){
        logger.info("🔵\(message)")
    }
    //在开发环境中进行主动调试时使用的调试级消息
    func debug(_ message: String){
        logger.debug("🟢\(message)")
    }
    //相当于debug方法
    func trace(_ message: String){
        logger.trace("🟤\(message)")
    }
    func notice(_ message: String){
        logger.notice("🟣\(message)")
    }
    //用于报告意外非致命故障的警告级别消息
    func warning(_ message: String){
        logger.warning("🟡\(message)")
    }
    //用于报告严重错误和失败的错误级别消息
    func error(_ message: String){
        logger.error("🔴\(message)")
    }
    //故障级消息等效
    func critical(_ message: String){
        logger.critical("⚫️\(message)")
    }
    //故障级消息，仅用于捕获系统级或多进程错误
    func fault(_ message: String){
        logger.fault("❌\(message)")
    }
}
