//
//  DataManager.swift
//  Routine
//
//  Created by t2023-m0072 on 12/22/24.
//

import Foundation


// 전체 루틴 데이터 매니저 (루틴 데이터 / 루틴 결과)
class WholeDataManager {
    
    static let shared = WholeDataManager()
    
    private init() {}
    
    private let routineManager = RoutineManager.shared
    private let routineResultManager = RoutineResultManager.shared
    
    func creat(_ wholeData: WholeData) {
        routineManager.create(wholeData.routine)
        routineResultManager.create(wholeData.result)
    }
    
    func read(at date: Date) -> [WholeData] {
        let routines = routineManager.read(date)
        let wholeDatas = routines.map { wholeData($0, date) }
        
        return wholeDatas
    }
    
    func update(_ wholeData: WholeData) {
        routineManager.update(wholeData.routine)
        routineResultManager.update(wholeData.result)
    }
    
    func delete(_ wholeData: WholeData) {
        routineManager.delete(wholeData.routine)
        routineResultManager.delete(wholeData.result)
    }
    
    func reset() {
        routineManager.reset()
        routineResultManager.reset()
    }
    
    private func wholeData(_ routine: RoutineData, _ date: Date) -> WholeData {
        let routine = routine
        let result = routine.result(at: date)
        
        return (routine: routine, result: result)
    }
}

typealias WholeData = (routine: RoutineData, result: RoutineResult)
