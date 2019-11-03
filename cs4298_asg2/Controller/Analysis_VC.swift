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
    
    @IBOutlet weak var Stat_TableView: UITableView!
    
  
    
    
    let animals:[String] = ["Alligator","Bat","Bear","Bird","Dog","Dog1","Dog2","Dog4"]
    let CategoryPhoto = [ #imageLiteral(resourceName: "Menu_icon_icon-icons.com_71858"),#imageLiteral(resourceName: "Unknown-1"),#imageLiteral(resourceName: "Wallet-icon"),#imageLiteral(resourceName: "Unknown-2"),#imageLiteral(resourceName: "Food"),#imageLiteral(resourceName: "Unknown"),#imageLiteral(resourceName: "Menu_icon_icon-icons.com_71858"),#imageLiteral(resourceName: "Wallet-icon")]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:Analysis_TableCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Analysis_TableCell
        cell.textLabel?.text = animals[indexPath.row]
        cell.imageView?.image = CategoryPhoto[indexPath.row]
        cell.percantage_bar.transform = CGAffineTransform(scaleX: 1, y: 3)
     
        return cell
    }
    
    override func viewDidLoad() {
        let pieChartView = PieChartView()
        pieChartView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 200)
        pieChartView.segments = [
            Segment(color: .red, value: 57),
            Segment(color: .blue, value: 30),
            Segment(color: .green, value: 100),
            Segment(color: .yellow, value: 40),
            Segment(color: .purple, value: 40)
        ]
        view.addSubview(pieChartView)

      //  Category_ProgressBar.transform = CGAffineTransform(scaleX: 1, y: 4)
    
        
        super.viewDidLoad()
        }
    
}
