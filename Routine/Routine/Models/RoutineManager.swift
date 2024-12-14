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
        saveRoutineData(routineData)
        
        do {
            try save()
        } catch let error {
            print("create: error - \(error.localizedDescription)")
        }
    }
    
    /// 입력 날짜에 해당하는 루틴 데이터 배열 반환
    func read(of date: Date) -> [RoutineData] {
        var routineDatas: [RoutineData] = []
        
        do {
            let routineDataModels = try fetchRoutineDataModel()
            
            routineDataModels.forEach { routineDataModel in
                if let routineData = routineDataModel.convert(),
                   routineData.isScheduled(date) {
                    routineDatas.append(routineData)
                }
            }
            
        } catch let error {
            print("read: error - \(error.localizedDescription)")
        }
        return routineDatas
    }
    
    /// 루틴ID, 날짜ID 를 통해 식별 후 데이터 업데이트
    func update(routine: RoutineData) {
        do {
            let routineDataModels = try fetchRoutineDataModel()
            
            routineDataModels.forEach { routineDataModel in
                if let currentRoutine = routineDataModel.convert(),
                   currentRoutine == routine {
                    routineDataModel.setRoutineData(routine)
                }
            }
            
            try save()
        } catch let error {
            print("update: error - \(error.localizedDescription)")
        }
    }

    /// 루틴ID, 날짜ID 를 통해 식별 후 삭제
    func delete(_ routine: RoutineData) {
        
        do {
            let routineDataModels = try fetchRoutineDataModel()
            
            routineDataModels.forEach { routineDataModel in
                if let routineData = routineDataModel.convert(),
                   routine == routineData { deleteRoutine(routineDataModel) }
            }
            
            try save()
        } catch let error {
            print("delete: error - \(error.localizedDescription)")
        }
    }
    
    /// 전체 루틴 데이터 초기화
    func reset() {
        do {
            let routineDataModels = try fetchRoutineDataModel()
            
            routineDataModels.forEach { routineDataModel in
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
    
    // 루틴 데이터 모델 저장
    private func saveRoutineData(_ routineData: RoutineData){
        guard let entity,
              let routineDataModel = NSManagedObject(entity: entity,
                                                     insertInto: container.viewContext)
                as? RoutineDataModel else { return }
        
        routineDataModel.setRoutineData(routineData)
    }
    
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



