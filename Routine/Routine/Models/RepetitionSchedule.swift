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
}



