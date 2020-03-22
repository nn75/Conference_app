//
//  fetchData.swift
//  HFTP
//
//  Created by Kai Wang on 3/20/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation
import Firebase

let db = Firestore.firestore()

func fetchCollectionData (_ collectionName: String) {
    
    db.collection(collectionName).getDocuments() {
        (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for doc in querySnapshot!.documents {
                let mydata = doc.data()
                let spk = Speaker(f: mydata["fname"] as? String ?? "John", l: mydata["lname"] as? String ?? "Doe")
                speakerList.append(spk)
            }
        }
    }
}

func addDocmentData(_ collectionName: String, data: [String: Any]) {
    
    var ref: DocumentReference? = nil
    
    ref = db.collection(collectionName).addDocument(data: data) { err in
        if let err = err {
            print("Error adding document: \(err)")
        } else {
            print("Document added with ID: \(ref!.documentID)")
        }
    }
}
