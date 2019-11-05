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
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showAnalyze), name: NSNotification.Name("ShowAnalyze"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showCategory), name: NSNotification.Name("ShowCategory"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSetting), name: NSNotification.Name("ShowSetting"), object: nil)
        // Do any additional setup after loading the view.
        render()
        
        print("View did load")
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        upSwipe.direction = .up
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        downSwipe.direction = .down
        
        stackView.addGestureRecognizer(rightSwipe)
        stackView.addGestureRecognizer(leftSwipe)
        stackView.addGestureRecognizer(upSwipe)
        stackView.addGestureRecognizer(downSwipe)
    }
    
    @IBOutlet weak var MonthLabel: UILabel!

    var currentMonth: Int = Calendar.current.dateComponents([.month], from: Date()).month!
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                if(currentMonth > 1){
                    currentMonth = currentMonth - 1
                    MonthLabel.text = String(currentMonth)
                    render(months: [currentMonth])
                }
                
            case .left:
                if(currentMonth < 12){
                    currentMonth = currentMonth + 1
                    MonthLabel.text = String(currentMonth)
                    render(months: [currentMonth])
                }
                
            case .up:
                currentMonth = Calendar.current.dateComponents([.month], from: Date()).month!
                MonthLabel.text = String(currentMonth)
                render(months: [currentMonth])
                
            case .down:
                MonthLabel.text = String("All")
                render(months: [1,2,3,4,5,6,7,8,9,10,11,12])
                
            default:
                break
            }
        }
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
    
    func render(months: [Int]){
        let tempRecords: [Record] = Record.fetchRecored()
        records.removeAll()
        
        for record in tempRecords {
            let recordMonth: Int = record.getMonth()
            if(months.contains(recordMonth)){
                records.append(record)
            }
            i+=1
        }
        
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
    
//    func render(_ month: Int){
//        records = Record.fetchRecored()
//
//        if {
//           records.remove(at: )
//        }
//
//        let Income: Double = Record.getNatureSum(nature: Record.Nature.Income)
//        let Outcome: Double = Record.getNatureSum(nature: Record.Nature.outcome)
//        let Balance: Double = Income - Outcome
//
//        IncomeSum.text = String(Income)
//        OutcomeSum.text = String(Outcome)
//        BalanceSum.text = String(Balance)
//
//        IncomeStack.reloadInputViews()
//        OutcomeStack.reloadInputViews()
//        BalanceStack.reloadInputViews()
//
//        recordTableView.reloadData()
//    }

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
        let currentRecordIndex: Int = indexPath.row
        if editingStyle == .delete {
            Record.deleteRecord(record: records[currentRecordIndex])
            records.remove(at: currentRecordIndex)
            tableView.deleteRows(at: [indexPath], with: .fade)
            render()
        }
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
