//
//  AttendeeInfoTableViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/25/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class AttendeeInfoTableViewController: UITableViewController {
    
    @IBOutlet weak var liImageView: UIImageView!
    @IBOutlet weak var fbImageView: UIImageView!
    @IBOutlet weak var igImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatorImageView: UIImageView!
    
    var myAttendee = Attendee()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = myAttendee.fullName
        self.emailLabel.text = myAttendee.email
        self.phoneLabel.text = myAttendee.phoneNumber
        self.companyLabel.text = myAttendee.company
        self.titleLabel.text = myAttendee.jobTitle
        
        if(!myAttendee.avator.isEmpty) {
            self.avatorImageView.image = fetchData.stringToImage(myAttendee.avator)
        } else {
            self.avatorImageView.image = UIImage(named: K.imageName.defaultPhoto)
        }
        
        setUpClickableImages()
    }
    
    func setUpClickableImages(){
        // one gesture recognizer can be attached to only one view
        let tapGestureRecognizerLi = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizerFb = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizerIg = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        liImageView.isUserInteractionEnabled = true
        liImageView.addGestureRecognizer(tapGestureRecognizerLi)
        fbImageView.isUserInteractionEnabled = true
        fbImageView.addGestureRecognizer(tapGestureRecognizerFb)
        igImageView.isUserInteractionEnabled = true
        igImageView.addGestureRecognizer(tapGestureRecognizerIg)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        var isSetUp = false
        //var usrname = ""
        switch tappedImage {
        case liImageView:
            if !myAttendee.linkedIn.isEmpty {
                H.linkedinAction(username: myAttendee.linkedIn)
                isSetUp = true
            }
        case fbImageView:
            if !myAttendee.facebook.isEmpty {
                H.facebookAction(username: myAttendee.facebook)
                isSetUp = true
            }
        case igImageView:
            if !myAttendee.instagram.isEmpty {
                H.instgramAction(username: myAttendee.instagram)
                isSetUp = true
            }
        default:
            break
        }
        if isSetUp == false {
            self.popupAlert(title: "Oops", message: "\nNot set up yet", actionTitles: ["OK"], actions: [{action in}])
        }
    }

}
