//
//  Analysis_VC.swift
//  cs4298_asg2
//
//  Created by CHOW Ho Hin on 31/10/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import Foundation
import UIKit

class Analysis_VC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    let animals:[String] = ["Alligator","Bat","Bear","Bird"]

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = animals[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        let pieChartView = PieChartView()
        pieChartView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 200)
        pieChartView.segments = [
            Segment(color: .red, value: 57),
            Segment(color: .blue, value: 30),
            Segment(color: .green, value: 100),
            Segment(color: .yellow, value: 40)
        ]
        view.addSubview(pieChartView)
        
        super.viewDidLoad()
        }

  
    
    
}
