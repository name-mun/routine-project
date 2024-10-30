//
//  RoutineData.swift
//  Routine
//
//  Created by t2023-m0072 on 10/29/24.
//

import Foundation

struct RoutineData {
    //루틴 식별자 타입은 이후 설정 (임의로 String 타입)
    var identifier: String
    
    var color: RoutineBoardColor
    
    var title: String
    
    var sticker: String
    
    var repetitionPeriod: any RepetitionSchedule
    
    var isNotice: Bool = false
    
    var notice: RoutineNotification?
    
    var willStop: Bool = false
    
    var stopDate: Date?

}

enum RoutineBoardColor {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case white
    case black
}


struct RoutineNotification {
    
}

