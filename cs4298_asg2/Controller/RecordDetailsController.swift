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

        nature.text = record!.getNatureString()
        type.text = record!.getTypeString()
        value.text = record!.getValueString()
        date.text = record!.getDateString()
        remark.text = record!.getRemarkString()
    }
}
