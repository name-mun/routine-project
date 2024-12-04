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
        static let routineDataJSON = "routineDataJSON"
    }
}
