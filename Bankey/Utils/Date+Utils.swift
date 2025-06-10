//
//  Date+Utils.swift
//  Bankey
//
//  Created by Paweł Łąk on 09/06/2025.
//

import Foundation

extension Date{
    
    static var bankeyDateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    
    var monthDayYearString: String {
     let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
}
