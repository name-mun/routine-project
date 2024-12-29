//
//  DateID.swift
//  Routine
//
//  Created by t2023-m0072 on 12/29/24.
//

import Foundation

/// DateID
struct DateID: Codable, Equatable, Comparable {
    
    let year: Int
    let month: Int
    let day: Int
    
    init(_ date: Date) {
        self.year = Calendar.current.component(.year, from: date)
        self.month = Calendar.current.component(.month, from: date)
        self.day = Calendar.current.component(.day, from: date)
    }
        
    func equalMonth(_ dateID: DateID) -> Bool {
        year == dateID.year && month == dateID.month
    }
    
    static func < (lhs: DateID, rhs: DateID) -> Bool {
        compareForm(lhs) < compareForm(rhs)
    }
    
    private static func compareForm(_ dateID: DateID) -> Int {
        let year = "\(dateID.year)"
        let month = dateID.month < 10 ? "0\(dateID.month)" : "\(dateID.month)"
        let day = dateID.day < 10 ? "0\(dateID.day)" : "\(dateID.day)"
        
        return Int(year + month + day) ?? 0
    }
    
    func date() -> Date? {
        let component = DateComponents(year: self.year, month: self.month, day: self.day)
        return Calendar.current.date(from: component)
    }
}
