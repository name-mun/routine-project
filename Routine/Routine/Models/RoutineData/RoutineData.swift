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
 and 생성일자 기준으로 로드해야함
 
 날짜 선택시 해당날짜 요일을 변환 -> 요일 기준
 Date.
 
 */

typealias RoutineID = UUID

struct RoutineData: Codable {
    
    let id: RoutineID
    
    //루틴보드 뷰 용 데이터
    var title: String
    var color: BoardColor
    var sticker: String

    let startDate: Date
    var stopDate: Date?
    var repeatation: Repeatation
    
    var alarm: String?
    
    func isScheduled(date: Date) -> Bool {
        //자체로직 구현
        return false
    }
        

    init(id: RoutineID = UUID(),
         title: String,
         color: BoardColor,
         sticker: String,
         startDate: Date = Date(),
         stopDate: Date? = nil,
         repeatation: Repeatation,
         alarm: String? = nil) {
        self.id = id
        self.title = title
        self.color = color
        self.sticker = sticker
        self.startDate = startDate
        self.stopDate = stopDate
        self.repeatation = repeatation
        self.alarm = alarm
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(RoutineID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.color = try container.decode(BoardColor.self, forKey: .color)
        self.sticker = try container.decode(String.self, forKey: .sticker)
        self.alarm = try container.decodeIfPresent(String.self, forKey: .alarm)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.stopDate = try container.decodeIfPresent(Date.self, forKey: .stopDate)
        self.repeatation = try container.decode(Repeatation.self, forKey: .repeatation)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case color
        case sticker
        case startDate = "start_date"
        case stopDate = "stop_date"
        case repeatation
        case alarm
    }
}

