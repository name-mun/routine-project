//
//  RepetitionPeriod.swift
//  Routine
//
//  Created by t2023-m0072 on 10/30/24.
//

import Foundation

//MARK: - 반복주기 프로토콜
protocol RepetitionSchedule {
    
    associatedtype TimeUnit
    
    var schedule: [TimeUnit] { get set }
    
    //반복주기에 부합하는 날짜인지 검증하는 메서드
    func isScheduledFor(_ date: Date) -> Bool
    
}



//MARK: - 주간 반복
//FIXME: 반복주기에 따른 isScheduledFor값 반환방식 구현필요
struct WeeklySchedule: RepetitionSchedule {
    
    typealias TimeUnit = Self.DayOfWeek
    
    var schedule: [TimeUnit]
        
    func isScheduledFor(_ date: Date) -> Bool {
        guard let weeklyDay = DayOfWeek(date: date) else { return false }
        
        return self.schedule.contains(weeklyDay)
    }
    
    enum DayOfWeek: Int {
        case sunday = 1
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday = 7
        
        init?(date: Date) {
            
            let weeklyDayIndex = Calendar.current.component(.weekday, from: date)
            
            guard let weeklyDay = DayOfWeek.init(rawValue: weeklyDayIndex) else { return nil }
            
            self = weeklyDay
        }
    }
}


//MARK: - 월간 반복
struct MonthlySchedule: RepetitionSchedule {
    
    typealias TimeUnit = Self.DayOfMonth
    
    var schedule: [TimeUnit]
    
    func isScheduledFor(_ date: Date) -> Bool {
        guard let monthlyDay = DayOfMonth(date: date) else { return false }
        
        return self.schedule.contains(monthlyDay)
    }
    
    enum DayOfMonth: Int {
        case day1 = 1
        case day2, day3, day4, day5, day6,
             day7, day8, day9, day10, day11,
             day12, day13, day14, day15, day16,
             day17, day18, day19, day20, day21,
             day22, day23, day24, day25, day26,
             day27, day28, day29, day30
        case day31 = 31
        
        init?(date: Date) {
            
            let monthlyDayIndex = Calendar.current.component(.day, from: date)
            
            guard let monthlyDay = DayOfMonth.init(rawValue: monthlyDayIndex) else { return nil }
            
            self = monthlyDay
        }
    }
}
