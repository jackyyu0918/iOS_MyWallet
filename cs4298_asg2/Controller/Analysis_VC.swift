//
//  Analysis_VC.swift
//  cs4298_asg2
//
//  Created by CHOW Ho Hin on 31/10/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import Foundation
import UIKit

class Analysis_VC: UIViewController {
    

    
    override func viewDidLoad() {
        let pieChartView = PieChartView()
        pieChartView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 400)
        pieChartView.segments = [
            Segment(color: .red, value: 57),
            Segment(color: .blue, value: 30),
            Segment(color: .green, value: 25),
            Segment(color: .yellow, value: 40)
        ]
        view.addSubview(pieChartView)
        
        super.viewDidLoad()
        }

  
    
    
  

    
}
