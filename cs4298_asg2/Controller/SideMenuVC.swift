//
//  SideMenuVC.swift
//  cs4298_asg2
//
//  Created by YU Ka Kit on 30/10/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import UIKit

class SideMenuVC: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        
        switch indexPath.row {
        case 0: NotificationCenter.default.post(name: NSNotification.Name("ShowAnalyze"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowCategory"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("ShowSetting"), object: nil)
        default: break
        }
    }
}
