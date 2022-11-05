//
//  DateHelper.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 05.11.2022.
//

import Foundation

final class DateHelper {
    
    // MARK: - Public methods
    static func parseDate(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)
    }
    
    static func dateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        return dateFormatter.string(from: date)
    }
}
