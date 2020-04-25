//
//  MyCalendarViewController.swift
//  HFTP
//
//  Created by Zihui on 4/10/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit
import CalendarKit
import DateToolsSwift

// display user's agenda in calendar mode
class MyCalendarViewController: CalendarAgendaViewController {

    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? Event else {
            return
        }
        selectedSessionId = descriptor.userInfo! as! String
        self.performSegue(withIdentifier: K.identifiers.showMyCalendarDetail, sender: self)
    }
    
    // show warning message if user is not login
    override func viewDidAppear(_ animated: Bool) {
        if(!globalIsLoggedIn){
            self.popupAlert(title: "Please Login", message: "Login to view your calendar", actionTitles: ["OK"], actions: [{action1 in}])
            return
        }
        if let dateJT = Date().setDate("\(currentDate) 00:00") {
            dayView.state?.move(to: dateJT)
        } else {
            // error
        }
        
        currentSeesionIds = myAgenda
        myEvents = []
        loadEvent()
        reloadData()
    }
}

