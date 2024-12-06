//
//  RoutineDataModel+CoreDataProperties.swift
//  Routine
//
//  Created by t2023-m0072 on 12/3/24.
//
//

import Foundation
import CoreData


extension RoutineDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoutineDataModel> {
        return NSFetchRequest<RoutineDataModel>(entityName: "RoutineDataModel")
    }

    @NSManaged public var routineJSONData: Data?

}

extension RoutineDataModel : Identifiable {

}
