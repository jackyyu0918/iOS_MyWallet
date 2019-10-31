//
//  Record+CoreDataProperties.swift
//  cs4298_asg2
//
//  Created by CHAN Yat Chau on 31/10/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var id: Int64
    @NSManaged public var data: String?

}
