//
//  RepetitionSchedule_MonthlySchedule .swift
//  Routine
//
//  Created by t2023-m0072 on 10/30/24.
//

import Foundation

//MARK: - 월간 반복
struct MonthlySchedule: RepetitionSchedule {
    
    typealias TimeUnit = Self.DayOfMonth
    
    var schedule: Set<TimeUnit>
    
    func isScheduledFor(_ date: Date) -> Bool {
        guard let monthlyDay = DayOfMonth(date: date) else { return false }
        
        return self.schedule.contains(monthlyDay)
    }
    
    //1~31일을 지원하는 열거형
    //Int타입이 Hashable 준수
    enum DayOfMonth: Int {
        case day1 = 1
        case day2, day3, day4, day5, day6,
             day7, day8, day9, day10, day11,
             day12, day13, day14, day15, day16,
             day17, day18, day19, day20, day21,
             day22, day23, day24, day25, day26,
             day27, day28, day29, day30
        case day31 = 31
        
        //Calender를 통해 날짜 -> 일 변환하는 실패가능 생성자
        init?(date: Date) {
            let dayOfMonthIndex = Calendar.current.component(.day, from: date)
            guard let dayOfMonth = DayOfMonth.init(rawValue: dayOfMonthIndex) else { return nil }
            self = dayOfMonth
        }
    }
}


