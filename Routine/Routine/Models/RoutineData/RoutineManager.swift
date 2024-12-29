//
//  RoutineManager.swift
//  Routine
//
//  Created by t2023-m0072 on 11/30/24.
//

import UIKit

import CoreData

///Routine을 관리하는 싱글톤 객체
///
///CRUD 메서드 지원
///
class RoutineManager: NSDataManager {
    
    typealias CoreData = RoutineDataModel
    
    var container: NSPersistentContainer? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil }
        
        return appDelegate.persistentContainer
    }()
    
    lazy var entity: NSEntityDescription? = {
        guard let container = self.container,
              let entity = NSEntityDescription.entity(forEntityName: CoreData.classID, in: container.viewContext) else { return nil }
        
        return entity
    }()
    
    static let shared = RoutineManager()
    
    private init() {}
}

// MARK: - CRUD 메서드

extension RoutineManager {
    
    /// RoutineData를 인코딩 후 CoreData에 저장
    func create(_ routineData: Routine) {
        guard let entity,
              let container,
              let routineDataModel = NSManagedObject(entity: entity,
                                                     insertInto: container.viewContext)
                as? RoutineDataModel else { return }
        
        routineDataModel.setRoutineData(routineData)
        save()
    }
    
    /// 입력 날짜에 해당하는 루틴 데이터 배열 반환
    func read(_ date: Date) -> [Routine] {
        var routineDatas: [Routine] = []
        
        let routineDataModels = fetchData()
        
        routineDataModels.forEach { routineDataModel in
            if let routineData = routineDataModel.convert(),
               routineData.isScheduled(date) {
                routineDatas.append(routineData)
            }
        }
        
        
        return routineDatas
    }
    
    /// RoutineData를 통해 식별 후 데이터 업데이트
    func update(_ routine: Routine) {
        let routineDataModels = fetchData()
        
        routineDataModels.forEach { routineDataModel in
            if let currentRoutine = routineDataModel.convert(),
               currentRoutine == routine {
                routineDataModel.setRoutineData(routine)
            }
        }
        
        save()
        
    }
    
    /// RoutineData를 통해 식별 후 삭제
    func delete(_ routine: Routine) {
        
        let routineDataModels = fetchData()
        
        routineDataModels.forEach { routineDataModel in
            if let routineData = routineDataModel.convert(),
               routine == routineData { deleteData(routineDataModel) }
        }
        
        save()
    }
    
    /// 전체 루틴 데이터 초기화
    func reset() {
        let routineDataModels =  fetchData()
        
        routineDataModels.forEach { routineDataModel in
            deleteData(routineDataModel)
        }
        save()
    }
}
