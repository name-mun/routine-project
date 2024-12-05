//
//  Calender.swift
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
    
    private init() {}
    
    private lazy var container: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()
    
    private lazy var entity = NSEntityDescription.entity(forEntityName: RoutineDataModel.className,
                                                         in: container.viewContext)
    
    /// RoutineData를 입력받아 인코딩 후 CoreData에 저장
    func create(_ routineData: RoutineData) {
        guard let routine = routineData.jsonData(),
              let entity else { return }
        
        let routineDataModel = NSManagedObject(entity: entity,
                                               insertInto: container.viewContext)
        
        setValue(routine: routine, routineDataModel)
        
        do {
            try save()
        } catch let error {
            print("create: error - \(error.localizedDescription)")
        }
    }
    
    //TODO: 처음 불러온 날짜의 경우 어떻게 해아할까? -> default 값을 어떻게 지정할 수 있을까? 이 경우엔 UserDefaults 에 저장해볼까?
    /// 선택날짜에 해당하는 [RoutineData] 반환
    func read(date: Date) -> [RoutineData] {
        var routineDatas: [RoutineData] = []
        
        do {
            let routineDataModels = try fetchRoutineDataModel()
            for routineDataModel in routineDataModels as [NSManagedObject] {
                if let routineJSONData = convertToJSON(routineDataModel) {
                    if let routineData = RoutineData(by: routineJSONData),
                       routineData.isScheduled(date) {
                        routineDatas.append(routineData)
                    }
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
            for routineDataModel in routineDataModels as [NSManagedObject] {
                if let routineJSONData = convertToJSON(routineDataModel) {
                    if let currentRoutine = RoutineData(by: routineJSONData),
                       currentRoutine == routine {
                        setValue(routine: routine.jsonData(), routineDataModel)
                    }
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
            for routineDataModel in routineDataModels as [NSManagedObject] {
                //
                if let routineJSONData = convertToJSON(routineDataModel) {
                    if let routineData = RoutineData(by: routineJSONData),
                       routine == routineData {
                        deleteRoutine(routineDataModel)
                    }
                }
            }
            
            try save()
        } catch let error {
            print("delete: error - \(error.localizedDescription)")
        }
    }
    
    // 전체 루틴 데이터 초기화
    func clearData() {
        do {
            let routineDataModels = try fetchRoutineDataModel()
            for routineDataModel in routineDataModels as [NSManagedObject] {
                deleteRoutine(routineDataModel)
            }
            
            try save()
        } catch let error {
            print("error - \(error.localizedDescription)")
        }
    }
    
    //루틴데이터 전체 불러오기
    private func fetchRoutineDataModel() throws -> [RoutineDataModel] {
        return try container.viewContext.fetch(RoutineDataModel.fetchRequest())
    }
    
    //루틴 데이터 모델 삭제하기
    private func deleteRoutine(_ routineDataModel: NSManagedObject) {
        self.container.viewContext.delete(routineDataModel)
    }
    
    //RoutineDataModel 을 통해 routineJSONData 을 반환
    private func convertToJSON(_ routineDataModel: NSManagedObject) -> Data? {
        return routineDataModel.value(forKey: RoutineDataModel.Key.routineJSONData) as? Data
    }
    
    private func save() throws {
        try container.viewContext.save()
    }
    
    private func setValue(routine: Data?,_ routineDataModel: NSManagedObject) {
        routineDataModel.setValue(routine, forKey: RoutineDataModel.Key.routineJSONData)
    }
}
