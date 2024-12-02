//
//  Repeatation.swift
//  Routine
//
//  Created by t2023-m0072 on 12/2/24.
//

import Foundation

///반복 주기 열거형
///
///weeklyDay(Set_WeeklyDay) - 주간 반복
///
///monthlyDay(Set_Int) - 월간 반복
///
enum Repeatation: Codable, CustomStringConvertible {
    
    var description: String {
        switch self {
        case .monthlyDay(let monthlyDay):
            return "월간 \(monthlyDay.sorted(by: <))"
        case .weeklyDay(let weeklyDay):
            return "주간 \(weeklyDay.sorted(by: <))"
        }
    }
    
    //순서 보장 x
    case weeklyDay(Set<WeeklyDay>)
    case monthlyDay(Set<Int>)
    
    ///요일 데이터 형식
    ///
    ///monday = 0, sunday = 6
    enum WeeklyDay: Int, Codable, CaseIterable, CustomStringConvertible, Comparable {
        static func < (lhs: Repeatation.WeeklyDay, rhs: Repeatation.WeeklyDay) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
        
        case monday = 0
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday = 6
        
        var description: String {
            switch self {
            case .monday: return "월"
            case .tuesday: return "화"
            case .wednesday: return "수"
            case .thursday: return "목"
            case .friday: return "금"
            case .saturday: return "토"
            case .sunday: return "일"
            }
        }
        
        init(date: Date) {
            let dayOfWeekIndex = (Calendar.current.component(.weekday, from: date) + 5) % 7
            
            guard let dayOfWeek = WeeklyDay.init(rawValue: dayOfWeekIndex) else {
                self = .sunday
                return
            }
            
            self = dayOfWeek
        }
    }
}
