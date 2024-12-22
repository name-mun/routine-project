//
//  Typealias.swift
//  Routine
//
//  Created by t2023-m0072 on 12/5/24.
//

import Foundation

///sticker 생성을 위한 AssetName
typealias AssetName = String

typealias DateID = String

///RoutineData 식별자
typealias RoutineID = UUID

//Alarm 타입
typealias Alarm = String


/// DateID 생성자
///
/// DateIDFormatter.dateID(Date) -> DateID (= String)
struct DateIDFormatter {
    
    private static let separator: String = "-"
    
    /// YYYY-MM-DD
    static func dateID(from date: Date) -> DateID {
        let year = Calendar.current.component(.year, from: date)
        let month = Calendar.current.component(.month, from: date)
        let day = Calendar.current.component(.day, from: date)
                
        return ["\(year)",convert(month),convert(day)].joined(separator: "-")
    }
    
    private static func convert(_ value: Int) -> String {
        if value < 10 {
            return "0\(value)"
        } else {
            return "\(value)"
        }
    }
    
}
