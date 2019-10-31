//
//  Analysis_VC.swift
//  cs4298_asg2
//
//  Created by CHOW Ho Hin on 31/10/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import Foundation
import UIKit

class Analysis_VC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Stat_TableView: UITableView!
    

    let animals:[String] = ["Bat","Bear"]
  
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Health", for: indexPath)
        cell.textLabel?.text = animals[indexPath.row]
        return cell
    }
    
    
  

    
}
