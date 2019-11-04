//
//  Analysis_VC_Income.swift
//  cs4298_asg2
//
//  Created by CHOW Ho Hin on 4/11/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import Foundation
import UIKit

class Analysis_VC_Income: UIViewController{
    
    
    
    var  totalFood:Float = 0
    var  totalShopping:Float = 0
    var  totalTraffic:Float = 0
    var  totalBill:Float = 0
    var  totalEntertainment:Float = 0
    var  totalPet:Float = 0
    var  totalHealthCare:Float = 0
    var  totalOthers:Float = 0
    
    var results =  Record.fetchRecored()
    
    let categories:[String] = ["Salary","Investment","Rent","Prize","Coupon","Lottery","Refund","Others"]
    let CategoryPhoto = [ #imageLiteral(resourceName: "Food"),#imageLiteral(resourceName: "Shopping"),#imageLiteral(resourceName: "Traffic"),#imageLiteral(resourceName: "Bill"),#imageLiteral(resourceName: "Entertainment"),#imageLiteral(resourceName: "Pet"),#imageLiteral(resourceName: "HealthCare"),#imageLiteral(resourceName: "Others")]
    
    var proportion : Array<Float> = Array(repeating: 0, count: 8)
    var uiColorArray = [UIColor]()
    
    
    
    
    
    
    
    
    
    
    
    
    
}
