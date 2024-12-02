//
//  Calender.swift
//  Routine
//
//  Created by t2023-m0072 on 11/30/24.
//

import Foundation
import CoreData

///
///캘린더 날짜를 선택했을 때, 필요한 데이터를 저장하는 바로 저장
///데이트 검증
///
///
//루틴 데이터들을 코어 데이터에 저장


/*
 루틴매니저
 
 새로운 루틴을 생성, 수정, 삭제
 CRUD
 + createRoutine(루틴 프로퍼티’s)
 + readRoutine(루틴ID)
 + updateRoutine(루틴 프로퍼티’s?)
 + deleteRountine(루틴ID)
 
 [RoutineID] 수정 -> 그 이후 날짜들이 이어받음
 */

///RoutineData를 관리하는 싱글톤 객체
///
///CRUD 메서드 지원
///
class RoutineManager {
    
    let container = NSPersistentContainer()
    
    /// RoutineData를 입력받아 인코딩 후 CoreData에 저장
    func create(_ routineData: RoutineData) {
        
        guard let data = routineData.jsonData(),
              let entity = NSEntityDescription.entity(forEntityName: RoutineDataModel.className,
                                                      in: self.container.viewContext) else { return }
        
        let routineDataModel = NSManagedObject(entity: entity,
                                               insertInto: self.container.viewContext)
        
        routineDataModel.setValue(data, forKey: RoutineDataModel.Key.routineJSONData)
        
        do {
            try self.container.viewContext.save()
        } catch let error {
            print("error - \(error.localizedDescription)")
        }
    }
    
    /// id:RoutineID(UUID) 와 startDate: Date 를 입력받아 RoutineData 를 반환
    func read(routineID: RoutineID, dateID: Date) -> RoutineData? {
        
        do {
            let routineDataModels = try self.container.viewContext.fetch(RoutineDataModel.fetchRequest())
            
            for routineDataModel in routineDataModels as [NSManagedObject] {
                
                if let routineJSONData = routineDataModel.value(forKey: RoutineDataModel.Key.routineJSONData) as? Decoder {
                    if let routineData = try? RoutineData(from: routineJSONData) {
                        if routineData.checkID(routineID: routineID, dateID: dateID) {
                            return routineData
                        }
                    }
                }
                
            }
        } catch let error {
            print("error - \(error.localizedDescription)")
        }
        
        return nil
    }
    
    //
    func update(routine: RoutineData) {
        
        do {
            let routineDataModels = try self.container.viewContext.fetch(RoutineDataModel.fetchRequest())
            for routineDataModel in routineDataModels as [NSManagedObject] {
                
                if let routineJSONData = routineDataModel.value(forKey: RoutineDataModel.Key.routineJSONData) as? Decoder {
                    if let routineData = try? RoutineData(from: routineJSONData) {
                        if routineData == routine {
                            routineDataModel.setValue(routine, forKey: RoutineDataModel.Key.routineJSONData)
                        }
                    }
                }
            }
            
            try container.viewContext.save()
        } catch let error {
            print("error - \(error.localizedDescription)")
        }
    }
    
    //
    func delete(id: RoutineID) {
        do {
            let routineDataModels = try self.container.viewContext.fetch(RoutineDataModel.fetchRequest())
            for routineDataModel in routineDataModels as [NSManagedObject] {
                
                if let routineJSONData = routineDataModel.value(forKey: RoutineDataModel.Key.routineJSONData) as? Decoder {
                    if let routineData = try? RoutineData(from: routineJSONData) {
                        if routineData.id == id {
                            self.container.viewContext.delete(routineDataModel)
                        }
                    }
                }
            }
            
            try container.viewContext.save()
        } catch let error {
            print("error - \(error.localizedDescription)")
        }
    }
    
    func clearData() {
        do {
            let routineDataModels = try self.container.viewContext.fetch(RoutineDataModel.fetchRequest())
            for routineDataModel in routineDataModels as [NSManagedObject] {
                self.container.viewContext.delete(routineDataModel)
            }
            try container.viewContext.save()
        } catch let error {
            print("error - \(error.localizedDescription)")
        }
    }
    
}


struct TodayRoutines {
    
    let dateID: Date
    lazy var routines: [RoutineData] = {
        // Calender에서 dateID 통해 루틴ID들을 불러온다
        //
        // 데이터에서 불러와서 검증 후 저장
        // return coreDate.(dateID)
        return []
    }()
    
    //    init(date: Date) {
    //        dateID = date
    //
    //        //데이터에서 해당 날짜의 루틴을 검증 후 저장 생성
    //        routines = []
    //    }
    
    //날짜에 대한 루틴 데이터 검증 메서드
    //날짜에 해당하는 루틴 데이터 배열 반환 메서드
    //    func data(of date: Date) -> [RoutineData] {
    //
    //        return []
    //    }
}


