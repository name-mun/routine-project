//
//  RoutineResultManagerTester.swift
//  Routine
//
//  Created by t2023-m0072 on 12/21/24.
//

struct RoutineResultManagerTester {
    
    private let manager = RoutineResultManager.shared
    
    private let falseResult = MockData.falseRoutineResult
    private let trueResult = MockData.trueRoutineResult
    private let date = MockData.date
    
    func wholeTest() {
        manager.reset()
        
        testStartPrint("creat")
        manager.create(falseResult)
        manager.create(falseResult)
        let readCreate = manager.read(date)
        let createResult = readCreate.count == 1 && readCreate[0] == falseResult
        testResultPrint("creat", result: createResult)
        
        testStartPrint("update")
        manager.update(trueResult)
        let readUpdate = manager.read(date)
        let updateResult = readUpdate.count == 1 && readUpdate[0] == trueResult
        testResultPrint("update", result: updateResult)
        
        testStartPrint("delete")
        manager.delete(falseResult)
        let readDelete = manager.read(date)
        let deleteResult = readDelete.isEmpty
        testResultPrint("delete", result: deleteResult)
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
