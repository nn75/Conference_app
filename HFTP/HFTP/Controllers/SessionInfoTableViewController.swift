//
//  SessionInfoTableViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/25/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit


//nan: Mock data
struct mockSpeakerInfo {
    var name: String
    var avator: UIImage?
}


class SessionInfoTableViewController: UITableViewController {
    
    
    var thisSession : Session = Session()
    var thisSessionId = ""
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var sessionTitle: UILabel!
    @IBOutlet weak var sessionIntro: UILabel!
    @IBOutlet weak var sessionInfo: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var seesionType: UILabel!
    
    
    @IBOutlet weak var attendeeBtn: UIButton!
    

    var speakerArray: [Speaker] = []
    var selectedSpeaker : Speaker = Speaker()
    let addTitle = "Add to Calendar"
    let removeTitle = "Remove From Calendar"

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
        sessionInfo.text = thisSession.date + "\n" + thisSession.location
        seesionType.text = thisSession.category
        
        addBtn.addTarget(self, action:  #selector(addPressed), for: .touchUpInside)
        setBtnTitle()
        attendeeBtn.addTarget(self, action:  #selector(seeAttendees), for: .touchUpInside)
        attendeeBtn.setTitle( "See Attendees", for: .normal)
        for id in thisSession.speaker{
            if id == ""{
                continue
            }
            speakerArray.append(speakersDic[id]!)
        }
    }
    
    func setBtnTitle(){
        for sessionId in myAgenda{
            if sessionId == thisSessionId{
                addBtn.setTitle(removeTitle, for: .normal)
                return
            }
        }
        addBtn.setTitle(addTitle, for: .normal)
    }
    
    @objc func addPressed(){
        if addBtn.currentTitle == addTitle{
            addBtn.setTitle(removeTitle, for: .normal)
            myAgenda.append(thisSessionId)
            thisSession.attendee.append(globalUsrId)
            updateData.updateAttendee(session_id: thisSessionId,  user_id: thisSession.attendee)
            updateData.updateUser(userId: globalUsrId, fieldName: "session", value: myAgenda)
        } else{
            for i in 0..<myAgenda.count{
                if myAgenda[i] == thisSessionId{
                    addBtn.setTitle(addTitle, for: .normal)
                    myAgenda.remove(at: i)
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
    
    @objc func seeAttendees(){
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
         cell.speakerAvator.image = UIImage(named: "No photo")
         
         return cell
     }
    
}

