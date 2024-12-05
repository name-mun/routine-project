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
    
    case weeklyDay(Set<WeeklyDay>)
    case monthlyDay(Set<Int>)
    
    ///print, String(describing:) 에서 사용될 형태 - 데이터 확인용
    var description: String {
        switch self {
        case .monthlyDay(let monthlyDay):
            return "월간 \(monthlyDay.sorted(by: <))"
        case .weeklyDay(let weeklyDay):
            return "주간 \(weeklyDay.sorted(by: <))"
        }
    }
    
    ///날짜 포함 여부 확인 메서드
    ///
    func contains(_ date: Date) -> Bool {
        switch self {
        case .monthlyDay(let monthlyDays):
            let monthlyDay = Calendar.current.component(.day, from: date)
            return monthlyDays.contains(monthlyDay)
            
        case .weeklyDay(let weeklyDays):
            let weeklyDay = WeeklyDay(date: date)
            return weeklyDays.contains(weeklyDay)
        }
    }
    
    
    ///요일 데이터 형식
    ///
    ///monday = 0, sunday = 6
    enum WeeklyDay: Int, Codable, CaseIterable, CustomStringConvertible, Comparable {
        
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
                
        static func < (lhs: Repeatation.WeeklyDay, rhs: Repeatation.WeeklyDay) -> Bool {
            lhs.rawValue < rhs.rawValue
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
