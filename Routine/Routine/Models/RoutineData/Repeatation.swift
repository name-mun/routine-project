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
enum Repeatation: Codable {
    
    //순서 보장 x
    case weeklyDay(Set<WeeklyDay>)
    case monthlyDay(Set<Int>)
    
    ///요일 데이터 형식
    ///
    ///monday = 0, sunday = 6
    enum WeeklyDay: Int, Codable, CaseIterable {
        case monday = 0
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday = 6
        
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
