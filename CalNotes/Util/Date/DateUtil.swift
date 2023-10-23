//
//  DateUtil.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-18.
//

import Foundation

class DateUtil {
    static let shared = DateUtil()
    static let dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"

    private let dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()

    private init() {}

    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
}
