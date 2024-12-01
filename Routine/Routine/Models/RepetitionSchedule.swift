//
//  RepetitionPeriod.swift
//  Routine
//
//  Created by t2023-m0072 on 10/30/24.
//

import Foundation

//MARK: - 반복주기 프로토콜

protocol RepetitionSchedule {
  //Set<TimeUnit>을 지원하기 위한 Hashable 준수
  //TODO: TimeUnit 프로토콜로 리팩토링
  associatedtype TimeUnit: Hashable
  
  //중복되는 값을 받지않기 위한 Set타입
  var schedule: Set<TimeUnit> { get set }
  
  //반복주기에 부합하는 날짜인지 검증하는 메서드
  func isScheduledFor(_ date: Date) -> Bool
  
//  init(from decoder: any Decoder) throws
}

enum RepetitionScheduleWrapper {
    case weekly(WeeklySchedule)
    case monthly(MonthlySchedule)
    
//    enum CodingKeys: String, CodingKey {
//        case type
//        case days
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        
//        switch self {
//        case .weekly(let schedule):
//            try container.encode("weekly", forKey: .type)
//            try container.encode(Array(schedule.schedule).map { $0.rawValue }, forKey: .days)
//        case .monthly(let schedule):
//            try container.encode("monthly", forKey: .type)
//            try container.encode(Array(schedule.schedule).map { $0.rawValue }, forKey: .days)
//        }
//    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let type = try container.decode(String.self, forKey: .type)
//        let days = try container.decode([Int].self, forKey: .days)
//        
//        switch type {
//        case "weekly":
//            let daySet = Set(days.compactMap { DayOfWeek(rawValue: $0) })
//          self = .weekly(try WeeklySchedule(from: daySet as! Decoder))
//        case "monthly":
//            let daySet = Set(days.compactMap { DayOfMonth(rawValue: $0) })
//          self = .monthly(try MonthlySchedule(from: daySet as! Decoder))
//        default:
//            throw DecodingError.dataCorruptedError(forKey: .type,
//                in: container,
//                debugDescription: "Invalid schedule type")
//        }
//    }
}


