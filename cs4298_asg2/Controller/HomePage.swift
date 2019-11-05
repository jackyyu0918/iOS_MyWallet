//
//  HomePage.swift
//  cs4298_asg2
//
//  Created by CHAN Yat Chau on 3/11/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import UIKit
import CoreData

class HomePage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var IncomeStack: UIStackView!
    @IBOutlet weak var OutcomeStack: UIStackView!
    @IBOutlet weak var BalanceStack: UIStackView!
    
    @IBOutlet weak var IncomeSum: UILabel!
    @IBOutlet weak var OutcomeSum: UILabel!
    @IBOutlet weak var BalanceSum: UILabel!
    
    @IBOutlet weak var recordTableView: UITableView!

    var records: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showAnalyze), name: NSNotification.Name("ShowAnalyze"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showCategory), name: NSNotification.Name("ShowCategory"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSetting), name: NSNotification.Name("ShowSetting"), object: nil)
        // Do any additional setup after loading the view.
        render()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        render()
    }
    
    func render(){
        records = Record.fetchRecored()
        
        let Income: Double = Record.getNatureSum(nature: Record.Nature.Income)
        let Outcome: Double = Record.getNatureSum(nature: Record.Nature.outcome)
        let Balance: Double = Income - Outcome
        
        IncomeSum.text = String(Income)
        OutcomeSum.text = String(Outcome)
        BalanceSum.text = String(Balance)
        
        IncomeStack.reloadInputViews()
        OutcomeStack.reloadInputViews()
        BalanceStack.reloadInputViews()
        
        recordTableView.reloadData()
    }

    // MARK:    RecodeTableView Realted
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell")! as UITableViewCell
        let contentView:UIView = cell.subviews[0] as UIView
        let stackView:UIStackView = contentView.subviews[0] as! UIStackView
        
        let date:UILabel = stackView.subviews[0] as! UILabel
        let type:UILabel = stackView.subviews[1] as! UILabel
        let value:UILabel = stackView.subviews[2] as! UILabel
        
        let currentRecord = records[indexPath.row]
        
        date.text? = currentRecord.getDateString()
        type.text? = currentRecord.getTypeString()
        value.text? = currentRecord.getValueString()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell clicked \(indexPath.row)")
        
        let sb = UIStoryboard.init(name: "Home", bundle: nil)
        let destinationVC = sb.instantiateViewController(withIdentifier: "RecordDetailsView") as! RecordDetailsController
        let record = records[indexPath.row]
        
        destinationVC.record = record
        
        self.navigationController!.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentRow: Int = indexPath.row
            tableView.deleteRows(at: [indexPath], with: .fade)
            Record.deleteRecord(record: records[currentRow])
        }
        render()
    }
    
    //  MARK: Navigation Bar
    @objc func showAnalyze() {
        performSegue(withIdentifier: "ShowAnalyze", sender: nil)
    }
    
    @objc func showCategory(){
        performSegue(withIdentifier: "ShowCategory", sender: nil)
    }
    
    @objc func showSetting(){
        performSegue(withIdentifier: "ShowSetting", sender: nil)
    }
    
    @IBAction func onMoreTapped(){
//        print("Toggle side menu")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    // MARK: Testing button
    @IBAction func addPress(_ sender: Any) {
        Record.addRecord(date: Date() as NSDate, nature: "Income", photo: nil, remark: "remark", type: "Food", value: 1)
        Record.addRecord(date: Date() as NSDate, nature: "Outcome", photo: nil, remark: "remark", type: "Pet", value: 2)
        render()
    }
    
    @IBAction func deletePress(_ sender: Any) {
        for record in records{
            Record.deleteRecord(record: record)
        }
        render()
    }
    
    @IBAction func testPress(_ sender: Any) {
        print("Income: \(Record.getNatureSum(nature: Record.Nature.Income))")
        print("Outcome: \(Record.getNatureSum(nature: Record.Nature.outcome))")
        render()
    }
}
