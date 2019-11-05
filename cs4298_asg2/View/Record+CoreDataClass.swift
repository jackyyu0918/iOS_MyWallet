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
    
    enum Nature: String {
        case Income = "Income"
        case outcome = "Outcome"
    }
    
    enum IncomeType: String{
        case Salary = "Salary"
        case Investment = "Investment"
        case Rent = "Rent"
        case Prize = "Prize"
        case Coupon = "Coupon"
        case Lottery = "Lottery"
        case Refund = "Refund"
    }
    
    enum OutcomeType: String{
        case Food = "Food"
        case Shopping = "Shopping"
        case Traffic = "Traffic"
        case Bill = "Bill"
        case Entertainment = "Entertainment"
        case Pet = "Pet"
        case HealthCare = "Health Care"
        case Other = "Other"
        
    }
    
    static func getCount() -> Int{
        let records = Record.fetchRecored()
        return records.count
    }
    
    static func addRecord(date: NSDate?, nature: String?, photo: NSData?, remark: String?, type: String?, value : Double){
        print("-------------------------")
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
        print("=========================")
    }
    
    
    //  MARK: Modified
    static func deleteRecord(record: Record){
        print("-------------------------")
        print("Before delete: ", Record.getCount())
        
        DbService.context.delete(record)
        DbService.saveContext()
        
        print("After delete: ", Record.getCount())
        print("=========================")
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
    
    static func getNatureSum(nature : Nature) -> Double{
        var incomeSum: Double = 0;
        var outcomeSum: Double = 0;
        
        let records = Record.fetchRecored();
        
        for record in records{
            if (record.nature == "Income"){
                incomeSum = incomeSum + record.value;
            }else if(record.nature == "Outcome"){
                outcomeSum = outcomeSum + record.value;
            }else{
                print(record.nature)
            }
        }
        
        return nature == Nature.Income ? incomeSum : outcomeSum
    }
    
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
        
        request.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
        request.propertiesToFetch = ["type","nature", countDesc]
        request.propertiesToGroupBy = ["type","nature"]
        request.resultType = .dictionaryResultType
        
        return try! context.fetch(request) as AnyObject
    }
    
    func getNatureString() -> String{
        return String(self.nature!)
    }
    
    func getTypeString() -> String{
        return String(self.type!)
    }
    
    func getValueString() -> String{
        return String(self.value)
    }
    
    func getMonth() -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self.date! as Date)
        let month = components.month!
        return month
    }
    
    func getDateString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: self.date! as Date)
        return dateString
    }
    
    func getMonthString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let dateString = formatter.string(from: self.date! as Date)
        return dateString
    }
    
    func getRemarkString() -> String{
        return String(self.remark!)
    }
    
}
