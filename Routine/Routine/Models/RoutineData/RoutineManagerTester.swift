//
//  RoutineManagerTester.swift
//  Routine
//
//  Created by t2023-m0072 on 12/6/24.
//

import Foundation

//MARK: - Test Method
struct RoutineManagerTester {
    
    private let routineManager = RoutineManager.shared
    private let oldValue = MockData.oldRoutine
    private let newValue = MockData.newRoutine
    
    
    func whole() {
        routineManager.reset()
        
        creat()
//        read()
        update()
        delete()
    }
    
    private func creat() {
        testStartPrint("creat")
        routineManager.create(oldValue)
        let oldRoutine = routineManager.read(MockData.date)
        if oldRoutine.count == 1,
           oldRoutine[0] == oldValue {
            testResultPrint("creat", result: true)
        } else {
            testResultPrint("creat", result: false)
        }
    }
//    
//    private func read() {
//        testStartPrint("read")
//        if routineManager.read(of: MockData.date) {
//            testResultPrint("read", result: true)
//        } else {
//            testResultPrint("read", result: false)
//        }
//    }
    
    private func update() {
        testStartPrint("update")
        routineManager.update(routine: newValue)
        let newRoutine = routineManager.read(MockData.date)
        if newRoutine.count == 1,
           newRoutine[0] == newValue {
            testResultPrint("update", result: true)

        } else {
            testResultPrint("update", result: false)
        }
        
    }
    
    private func delete() {
        testStartPrint("delete")
        routineManager.delete(newValue)
        
//        if nil == routineManager.read(date: MockData.date) {
//            testResultPrint("delete", result: true)
            
//        } else if let routine = routineManager.read(date: MockData.date) {
//            let str = routine.map { $0.description }.joined(separator: "\n\n")
//            print(str)
//            testResultPrint("delete", result: false)
//
//            
//        } else {
//            print("delete 테스트 실패 🚨")
//        }
    }
    
    
    private func testStartPrint(_ methodName: String) {
        print("\n================================",
              "🎯 Test RoutineManager.\(methodName) 🎯", separator: "\n")
    }
    
    
    private func testResultPrint(_ methodName: String, result: Bool) {
        let result = result ? "✅" : "❌"
        
        print("          \(result) \(methodName) \(result)          ",
              "================================\n\n", separator: "\n")
    }
}
