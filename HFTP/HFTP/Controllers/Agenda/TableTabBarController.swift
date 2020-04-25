//
//  TableTabBarController.swift
//  HFTP
//
//  Created by Zihui on 4/13/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

// TabBarController of table list mode
class TableTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

// dismiss search bar controller when switch page in TabBarController
extension TableTabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if(selectedIndex == 0){
            if let sessionTableVC = viewControllers?[selectedIndex] as? SessionTableViewController {
                sessionTableVC.dismissSearch()
            }
        } else{
            if let myAgendaTableVC = viewControllers?[selectedIndex] as? MyAgendaTableViewController {
                myAgendaTableVC.dismissSearch()
            }
        }
        

        return true
    }
}
