//
//  RepetitionSchedule_WeeklySchedule.swift
//  Routine
//
//  Created by t2023-m0072 on 10/30/24.
//

import Foundation

//MARK: - 주간 반복
//TODO: isScheduledFor - N주 마다 기능 구현
struct WeeklySchedule: RepetitionSchedule {
    
    typealias TimeUnit = Self.DayOfWeek
    
    var schedule: Set<TimeUnit>
        
    func isScheduledFor(_ date: Date) -> Bool {
        guard let weeklyDay = DayOfWeek(date: date) else { return false }
        
        return self.schedule.contains(weeklyDay)
    }
    
    //요일 열거형
    //Int타입이 Hashable 준수
  enum DayOfWeek: Int, CaseIterable {
        case sunday = 1
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday = 7
        
        //Calender를 통해 날짜 -> 요일 변환하는 실패가능 생성자
        init?(date: Date) {
            let dayOfWeekIndex = Calendar.current.component(.weekday, from: date)
            guard let dayOfWeek = DayOfWeek.init(rawValue: dayOfWeekIndex) else { return nil }
            self = dayOfWeek
        }
    }
}


