////
////  MockData.swift
////  Routine
////
////  Created by t2023-m0072 on 11/2/24.
////
//
//import Foundation
//import UIKit
//
////MARK: - MockData
//
//struct MockData {
//  
//  static let dates = Array<Date>(repeatElement(Date(), count: 7))
//  
//  static let routines: [RoutineData] = [RoutineData(identifier: "1",
//                                                    boardColor: .red,
//                                                    title: "1. 안녕하세요",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "2",
//                                                    boardColor: .yellow,
//                                                    title: "2. 안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.monthlySchedule,
//                                                    willStop: true),
//                                        RoutineData(identifier: "3",
//                                                    boardColor: .orange,
//                                                    title: "3. 빨래",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "4",
//                                                    boardColor: .green,
//                                                    title: "4. 청소",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "5",
//                                                    boardColor: .black,
//                                                    title: "5. 독서",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "6",
//                                                    boardColor: .red,
//                                                    title: "6. 운동",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "7",
//                                                    boardColor: .yellow,
//                                                    title: "7. 코딩",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.monthlySchedule),
//                                        RoutineData(identifier: "8",
//                                                    boardColor: .orange,
//                                                    title: "8. 빨래",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "9",
//                                                    boardColor: .green,
//                                                    title: "9. 청소",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "10",
//                                                    boardColor: .black,
//                                                    title: "10. 무제",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "1",
//                                                    boardColor: .red,
//                                                    title: "1. 안녕하세요",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "2",
//                                                    boardColor: .yellow,
//                                                    title: "2. 안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.monthlySchedule,
//                                                    willStop: true),
//                                        RoutineData(identifier: "3",
//                                                    boardColor: .orange,
//                                                    title: "3. 빨래",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "4",
//                                                    boardColor: .green,
//                                                    title: "4. 청소",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "5",
//                                                    boardColor: .black,
//                                                    title: "5. 독서",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "6",
//                                                    boardColor: .red,
//                                                    title: "6. 운동",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "7",
//                                                    boardColor: .yellow,
//                                                    title: "7. 코딩",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.monthlySchedule),
//                                        RoutineData(identifier: "8",
//                                                    boardColor: .orange,
//                                                    title: "8. 빨래",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "9",
//                                                    boardColor: .green,
//                                                    title: "9. 청소",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule),
//                                        RoutineData(identifier: "10",
//                                                    boardColor: .black,
//                                                    title: "10. 무제",
//                                                    sticker: .beauty(.bath),
//                                                    repetitionPeriod: Self.weeklySchedule)]
//  
//  static private let weeklySchedule = WeeklySchedule(schedule: Set(DayOfWeek.allCases))
//  
//  static private let monthlySchedule = MonthlySchedule(schedule: Set(DayOfMonth.allCases))
//}
//
//
//
//#Preview("MainRoutineViewController") {
//  let viewController = MainRoutineViewController()
//  return viewController
//}

import Foundation

struct MockData {
    static let routineDatas: [(RoutineData, RoutineResult)] = {
        var datas:[(RoutineData, RoutineResult)]  = []
            
        (0...10).forEach { _ in
            datas.append((RoutineData.mock, RoutineResult(id: UUID(), isCompleted: false)))
        }
        
        return datas
    }()
    
    static let date = Date()
}
