//
//  Record+CoreDataClass.swift
//  cs4298_asg2
//
//  Created by CHAN Yat Chau on 3/11/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Record)
public class Record: NSManagedObject {
    
    static func addRecord(value : Double){
        let record:Record = Record(context: DbService.context)
//        record.date
//        record.nature
//        record.photo
//        record.remark
//        record.type
        record.value = value
        DbService.saveContext()
    }
    
    static func fetchRecored() -> [Record]{
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
        var results: [Record] = []
        
        do {
            results = try DbService.context.fetch(fetchRequest)
            print(results.count)
        } catch  {
        }
        
        
        return results
    }
}
