//
//  Untitled.swift
//  Routine
//
//  Created by t2023-m0072 on 11/30/24.
//

import UIKit

import CoreData

/*
루틴 결과 매니저
 
 새로운 루틴결과를 생성, 수정, 삭제
 CRUD
 + createRoutineResults(날짜ID) -> default: RoutineResult(id: 루틴ID, isCompleted: false)
 + readRoutineResults(날짜ID) -> RountineResultByDate
 + updateRoutineResults(날짜ID, 루틴ID) toggle -> [RoutineResult]
 + deleteRountineResult(날짜ID, 루틴ID)

 */


///RoutineResult를 관리하는 싱글톤 객체
///
///CRUD 메서드 지원
///
class RoutineResultManager {
    
    static let shared = RoutineResultManager()
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
    }
    
    private let container: NSPersistentContainer
    
    private lazy var entity = NSEntityDescription.entity(forEntityName: RoutineResultCoreData.className, in: container.viewContext)
    
    //
    func create(_ routineResult: RoutineResult) {
        guard let entity,
              let routineResultCoreData = NSManagedObject(entity: entity,
                                                          insertInto: container.viewContext)
                as? RoutineResultCoreData else { return }
        routineResultCoreData.set(routineResult)
        
        do {
            try container.viewContext.save()
        } catch let error {
            print("creat: \(error)")
        }
    }
    
    //
    func read(_ dateID: Date) -> [RoutineResult] {
        var routineResults: [RoutineResult] = []
        
        do {
            let routineResultCoreDatas = try fetchRoutineResultCoreData()
            
            routineResultCoreDatas.forEach { routineResultCoreData in
                if let routineResult = routineResultCoreData.convertTo(),
                   routineResult.isCorrect(dateID) {
                    routineResults.append(routineResult)
                }
            }
        } catch let error {
            print("read: \(error)")
        }
        return []
    }
    
    //
    func update(_ routineResult: RoutineResult) {
        do {
            let routineResultCoreDatas = try fetchRoutineResultCoreData()
            
            routineResultCoreDatas.forEach { routineResultCoreData in
                if routineResultCoreData.isSame(routineResult) {
                    routineResultCoreData.set(routineResult)
                }
            }
            try container.viewContext.save()
        } catch let error {
            print("update: \(error)")
        }
    }
    
    //
    func delete(_ routineResult: RoutineResult) {
        do {
            let routineResultCoreDatas = try fetchRoutineResultCoreData()
            routineResultCoreDatas.forEach { routineResultCoreData in
                if routineResultCoreData.isSame(routineResult) {
                    delete(routineResultCoreData)
                }
            }
            try container.viewContext.save()
        } catch let error {
            print("reset: \(error)")
        }
    }
    
    func reset() {
        do {
            let routineResultCoreDatas = try fetchRoutineResultCoreData()
            routineResultCoreDatas.forEach { routineResultCoreData in
                delete(routineResultCoreData)
            }
            try container.viewContext.save()
        } catch let error {
            print("reset: \(error)")
        }
    }
    
    private func fetchRoutineResultCoreData() throws -> [RoutineResultCoreData] {
        return try container.viewContext.fetch(RoutineResultCoreData.fetchRequest())
    }
    
    private func save() throws {
        try container.viewContext.save()
    }
    
    private func delete(_ routineResultCoreData: RoutineResultCoreData) {
        container.viewContext.delete(routineResultCoreData)
    }
}

/*
 루틴 통계화면
 
 [RoutineResultByDate] 한달치
 -> [Routine: [date]] ->

 1. RoutineResultByRoutine와 RoutineResultByDate의 데이터 원본이 같기때문에 두 개의 데이터 형식이 불필요하다.👍
*/

//
////한 날짜를 기준으로 여러 루틴ID의 결과들
//struct RoutineResultByDate {
//    let calendar: Date
//    var routineResults: [RoutineResult] = []
//    //delete
////    + createRoutineResults(날짜ID) -> default: RoutineResult(id: 루틴ID, isCompleted: false)
//}
//
