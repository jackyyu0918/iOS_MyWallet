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
    
    @IBOutlet weak var Food_button: UIButton!
    @IBOutlet weak var Shopping_Button: UIButton!
    @IBOutlet weak var Traffic_Button: UIButton!
    @IBOutlet weak var Bill_Button: UIButton!
    @IBOutlet weak var Entertainment_Button: UIButton!
    @IBOutlet weak var Pet_Button: UIButton!
    @IBOutlet weak var HealthCare_Button: UIButton!
    @IBOutlet weak var Other_Button: UIButton!
    
    var  totalFood:Float = 0
    var  totalShopping:Float = 0
    var  totalTraffic:Float = 0
    var  totalBill:Float = 0
    var  totalEntertainment:Float = 0
    var  totalPet:Float = 0
    var  totalHealthCare:Float = 0
    var  totalOthers:Float = 0
    
    var results =  Record.fetchRecored()
    
    let categories:[String] = ["Food","Shopping","Traffic","Bill","Entertainment","Pet","Health Care","Others"]
    let CategoryPhoto = [ #imageLiteral(resourceName: "Food2-1"),#imageLiteral(resourceName: "Shopping2"),#imageLiteral(resourceName: "Car2"),#imageLiteral(resourceName: "Bill2"),#imageLiteral(resourceName: "Entertain,et2"),#imageLiteral(resourceName: "Pet2-1"),#imageLiteral(resourceName: "Healthcare-1"),#imageLiteral(resourceName: "Other2")]
    
    var proportion : Array<Float> = Array(repeating: 0, count: 8)
    var uiColorArray = [UIColor]()
    
    override func viewDidLoad() {
        
        
        
        //color for bar chart
        self.uiColorArray.append(UIColor(red: 141.0/255, green: 86.0/255, blue: 164.0/255, alpha: 1.0)) // in Swift 3, its UIColor.blue
        self.uiColorArray.append(UIColor(red: 4.0/255, green: 51.0/255, blue: 255.0/255, alpha: 1.0))
        self.uiColorArray.append(UIColor(red: 104.0/255, green: 98.0/255, blue: 242.0/255, alpha: 1.0))
        self.uiColorArray.append(UIColor(red: 84.0/255, green: 100.0/255, blue: 157.0/255, alpha: 1.0))
        self.uiColorArray.append(UIColor.purple)
        //self.uiColorArray.append(UIColor.purple)
        self.uiColorArray.append(UIColor(red: 84.0/255, green: 100.0/255, blue: 100.0/255, alpha: 1.0))
        self.uiColorArray.append(UIColor.orange)
        self.uiColorArray.append(UIColor.brown)
        
        for result in results{
            if(result.type == "Food"){
                print("Food Success matching")
                totalFood += (Float)(result.value)
                
            }
            else if(result.type == "Shopping"){
                print("Shopping Success matching")
                totalShopping += (Float)(result.value)
            }
            else if(result.type == "Traffic"){
                totalTraffic += (Float)(result.value)
            }
            else if(result.type == "Bill"){
                totalBill += (Float)(result.value)
            }
            else if(result.type == "Entertainment"){
                totalEntertainment += (Float)(result.value)
            }
            else if(result.type == "Pet"){
                totalPet += (Float)(result.value)
            }
            else if(result.type == "Health Care"){
                totalHealthCare += (Float)(result.value)
            }
            else if(result.type == "Other" && result.nature == "Expense"){
                totalOthers += (Float)(result.value)
            }
            
            
        }
        
        
        //Calculation for the percentage
     let AmountOfCategories:[Float] = [self.totalFood,self.totalShopping,self.totalTraffic,totalBill,totalEntertainment,totalPet,totalHealthCare,totalOthers]
        let sum:Float = AmountOfCategories.reduce(0, +)
       
        var count = 0
        
        while count < AmountOfCategories.count{
            
            proportion[count] = (AmountOfCategories[count] / sum)
           // print(proportion[count])
            count+=1
            
        }
        
        // Create pie chart based on above percentage
        let pieChartView = PieChartView()
        pieChartView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 250)
        pieChartView.segments = [
            Segment(color: UIColor(red: 141.0/255, green: 86.0/255, blue: 164.0/255, alpha: 1.0), value: CGFloat(proportion[0])),
            Segment(color: UIColor(red: 4.0/255, green: 51.0/255, blue: 200.0/255, alpha: 1.0), value: CGFloat(proportion[1])),
            Segment(color: UIColor(red: 104.0/255, green: 98.0/255, blue: 242.0/255, alpha: 1.0), value: CGFloat(proportion[2])),
            Segment(color: UIColor(red: 20.0/255, green: 200.0/255, blue: 200.0/255, alpha: 1.0), value: CGFloat(proportion[3])),
            Segment(color: .purple,value: CGFloat(proportion[4])),
            Segment(color: UIColor(red: 84.0/255, green: 100.0/255, blue: 100.0/255, alpha: 1.0),value:CGFloat(proportion[5])),
            Segment(color: .orange, value:CGFloat(proportion[6])),
            Segment(color: .brown, value:CGFloat(proportion[7]))
        ]
        view.addSubview(pieChartView)
        
        //round button for showing what color equal which cate
        self.applyRoundCorner(Food_button)
        self.applyRoundCorner(Shopping_Button)
        self.applyRoundCorner(Traffic_Button)
        self.applyRoundCorner(Bill_Button)
        self.applyRoundCorner(Entertainment_Button)
        self.applyRoundCorner(Pet_Button)
        self.applyRoundCorner(HealthCare_Button)
        self.applyRoundCorner(Other_Button)
        
        
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
    
    func applyRoundCorner(_ object:AnyObject)   {
        object.layer?.cornerRadius = object.frame.size.width / 2
        object.layer.masksToBounds = true
    }
    
    
}
