//
//  Analysis_VC_Income.swift
//  cs4298_asg2
//
//  Created by CHOW Ho Hin on 4/11/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import Foundation
import UIKit

class Analysis_VC_Income: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
  
    @IBOutlet weak var Salary_Button: UIButton!
    @IBOutlet weak var Investment_Button: UIButton!
    @IBOutlet weak var Rent_Button: UIButton!
    @IBOutlet weak var Prize_Button: UIButton!
    @IBOutlet weak var Coupon_Button: UIButton!
    @IBOutlet weak var Lottery_Button: UIButton!
    @IBOutlet weak var Refund_Button: UIButton!
    @IBOutlet weak var Others_Button: UIButton!
    
    
    var  totalSalary:Float = 0
    var  totalInvestment:Float = 0
    var  totalRent:Float = 0
    var  totalPrize:Float = 0
    var  totalCoupon:Float = 0
    var  totalLottery:Float = 0
    var  totalRefund:Float = 0
    var  totalOthers:Float = 0
    
    var results =  Record.fetchRecored()
    
    let categories:[String] = ["Salary","Investment","Rent","Prize","Coupon","Lottery","Refund","Others"]
    let CategoryPhoto = [ #imageLiteral(resourceName: "Food"),#imageLiteral(resourceName: "Shopping"),#imageLiteral(resourceName: "Traffic"),#imageLiteral(resourceName: "Bill"),#imageLiteral(resourceName: "Entertainment"),#imageLiteral(resourceName: "Pet"),#imageLiteral(resourceName: "HealthCare"),#imageLiteral(resourceName: "Others")]
    
    var proportion : Array<Float> = Array(repeating: 0, count: 8)
    var uiColorArray = [UIColor]()
    
    
    override func viewDidLoad() {
        //color for bar chart
        self.uiColorArray.append(UIColor.red) // in Swift 3, its UIColor.blue
        self.uiColorArray.append(UIColor.blue)
        self.uiColorArray.append(UIColor.green)
        self.uiColorArray.append(UIColor.yellow)
        self.uiColorArray.append(UIColor.purple)
        //self.uiColorArray.append(UIColor.purple)
        self.uiColorArray.append(UIColor.black)
        self.uiColorArray.append(UIColor.orange)
        self.uiColorArray.append(UIColor.brown)
        
        for result in results{
            if(result.type == "Salary"){
                print("Salary Success matching")
                totalSalary += (Float)(result.value)
                
            }
            else if(result.type == "Investment"){
                print("Shopping Success matching")
                totalInvestment += (Float)(result.value)
            }
            else if(result.type == "Rent"){
                totalRent += (Float)(result.value)
            }
            else if(result.type == "Prize"){
                totalPrize += (Float)(result.value)
            }
            else if(result.type == "Coupon"){
                totalCoupon += (Float)(result.value)
            }
            else if(result.type == "Lottery"){
                totalLottery += (Float)(result.value)
            }
            else if(result.type == "Refund"){
                totalRefund += (Float)(result.value)
            }
            else if(result.type == "Other" && result.nature == "Income"){
                self.totalOthers += (Float)(result.value)
            }
            
            
        }
        
        
        //Calculation for the percentage
        let AmountOfCategories:[Float] = [self.totalSalary,self.totalInvestment,self.totalRent,self.totalPrize,self.totalCoupon,self.totalLottery,self.totalRefund,self.totalOthers]
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
        
        //round button for showing what color equal which cate
        self.applyRoundCorner(Salary_Button)
        self.applyRoundCorner(Investment_Button)
        self.applyRoundCorner(Rent_Button)
        self.applyRoundCorner(Prize_Button)
        self.applyRoundCorner(Coupon_Button)
        self.applyRoundCorner(Lottery_Button)
        self.applyRoundCorner(Refund_Button)
        self.applyRoundCorner(Others_Button)
        
        super.viewDidLoad()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:Analysis_TableCell_Income = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Analysis_TableCell_Income
        
        
        
        cell.textLabel?.text = categories[indexPath.row]
        cell.imageView?.image = CategoryPhoto[indexPath.row]
        
        cell.Percentage_Bar.transform = CGAffineTransform(scaleX: 1, y: 3)
        DispatchQueue.main.async {
            cell.Percentage_Bar.setProgress(self.proportion[indexPath.row], animated: false)
            
        }
        cell.Percentage_Bar.progressTintColor = uiColorArray[indexPath.row]
       // cell.Percentage_Label.text = "\(proportion[indexPath.row])"
       // cell.textAlignment = .center
        
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
