//
//  RoutineResult.swift
//  Routine
//
//  Created by t2023-m0072 on 12/21/24.
//

import Foundation

// 루틴 결과
struct RoutineResult {
    // 날짜ID 식별자
    let dateID: Date
    // 루틴ID 식별자
    let routineID: RoutineID

    // 완료 여부
    private(set) var isCompleted: Bool
    
    /// 미완료/완료 토글
    mutating func toggle() -> Bool {
        self.isCompleted.toggle()
        return isCompleted
    }
        
    init(dateID: Date,
         routineID: RoutineID,
         isCompleted: Bool = false) {
        self.routineID = routineID
        self.dateID = dateID
        self.isCompleted = isCompleted
    }
    
}

// MARK: 검증 메서드

extension RoutineResult: Equatable {
    
    /// 동일한 ID 인지 검증
    static func == (_ lhs: RoutineResult, _ rhs: RoutineResult) -> Bool {
        guard lhs.routineID == rhs.routineID,
              lhs.dateID == rhs.dateID else { return false }
        
        return true
    }
    
    // 날짜를 통한 검증
    func isCorrect(_ dateID: Date) -> Bool {
        self.dateID == dateID
    }
    
}
