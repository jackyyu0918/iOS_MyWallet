//
//  RecordDetailsController.swift
//  cs4298_asg2
//
//  Created by CHAN Yat Chau on 4/11/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import UIKit

class RecordDetailsController: UIViewController {
    public var record: Record? = nil
    
    @IBOutlet weak var nature: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var remark: UILabel!
    
    override func viewDidLoad() {
        print(record ?? "Nothing Reveived!")
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: record!.date! as Date)
        
        nature.text = String(record!.nature!)
        type.text = String(record!.type!)
        value.text = String(record!.value)
        date.text = dateString
        remark.text = String(record!.remark ?? "")
        
    }
}
