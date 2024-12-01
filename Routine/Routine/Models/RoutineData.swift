//
//  RoutineData.swift
//  Routine
//
//  Created by t2023-m0072 on 11/30/24.
//

import Foundation

/*
 1. 제목: String (default: "")
 2. 색상: Color (default: white)
 3. 스티커: String (default: "heart") - UIImage(systemName:)
 4. 반복: Repeatation (allTime)
 5. 알림: Time?
 6. 중단: Date?
 
 날짜 눌렀을 때, 루틴 데이터 검증
 
 생성일자?
 주기 -> (생성일자) 기준으로 생성
 
 날짜 선택시 해당날짜 요일을 변환 -> 요일 기준
 Date.
 
 */

//데이터에 접근
//루틴ID -> [루틴ID]
//생성을
//루틴 아이디 전체불러와서 -> 각각 ID를 통해 전체 루틴 데이터를 불러오고
typealias RoutineID = Int

typealias AssetName = String

let id = UUID()

struct RoutineData {
    
    let id: RoutineID = 0
    
    //루틴보드 뷰 용 데이터
    var title: String = ""
    var color: BoardColor = .white
    var sticker: AssetName = "heart"
    
    
    var alarm: String?
    
    //반복주기 및 중단 데이터
    //1번 - RoutineManager 객체에서 '선택 날짜에 대한 검증'을 통해 데이터를 반환 -> [RoutineData]
    var repeatation1: Repeatation
    var stop1: Date?

    
    //2번 - RoutineManager 객체에서 'today2 메서드'를 통해 데이터를 반환 -> [RoutineData]
    private var today: TodayRoutine
    
    var repeatation2: Repeatation { today.repeatation }
    var stop2: Date? { today.stop }
    
    func today2(date: Date) -> Bool {
        today.isCorrect(date)
    }
}

struct TodayRoutine {
    
    var repeatation: Repeatation
    var stop: Date?
    
    func isCorrect(_ date: Date) -> Bool {
        return false
    }
    
    init(repeatation: Repeatation, stop: Date? = nil) {
        self.repeatation = repeatation
        self.stop = stop
    }
}


enum BoardColor {
    case white
    case yello
    case blue
    case green
    case red
}


enum Repeatation: Codable {
    
    case weeklyDay(Set<WeeklyDay>)
    case monthlyDay(Set<Int>)
    
    enum WeeklyDay: Int, Codable {
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
