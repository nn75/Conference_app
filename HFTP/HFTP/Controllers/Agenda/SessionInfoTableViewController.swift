//
//  SessionInfoTableViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/25/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

// display the detailed information of a session
class SessionInfoTableViewController: UITableViewController {
    
    
    var thisSession : Session = Session()
    var thisSessionId = ""
    
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var sessionTitle: UILabel!
    @IBOutlet weak var sessionIntro: UILabel!
    @IBOutlet weak var sessionInfo: UILabel!
    //@IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var seesionType: UILabel!
    @IBOutlet weak var IntroSection: UIView!
    @IBOutlet weak var speakerSection: UIView!
    @IBOutlet weak var speakCell: UITableViewCell!
    @IBOutlet weak var introCell: UITableViewCell!
    
    
    @IBOutlet weak var attendeeBtn: UIButton!
    

    var speakerArray: [Speaker] = []
    var selectedSpeaker : Speaker = Speaker()
    let addTitle = K.titles.btnAddCalendar
    let removeTitle = K.titles.btnRemoveCalendar

    override func viewDidLoad() {
        super.viewDidLoad()
        pageInit()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    func pageInit(){
        thisSession = sessionDic[thisSessionId]!
//        thisSession.attendee = sessionAttendeeDic[thisSessionId]!
        sessionTitle.text = thisSession.name
        sessionIntro.text = thisSession.description
        sessionInfo.text = String("\(thisSession.date)   \(thisSession.startTime) - \(thisSession.endTime)\n \(thisSession.location)")
        seesionType.text = thisSession.category
        if(sessionIntro.text == ""){
            //IntroSection.isHidden = true
            introCell.isHidden = true
        }
        
        
        setBtnTitle()
        attendeeBtn.addTarget(self, action:  #selector(seeAttendees), for: .touchUpInside)
        for id in thisSession.speaker{
            if id == ""{
                continue
            }
            speakerArray.append(speakersDic[id]!)
        }
        
        if(speakerArray.count == 0){
            //speakerSection.isHidden = true
            speakCell.isHidden = true
        }
        
    }
    
    // set button title according to different situation
    func setBtnTitle(){
        if(globalIsLoggedIn){
            for sessionId in myAgenda{
                if sessionId == thisSessionId{
                    addBtn.title = removeTitle
                    return
                }
            }
        }
        addBtn.title = addTitle
    }
    
    // remove/add this session to user's calendar
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        if(!globalIsLoggedIn){
            //show warning msg
            self.popupAlert(title: "Please Login", message: "Login to edit your agenda", actionTitles: ["OK"], actions: [{action1 in}])
            return
        }
        if addBtn.title == addTitle {
            addBtn.title = removeTitle
            myAgenda.append(thisSessionId)
            thisSession.attendee.append(globalUsrId)
            usersDic[globalUsrId]!.sessions = myAgenda
            updateData.updateAttendee(session_id: thisSessionId,  user_id: thisSession.attendee)
            updateData.updateUser(userId: globalUsrId, fieldName: "session", value: myAgenda)
        } else{
            for i in 0..<myAgenda.count{
                if myAgenda[i] == thisSessionId{
                    addBtn.title = addTitle
                    myAgenda.remove(at: i)
                    usersDic[globalUsrId]!.sessions = myAgenda
                    for j in 0..<thisSession.attendee.count{
                        if thisSession.attendee[j] == globalUsrId{
                            thisSession.attendee.remove(at: j)
                            break
                        }
                    }
                    updateData.updateAttendee(session_id: thisSessionId,  user_id: thisSession.attendee)
                    updateData.updateUser(userId: globalUsrId, fieldName: "session", value: myAgenda)
                    return
                }
            }
        }
    }

    // show the attendee list of the session
    @objc func seeAttendees(){
        if(!globalIsLoggedIn){
            //show warning msg
            self.popupAlert(title: "Please Login", message: "Login to see other attendees", actionTitles: ["OK"], actions: [{action1 in}])
            return
        }
         self.performSegue(withIdentifier: K.identifiers.showSessionAttendee, sender: self)
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.identifiers.showSessionSpeaker{
            let destination = segue.destination as! SpeakerInfoViewController
            destination.mySpeaker = self.selectedSpeaker
        } else {
            let destination = segue.destination as! SessionAttendeeTableViewController
            destination.currentSession = self.thisSession
        }
    }
    
}

// speaker list of the session is displayed in collection view
extension SessionInfoTableViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedSpeaker = speakerArray[indexPath.row]
        self.collectionView.deselectItem(at: indexPath, animated: true)
        self.performSegue(withIdentifier: K.identifiers.showSessionSpeaker, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let label = UILabel(frame: CGRect.zero)
         label.text = speakerArray[indexPath.item].fullName
         label.sizeToFit()
         if (label.frame.width > 50) {
             return CGSize(width: label.frame.width, height: collectionView.frame.height)
         } else {
             return CGSize(width: 50, height: collectionView.frame.height)
         }
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.speakerArray.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.identifiers.cellID, for: indexPath) as! SpeakerInfoCollectionViewCell
        let item = speakerArray[indexPath.row]
        cell.speakerName.text = item.fullName
        
        if(item.avator.isEmpty) {
            cell.speakerAvator.image = UIImage(named: K.imageName.defaultPhoto)
        } else {
            cell.speakerAvator.image = fetchData.stringToImage(item.avator)
        }
         
         return cell
     }
    
}

