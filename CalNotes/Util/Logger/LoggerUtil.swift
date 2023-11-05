//
//  LoggerUtil.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-11-04.
//

import Foundation

struct LoggerUtil {
    enum Level {
        case error
        case warning
        case info
        case debug
        case verbose
    }
    static let shared = LoggerUtil()
    static let dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
    static let separator = " | "

    private let dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone.current
        return formatter
    }()

    private init() {}

    private func description(of item: Any) -> String {
        if let item = item as? Encodable {
            return String(describing: item)
        }
        if let children = item as? (any Collection) {
            var description = "["
            description += children
                .compactMap { child in
                    self.description(of: child)
                }
                .joined(separator: ", ")
            description += "]"
            return description
        } else {
            var description = "{"
            description += Mirror(reflecting: item).children
                .compactMap { child in
                    guard let label = child.label else {
                        return ""
                    }
                    let value = child.value
                    if let value = value as? String {
                        return "\"\(label)\": \"\(value)\""
                    } else {
                        return "\"\(label)\": \(self.description(of: value))"
                    }
                }
                .joined(separator: ", ")
            description += "}"
            return description
        }
    }

    private func log(_ items: Any..., for level: Level) {
        let date = dateFormatter.string(from: Date())
        let level = String(describing: level).uppercased()
        let items = items
            .compactMap { item in
                description(of: item)
            }
            .joined(separator: Self.separator)
        print(date, level, items, separator: Self.separator)
    }

    func error(_ items: Any...) {
        log(items, for: .error)
    }

    func warning(_ items: Any...) {
        log(items, for: .warning)
    }

    func info(_ items: Any...) {
        log(items, for: .info)
    }

    func debug(_ items: Any...) {
        log(items, for: .debug)
    }

    func verbose(_ items: Any...) {
        log(items, for: .verbose)
    }
}
