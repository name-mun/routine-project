//
//  RoutineData.swift
//  Routine
//
//  Created by t2023-m0072 on 10/29/24.
//

import Foundation

//MARK: - 루틴 데이터
struct RoutineData {
    
    //루틴 식별자 타입 (임의로 String 타입)
    var identifier: String
    
    //루틴 보드 색
    var boardColor: RoutineBoardColor
    
    //루틴 이름
    var title: String
    
    //스티커
    var sticker: RoutineSticker
    
    //반복 주기
    var repetitionPeriod: any RepetitionSchedule
    
    //알림 여부
    var isNotice: Bool = false
    
    //알림
    var notice: RoutineNotification?
    
    //중단여부
    var willStop: Bool = false
    
    //중단일자
    var stopDate: Date?
}
