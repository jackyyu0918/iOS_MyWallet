//
//  SettingViewController.swift
//  cs4298_asg2
//
//  Created by YU Ka Kit on 5/11/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var records: [Record] = []
    
    @IBAction func onClick(_ sender: Any) {
        records = Record.fetchRecored()
        for record in records{
            Record.deleteRecord(record: record)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
