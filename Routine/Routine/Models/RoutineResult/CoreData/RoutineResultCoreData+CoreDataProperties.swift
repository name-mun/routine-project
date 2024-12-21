//
//  RoutineResultCoreData+CoreDataProperties.swift
//  Routine
//
//  Created by t2023-m0072 on 12/21/24.
//
//

import Foundation
import CoreData


extension RoutineResultCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoutineResultCoreData> {
        return NSFetchRequest<RoutineResultCoreData>(entityName: "RoutineResultCoreData")
    }

    @NSManaged public var dateID: Date?
    @NSManaged public var routineID: UUID?
    @NSManaged public var isCompleted: Bool
    
    static let className = "RoutineResultCoreData"
    
    enum Key {
        static let dateID = "dateID"
        static let routineID = "routineID"
        static let isCompleted = "isCompleted"
    }
    
    func convertTo() -> RoutineResult? {
        guard let dateID = value(forKey: Key.dateID) as? Date,
              let routineID = value(forKey: Key.routineID) as? UUID,
              let isCompleted =  value(forKey: Key.isCompleted) as? Bool else { return nil }
        
        return RoutineResult(dateID: dateID,
                             routineID: routineID,
                             isCompleted: isCompleted)
    }
    
    func isSame(_ rouitneResult: RoutineResult) -> Bool {
        self.convertTo() == rouitneResult
    }
    
    func set(_ routineResult: RoutineResult) {
        let dateID = routineResult.dateID
        let routineID = routineResult.routineID
        let isCompleted = routineResult.isCompleted
        setValue(dateID, forKey: Key.dateID)
        setValue(routineID, forKey: Key.routineID)
        setValue(isCompleted, forKey: Key.isCompleted)
    }
    
}

extension RoutineResultCoreData : Identifiable {

}
