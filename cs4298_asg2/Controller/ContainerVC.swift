//
//  ViewController.swift
//  cs4298_asg2
//
//  Created by YU Ka Kit on 29/10/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {

    @IBOutlet weak var sideMenuConstrain: NSLayoutConstraint!
    
    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add an observer to use notification centre, it can notify objc func
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }

    @objc func toggleSideMenu(){
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstrain.constant = -200
            //hide it
        } else {
            sideMenuOpen = true
            sideMenuConstrain.constant = 0
            //show it
        }
    }
}

