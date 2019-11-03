//
//  Record+CoreDataProperties.swift
//  cs4298_asg2
//
//  Created by CHAN Yat Chau on 3/11/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var nature: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var remark: String?
    @NSManaged public var type: String?
    @NSManaged public var value: Double

}
