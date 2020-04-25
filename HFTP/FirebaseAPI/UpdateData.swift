
//
//  updateSession.swift
//  HFTP
//
//  Created by Kai Wang on 3/31/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
class updateData{
    
    //input: session_id: String Session's ID
    //       user_id: [String] the session's updated attendee list in memory
    static func updateAttendee(session_id s_id: String, user_id u_id: [String]) {
        
        db.collection("attendees").document(s_id).setData(["attendees": u_id]) {
            err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    static func updateUser(userId uid: String, fieldName field: String, value val: Any) {
        
        let batch = db.batch()
        
        let ref = db.collection("users").document(uid)
        batch.updateData([field: val], forDocument: ref)
        
        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch write succeeded.")
            }
        }
    }
}


