//
//  DataManager.swift
//  Routine
//
//  Created by t2023-m0072 on 12/22/24.
//

import Foundation


// 전체 루틴 데이터 매니저 (루틴 데이터 / 루틴 결과)
class RoutineDataManager {
    
    static let shared = RoutineDataManager()
    
    private init() {}
    
    private let routineManager = RoutineManager.shared
    private let routineResultManager = RoutineResultManager.shared
    
    func creat(_ routineData: RoutineData) {
        routineManager.create(routineData.routine)
        routineResultManager.create(routineData.result)
    }
    
    func read(at date: Date) -> [RoutineData] {
        let routines = routineManager.read(date)
        let wholeDatas = routines.map { RoutineData(routine: $0, at: date) }
        
        return wholeDatas
    }
    
    func update(_ wholeData: RoutineData) {
        routineManager.update(wholeData.routine)
        routineResultManager.update(wholeData.result)
    }
    
    func delete(_ wholeData: RoutineData) {
        routineManager.delete(wholeData.routine)
        routineResultManager.delete(wholeData.result)
    }
    
    func reset() {
        routineManager.reset()
        routineResultManager.reset()
    }
    
}

struct RoutineData {
    var routine: Routine
    var result: RoutineResult
    
    init(routine: Routine, result: RoutineResult) {
        self.routine = routine
        self.result = result
    }
    
    init(routine: Routine, at date: Date) {
        self.routine = routine
        self.result = RoutineResult(date: date, routineID: routine.id)
    }
    
}
