//
//  Logger.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public enum Logger {
    
    public static func log<T>(
        _ object: @autoclosure () -> T,
        _ option: Option = .info,
        _ describe: String = .empty,
        _ file: String = #file,
        _ function: String = #function,
        _ line: Int = #line
    ) {
        #if DEBUG
        let object: T = object()
        let fileURL: String = NSURL(string: file)?.lastPathComponent ?? .empty
        let thread = Thread.isMainThread ? "<UI>" : "<BG>"
        let timestamp = self.dateformatter.string(from: Date())
        
        print(option, timestamp, thread, fileURL, "[\(line)]", describe, String(reflecting: object), separator: " ")
        #endif
    }
    
    private static let dateformatter = DateFormatter().then {
        $0.dateFormat = "HH:mm:ss"
    }
    
}
extension Logger {
    public enum Option {
        case info
        case debug
        case warning
        case error
        case custom(String)
    }
}

extension Logger.Option {
    typealias RawValue = String
    
    init(rawValue: String) {
        switch rawValue {
        case "info":
            self = .info
        case "debug":
            self = .debug
        case "warning":
            self = .warning
        case "error":
            self = .error
        default:
            self = .custom(rawValue)
        }
    }
}

extension Logger.Option: CustomStringConvertible {
    public var description: String {
        switch self {
        case .info:
            return "📝"
        case .debug:
            return "🐛"
        case .warning:
            return "⚠️"
        case .error:
            return "💥"
        case .custom(let symbol):
            return symbol
        }
    }
}
