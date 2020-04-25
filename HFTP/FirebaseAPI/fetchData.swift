 //
//  fetchData.swift
//  HFTP
//
//  Created by Kai Wang on 3/20/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

let db = Firestore.firestore()
let group = DispatchGroup()

 class fetchData{
    static func fetchAllCollectionData() {
        //get the users
        group.enter()
        fetchUsereData()
        
        group.enter()
        fetchSpeakerData()
        //group.leave()
        
        group.enter()
        fetchSessionData()
        //group.leave()
        group.enter()
        fetchAttendeeData()
    }
    
    static func fetchUsereData() {
        
        db.collection("users").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting users: \(err)")
                
            } else {
                for doc in querySnapshot!.documents {
                    let id = doc.documentID as String
                    let mydata = doc.data()
                    
                    //fetch each field
                    let name = mydata["name"] as? String
                    let email = mydata["email"] as? String
                    let phone = mydata["phone"] as? String
                    let session = (mydata["session"] as! NSArray).compactMap({ $0 as? String })
                    let company = mydata["company"] as? String
                    let title = mydata["title"] as? String
                    //let credit = mydata["credit"] as? Double //future use
                    let socialMedia = mydata["social_media"] as? [String]
                    let avator = mydata["avator"] as? String
                    
                    let user = Attendee(n: name ?? "empty", e: email ?? "empty", c: company ?? "", j: title ?? " ", p: phone ?? "", id:id, se: session, sm: socialMedia!, av: avator ?? "")
            
                    usersDic[id] = user
                }
                
            }
            group.leave()
        }
    }
    
    static func fetchSpeakerData() {
        
        db.collection("speakers").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting speakers: \(err)")
                
            } else {
                for doc in querySnapshot!.documents {
                    let id = doc.documentID as String
                    let mydata = doc.data()
                    
                    //fetch each field
                    let name = mydata["name"] as? String
                    let email = mydata["email"] as? String
                    let phone = mydata["phone"] as? String
                    let session = mydata["session"] as? NSArray
                    let company = mydata["company"] as? String
                    let title = mydata["title"] as? String
                    let avator = mydata["avator"] as? String
                    
                    let speaker = Speaker(n: name ?? "empty", e: email ?? "empty", c: company ?? "", j: title ?? " ", p: phone ?? "", id:id, se: session as? [String] ?? [], av: avator ?? "")
                    
                    speakersDic[id] = speaker
                }
                
            }
            
            group.leave()
        }
    }
    
    static func fetchSessionData() {
        
        db.collection("sessions").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting session: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    let id = doc.documentID as String
                    let mydata = doc.data()
                    
                    //fetch each field
                    let date = mydata["date"] as! String
                    let startTime = mydata["start_time"] as! String
                    let endTime = mydata["end_time"] as! String
                    let name = mydata["name"] as! String
                    let description = mydata["description"] as? String
                    let category = mydata["category"] as! String
                    let credit = mydata["credit"] as! Double
                    let location = mydata["location"] as! String
                    let speaker = (mydata["speakers"] as! NSArray).compactMap({ $0 as? String })
                    
                    let session = Session(d: date , s: startTime, e: endTime , n: name , d: description ?? "", c: category, co: "MSAR03", cr: credit , su: "", l: location , spe: speaker)
                    
                    sessionDic[id] = session
                    
                }
            }
        }
            
        //fetch agenda list
        db.collection("agendas").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting session: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    let date = doc.documentID
                    let session = (doc.data()["session"] as! NSArray).compactMap({ $0 as? String })
                    
                    agendaDic[date] = session
                }
            }
        }
        group.leave()
    }
    
    static func fetchAttendeeData() {
        
        db.collection("attendees").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting attendees: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    let id = doc.documentID as String
                    let mydata = doc.data()
                    let sessions = (mydata["attendees"] as! NSArray).compactMap({ $0 as? String })
                    
                    sessionAttendeeDic[id] = sessions
                }
            }
          
            group.leave()
        }
    }

    static func addDocmentData(_ collectionName: String, data: [String: Any]) {
        
        var ref: DocumentReference? = nil
        
        ref = db.collection(collectionName).addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    //MARK: Helper Function
    static func getListofAllAttendees() {
        var attendeeIDSet: Set<String> = []
        var newList: [Attendee] = []
        for idList in sessionAttendeeDic.values {
            for id in idList {
                attendeeIDSet.insert(id)
            }
        }
        
        for id in attendeeIDSet {
            newList.append(findByUserID(userID: id) as! Attendee)
        }
        attendeeList = newList.sorted(by: { $0.memberID < $1.memberID })
    }
    
    static func findByUserID(userID uid: String) -> People {
        return usersDic[uid]!
    }
    
    static func getAttendeesBySession(sessionID sid: String) -> [Attendee] {
        let attendeeIDs = sessionAttendeeDic[sid]
        var attendeeList:[Attendee] = []
        for id in attendeeIDs! {
            attendeeList.append(findByUserID(userID: id) as! Attendee)
        }
        return attendeeList
    }
    
    static func stringToImage(_ image64Data: String) -> UIImage {
        let image = Data(base64Encoded: image64Data, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: image)!
    }
 }

