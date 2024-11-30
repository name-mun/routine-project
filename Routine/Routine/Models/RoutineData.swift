//
//  RoutineData.swift
//  Routine
//
//  Created by t2023-m0072 on 10/29/24.
//

import Foundation

//MARK: - 루틴 데이터
//

struct RoutineData {
  
  //루틴 식별자 타입 (임의로 String 타입)
  private(set) var identifier: String
  
  //루틴 보드 색
  private(set) var boardColor: RoutineBoardColor
  
  //루틴 이름
  private(set) var title: String
  
  //스티커
  private(set) var sticker: RoutineSticker
  
  //반복 주기
  private(set) var repetitionPeriod: any RepetitionSchedule
  
  //알림 여부
  private(set) var isNotice: Bool = false
  
  //알림
  private(set) var notice: RoutineNotification?
  
  //중단여부
  private(set) var willStop: Bool = false
  
  //중단일자
  private(set) var stopDate: Date?
  
}
