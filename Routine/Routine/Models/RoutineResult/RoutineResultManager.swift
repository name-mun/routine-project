//
//  Untitled.swift
//  Routine
//
//  Created by t2023-m0072 on 11/30/24.
//

import UIKit

import CoreData

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
    
}

// MARK: - CRUD 메서드 ( + reset )

extension RoutineResultManager {
    
    /// RoutineResult 를 생성 및 저장
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
    
    // 날짜에 해당하는 RoutineResult 배열을 반환
    func read(_ date: Date) -> [RoutineResult] {
        var routineResults: [RoutineResult] = []
        
        do {
            let routineResultCoreDatas = try fetchRoutineResultCoreData()
            
            routineResultCoreDatas.forEach { routineResultCoreData in
                if let routineResult = routineResultCoreData.convertTo(),
                   routineResult.isCorrect(date) {
                    routineResults.append(routineResult)
                }
            }
        } catch let error {
            print("read: \(error)")
        }
        return routineResults
    }
    
    /// routineResults 를 통해 업데이트
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
    
    /// routineResults 를 통해 데이터 삭제
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
    
    /// 전체 데이터 삭제
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
    
}

// MARK: - 내부 사용 메서드

extension RoutineResultManager {
    
    // CoreData 에서 데이터 로드
    private func fetchRoutineResultCoreData() throws -> [RoutineResultCoreData] {
        return try container.viewContext.fetch(RoutineResultCoreData.fetchRequest())
    }
    
    // 데이터 저장
    private func save() throws {
        try container.viewContext.save()
    }
    
    // 데이터 삭제
    private func delete(_ routineResultCoreData: RoutineResultCoreData) {
        container.viewContext.delete(routineResultCoreData)
    }
}
