//
//  HomeViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/15/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    @IBAction func speakerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: K.identifiers.speakerTVCSegue, sender: Any?.self)
        
    }
    
    @IBAction func attendeeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: K.identifiers.attendeeTVCSegue, sender: Any?.self)
    }
    
    @IBAction func agendaButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: K.identifiers.agendaTVCSegue, sender: Any?.self)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.showSpinner()
        
        fetchData.fetchAllCollectionData()
        group.notify(queue: .main) {
            self.stopSpinner()
            if(usersDic.isEmpty || sessionDic.isEmpty || agendaDic.isEmpty) {
                self.popupAlert(title: "Data Initializer Failed", message: "\n Try to check your internet settings", actionTitles: ["OK"], actions: [{action in}])
            } else {
                loadData()
                self.setupSideMenu()
            }
        }
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(named: K.colors.hftpDarkBlue)
    }
  
    
    func setupSideMenu() {
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    private func makeSettings() -> SideMenuSettings {
        let presentationStyle = SideMenuPresentationStyle.viewSlideOutMenuIn
        presentationStyle.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        presentationStyle.presentingEndAlpha = 0.5
        
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = min(view.frame.width, view.frame.height) * CGFloat(0.75)
        settings.blurEffectStyle = UIBlurEffect.Style.dark
        settings.statusBarEndAlpha = 0
        return settings
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == K.identifiers.attendeeTVCSegue {
            if globalIsLoggedIn == false {
                self.popupAlert(title: "Please Login", message: "\nTo view the attendee list, you must login", actionTitles: ["OK"], actions: [{action1 in}])
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.identifiers.menuSegue { guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
            sideMenuNavigationController.settings = makeSettings()
        }
        else if segue.identifier == K.identifiers.agendaTVCSegue {
            segue.destination.navigationItem.title = K.titles.agendaTitle
        }
        else if segue.identifier == K.identifiers.speakerTVCSegue {
            let destination = segue.destination as! PeopleTableViewController
            destination.navigationItem.title = K.titles.speakerTVTitle
            destination.speakerOrAttendeeList = speakerList
        }
        else if segue.identifier == K.identifiers.attendeeTVCSegue {
            let destination = segue.destination as! PeopleTableViewController
            destination.navigationItem.title = K.titles.attendeeTVTitle
            destination.speakerOrAttendeeList = attendeeList
            destination.isSpeaker = false
        }
    }
    
}
