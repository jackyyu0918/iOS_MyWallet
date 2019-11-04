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
    
    enum nature: String {
        case Income = "Income"
        case outcome = "Outcome"
    }
    
    enum type: String{
        case Food = "F"
        //        case case
    }
    
    static func getCount() -> Int{
        let records = Record.fetchRecored()
        return records.count
    }
    
    static func addRecord(date: NSDate?, nature: String?, photo: NSData?, remark: String?, type: String?, value : Double){
        print("Before Add: ",Record.getCount())
        
        let record:Record = Record(context: DbService.context)
        record.date = date
        record.nature = nature
        record.photo = photo
        record.remark = remark
        record.type = type
        record.value = value
        
        DbService.saveContext()
        
        print("After Add: ",Record.getCount())
    }
    
    static func fetchRecored() -> [Record]{
        let request: NSFetchRequest<Record> = Record.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
        var results: [Record] = []
        
        do {
            results = try DbService.context.fetch(request)
            print(results.count)
        } catch  {
        }
        
        return results
    }
    
    static func deleteRecord(record: Record)
    {
        print("Before delete: ", Record.getCount())
        
        DbService.context.delete(record)
        
        print("After delete: ", Record.getCount())
        
    }
    
    //    static func natureCount() -> AnyObject{
    //
    //        //        ----
    //                let keypathExp = NSExpression(forKeyPath: "nature") // can be any column
    //                let expression = NSExpression(forFunction: "count:", arguments: [keypathExp])
    //
    //                let countDesc = NSExpressionDescription()
    //                countDesc.expression = expression
    //                countDesc.name = "count"
    //                countDesc.expressionResultType = .integer64AttributeType
    //
    //        //        ----
    //                let request: NSFetchRequest<NSFetchRequestResult> =  Record.fetchRequest()
    //                request.returnsObjectsAsFaults = false
    //                request.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
    //                request.propertiesToGroupBy = ["type"]
    //
    //                request.propertiesToFetch = ["type", countDesc]
    //                request.resultType = .dictionaryResultType
    //
    //        var results: [AnyObject] = [];
    //
    //                do {
    //                    results = try DbService.context.fetch(request)
    //                    print(results)
    //                } catch  {
    //                }
    //
    //        return results as AnyObject
    //    }
    
    static func natureCount() -> AnyObject{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        let context = DbService.context
        
        //        ---Build Count---
        let keypathExp = NSExpression(forKeyPath: "date") // can be any column
        let expression = NSExpression(forFunction: "count:", arguments: [keypathExp])
        
        let countDesc = NSExpressionDescription()
        countDesc.expression = expression
        countDesc.name = "count"
        countDesc.expressionResultType = .integer64AttributeType
        //        -----------------
        
//        request.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
        request.propertiesToFetch = ["type",countDesc]
        request.propertiesToGroupBy = ["type","nature"]
        request.resultType = .dictionaryResultType
        
        return try! context.fetch(request) as AnyObject
    }
    
}
