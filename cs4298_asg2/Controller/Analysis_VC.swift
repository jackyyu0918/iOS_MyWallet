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
    

    
 
    
    let categories:[String] = ["Food","Shopping","Traffic","Bill","Entertainment","Pet","Health Care","Others"]
    let CategoryPhoto = [ #imageLiteral(resourceName: "Food"),#imageLiteral(resourceName: "Shopping"),#imageLiteral(resourceName: "Traffic"),#imageLiteral(resourceName: "Bill"),#imageLiteral(resourceName: "Entertainment"),#imageLiteral(resourceName: "Pet"),#imageLiteral(resourceName: "HealthCare"),#imageLiteral(resourceName: "Others")]
    let AmountOfCategories:[Float] = [57,30,200,200,60,500,45,10]
    var proportion : Array<Float> = Array(repeating: 0, count: 8)
    var uiColorArray = [UIColor]()
    

    override func viewDidLoad() {
        
        //color for bar chart
        self.uiColorArray.append(UIColor.red) // in Swift 3, its UIColor.blue
        self.uiColorArray.append(UIColor.blue)
        self.uiColorArray.append(UIColor.green)
        self.uiColorArray.append(UIColor.yellow)
        self.uiColorArray.append(UIColor.purple)
        self.uiColorArray.append(UIColor.black)
        self.uiColorArray.append(UIColor.black)
        self.uiColorArray.append(UIColor.orange)
        self.uiColorArray.append(UIColor.brown)
        
        //Calculation for the percentage
     
        let sum:Float = AmountOfCategories.reduce(0, +)
       
        var count = 0
        
        while count < AmountOfCategories.count{
            
            proportion[count] = (AmountOfCategories[count] / sum)
            print(proportion[count])
            count+=1
            
        }
        
        // Create pie chart based on above percentage
        let pieChartView = PieChartView()
        pieChartView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 200)
        pieChartView.segments = [
            Segment(color: .red, value: CGFloat(proportion[0])),
            Segment(color: .blue, value: CGFloat(proportion[1])),
            Segment(color: .green, value: CGFloat(proportion[2])),
            Segment(color: .yellow, value: CGFloat(proportion[3])),
            Segment(color: .purple,value: CGFloat(proportion[4])),
            Segment(color: .black,value:CGFloat(proportion[5])),
            Segment(color: .orange, value:CGFloat(proportion[6])),
            Segment(color: .brown, value:CGFloat(proportion[7]))
        ]
        view.addSubview(pieChartView)

 
        super.viewDidLoad()
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:Analysis_TableCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Analysis_TableCell
        cell.textLabel?.text = categories[indexPath.row]
        cell.imageView?.image = CategoryPhoto[indexPath.row]
        cell.percantage_bar.transform = CGAffineTransform(scaleX: 1, y: 3)
        DispatchQueue.main.async {
            cell.percantage_bar.setProgress(self.proportion[indexPath.row], animated: false)

        }
        cell.percantage_bar.progressTintColor = uiColorArray[indexPath.row]
       //cellLabel.text = "\(proportion[indexPath.row])"
        //cell.textAlignment = .center
        
        //var myIntValue = (Float)((round((proportion[indexPath.row]*100))/100))*100
        let myIntValue = proportion[indexPath.row] * 100
        let showValue = Float(round(myIntValue*10)/10)
       cell.Percentage_Label.text = "\(showValue) %"
        
        return cell
    }
}
