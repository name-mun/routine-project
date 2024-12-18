//
//  RoutineDataModel+CoreDataClass.swift
//  Routine
//
//  Created by t2023-m0072 on 12/3/24.
//
//

import Foundation

import CoreData

@objc(RoutineDataModel)
public class RoutineDataModel: NSManagedObject {
    
    static let className: String = "RoutineDataModel"
    
    enum Key {
        static let routineJSONData = "routineJSONData"
    }
    
    func setRoutine(_ data: Data) {
        setValue(data, forKey: RoutineDataModel.Key.routineJSONData)
    }
    
    func setRoutineData(_ routineData: RoutineData) {
        let jsonData = routineData.json()
        setValue(jsonData, forKey: RoutineDataModel.Key.routineJSONData)
    }
    
    func json() -> Data? {
        return value(forKey: RoutineDataModel.Key.routineJSONData) as? Data
    }
    
    func convert() -> RoutineData? {
        guard let routineJSONData = self.json(),
              let routineData = RoutineData(from: routineJSONData) else { return nil}
        
        return routineData
    }
}
