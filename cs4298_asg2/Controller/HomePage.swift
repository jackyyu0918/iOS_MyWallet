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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell")! as UITableViewCell
        let contentView:UIView = cell.subviews[0] as UIView
        let stackView:UIStackView = contentView.subviews[0] as! UIStackView
        
        
        let label0:UILabel = stackView.subviews[0] as! UILabel
        let label1:UILabel = stackView.subviews[1] as! UILabel
        
        
        label0.text? = String(indexPath.row)
        label1.text? = String(indexPath.row * 2)
        
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell clicked \(indexPath.row)")
        
        let sb = UIStoryboard.init(name: "Home", bundle: nil)
        let destinationVC = sb.instantiateViewController(withIdentifier: "RecordDetailsView") as! RecordDetailsController
        let record = Record.fetchRecored()[indexPath.row]
        destinationVC.record = record
        
        self.navigationController!.pushViewController(destinationVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showAnalyze), name: NSNotification.Name("ShowAnalyze"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showCategory), name: NSNotification.Name("ShowCategory"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSetting), name: NSNotification.Name("ShowSetting"), object: nil)
        // Do any additional setup after loading the view.
    }
    
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
        print("Toggle side menu")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @IBAction func addPress(_ sender: Any) {
        Record.addRecord(date: Date() as NSDate, nature: "Income", photo: nil, remark: "remark", type: "Food", value: 1)
        Record.addRecord(date: Date() as NSDate, nature: "Income", photo: nil, remark: "remark", type: "type", value: 1)
    }
    
    @IBAction func deletePress(_ sender: Any) {
        let records = Record.fetchRecored()
        for record in records{  
            Record.deleteRecord(record: record)
        }
    }
    
    @IBAction func testPress(_ sender: Any) {
        print(Record.natureCount())
    }
    
    
    @IBAction func addRecordPress(_ sender: Any) {
    }
}
