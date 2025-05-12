//
//  DateUtils.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

extension DateFormatter {
    static func yearString(from dateString: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = formatter.date(from: dateString) {
            let year = Calendar.current.component(.year, from: date)
            return String(year)
        }
        return nil
    }
}
