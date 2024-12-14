//
//  RoutineManager.swift
//  Routine
//
//  Created by t2023-m0072 on 11/30/24.
//

import UIKit

import CoreData

///RoutineData를 관리하는 싱글톤 객체
///
///CRUD 메서드 지원
///
class RoutineManager {
    
    static let shared = RoutineManager()
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
    }
    
    private let container: NSPersistentContainer
    
    private lazy var entity = NSEntityDescription.entity(forEntityName: RoutineDataModel.className,
                                                         in: container.viewContext)
    
    
}

//MARK: - CRUD 메서드 ( + reset )
extension RoutineManager {
    
    /// RoutineData를 입력받아 인코딩 후 CoreData에 저장
    func create(_ routineData: RoutineData) {
        guard let routine = routineData.json(),
              let entity else { return }
        
        if let routineDataModel = NSManagedObject(entity: entity,
                                                  insertInto: container.viewContext) as? RoutineDataModel {
            routineDataModel.setRoutine(routine)
        }
        
        do {
            try save()
        } catch let error {
            print("create: error - \(error.localizedDescription)")
        }
    }
    
    /// 선택날짜에 해당하는 [RoutineData] 반환
    func read(date: Date) -> [RoutineData] {
        var routineDatas: [RoutineData] = []
        
        do {
            let routineDataModels = try fetchRoutineDataModel()
            for routineDataModel in routineDataModels {
                if let routineJSONData = routineDataModel.json(),
                   let routineData = RoutineData(from: routineJSONData),
                   routineData.isScheduled(date) {
                    routineDatas.append(routineData)
                }
            }
            
        } catch let error {
            print("read: error - \(error.localizedDescription)")
        }
        return routineDatas
    }
    
    /// RoutineData 를 입력받아 동일한 ID의 루틴을 교체
    func update(routine: RoutineData) {
        do {
            let routineDataModels = try fetchRoutineDataModel()
            for routineDataModel in routineDataModels {
                if let routineJSONData = routineDataModel.json(),
                   let currentRoutine = RoutineData(from: routineJSONData),
                   currentRoutine == routine,
                   let routineData = routine.json() {
                    routineDataModel.setRoutine(routineData)
                }
            }
            
            try save()
        } catch let error {
            print("update: error - \(error.localizedDescription)")
        }
    }
    
    // RoutineID(UUID) 를 입력받아 루틴을 제거
    func delete(_ routine: RoutineData) {
        
        do {
            let routineDataModels = try fetchRoutineDataModel()
            for routineDataModel in routineDataModels {
                //
                if let routineJSONData = routineDataModel.json(),
                   let routineData = RoutineData(from: routineJSONData),
                   routine == routineData {
                    deleteRoutine(routineDataModel)
                }
            }
            
            try save()
        } catch let error {
            print("delete: error - \(error.localizedDescription)")
        }
    }
    
    // 전체 루틴 데이터 초기화
    func reset() {
        do {
            let routineDataModels = try fetchRoutineDataModel()
            for routineDataModel in routineDataModels {
                deleteRoutine(routineDataModel)
            }
            
            try save()
        } catch let error {
            print("error - \(error.localizedDescription)")
        }
    }
}


//MARK: 내부 사용 메서드
extension RoutineManager {
    
    // 루틴데이터 전체 불러오기
    private func fetchRoutineDataModel() throws -> [RoutineDataModel] {
        return try container.viewContext.fetch(RoutineDataModel.fetchRequest())
    }
    
    // 수정 사항 저장
    private func save() throws {
        try container.viewContext.save()
    }
    
    // 루틴 데이터 모델 삭제하기
    private func deleteRoutine(_ routineDataModel: RoutineDataModel) {
        self.container.viewContext.delete(routineDataModel)
    }
    
}



