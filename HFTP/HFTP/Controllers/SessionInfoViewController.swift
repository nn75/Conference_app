//
//  SessionInfoViewController.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class SessionInfoViewController: UIViewController {

    @IBOutlet weak var sessionTitle: UILabel!
    @IBOutlet weak var sessionIntro: UILabel!
    @IBOutlet weak var sessionInfo: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var speakerAvatar: UIImageView!
    
    var thisSession : zSession = zSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageInit()
        // Do any additional setup after loading the view.
    }
    
    func pageInit(){
        sessionTitle.text = thisSession.name
        sessionIntro.text = thisSession.description
        sessionInfo.text = thisSession.date + "/n" + thisSession.location
        addBtn.addTarget(self, action:  #selector(addPressed), for: .touchUpInside)
        addBtn.setTitle( "Add to Calendar", for: .normal)
    }
    
    @objc func addPressed(){
        for session in myAgenda{
            if session === thisSession{
                return
            }
        }
        myAgenda.append(thisSession)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
