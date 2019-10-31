//
//  VirgilPage.swift
//  cs4298_asg2
//
//  Created by CHAN Yat Chau on 31/10/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext


class VirgilPage: UIViewController,UITableViewDataSource {
    let recordClassName: String = String(describing: Record.self)

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate func makeRecord(id: Int64, data: String) {
        let record : Record = NSEntityDescription.insertNewObject(forEntityName: recordClassName, into: context) as! Record
        record.id = id
        record.data = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("enter virgil page")
        makeRecord(id: 0, data: "a")
        makeRecord(id: 1, data: "b")
        makeRecord(id: 2, data: "c")

        
        appDelegate.saveContext()
        
        let result = fetchAllRecord()
        for record in result {
            print("id: \(record.id)")
            print("data: \(record.data ?? "no data")")
        }
    }
    
    @IBAction func deleteAllData(_ sender: Any) {
        let records = fetchAllRecord()
        for record in records {
            context.delete(record)
        }
        tableView.reloadData()
        appDelegate.saveContext()
    }
    
    fileprivate func fetchAllRecord() -> [Record]{
        let fetchRequest:NSFetchRequest<Record> = Record.fetchRequest()
        var result : [Record] = []
        do{
            let serchResults = try context.fetch(fetchRequest)
            print("Count: \(serchResults.count)")
            result =  serchResults as [Record]
        }catch{
            print("Error:  \(error)")
        }
        return result
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = fetchAllRecord()[indexPath.row].data
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchAllRecord().count
    }
    


}
