//
//  AppLogger.swift
//  reddit-feed
//
//  Created by Subhajit on 27/04/22.
//

import Foundation
import OSLog

enum ApplicationInfo {
    private static let bundleInfo = Bundle.main.infoDictionary

    private enum BundleKey: String {
        case identifier = "CFBundleIdentifier"
        case name = "CFBundleName"
        case platformName = "DTPlatformName"
        case displayName = "CFBundleDisplayName"
        case version = "CFBundleShortVersionString"
        case build = "CFBundleVersion"
    }
    
    static private func info(for key: BundleKey) -> String {
        guard let bundle = bundleInfo,
              let value = bundle[key.rawValue] as? String
        else {
            return "N/A"
        }

        return value
    }

    static var bundleName: String {
        return info(for: .name)
    }
    
    static var bundleIdentifier: String {
        return info(for: .identifier)
    }
}

protocol AppLoggerLogic {
    func debug(_ message: String, file: String, line: Int)
    func info(_ message: String)
    func error(_ message: String)
    func fault(_ message: String)
    func critical(_ message: String)
}

struct AppLogger: AppLoggerLogic {
    
    enum Category: String {
        case general = "General"
        case dataStore = "Data Error"
    }
    
    private let logger: Logger
    
    init(category: Category) {
        logger = Logger(subsystem: ApplicationInfo.bundleIdentifier, category: category.rawValue)
    }
    
    private func log(message: String, type: OSLogType) {
        if case .debug = type {
            logger.log(level: type, "\(message, privacy: .public)")
        } else {
            logger.log(level: type, "\(message)")
        }
    }
    
    func debug(_ message: String, file: String = #file, line: Int = #line) {
        #if DEBUG
            let fileName = (file as NSString).lastPathComponent
            let logMessage = "[\(fileName):\(line)] \(message)"
            
            log(message: logMessage, type: OSLogType.debug)
        #endif
    }
    
    func info(_ message: String) {
        log(message: message, type: OSLogType.info)
    }
    
    func error(_ message: String) {
        log(message: message, type: OSLogType.error)
    }
    
    func fault(_ message: String) {
        log(message: message, type: OSLogType.fault)
    }
    
    func critical(_ message: String) {
        fault(message)
    }
}
