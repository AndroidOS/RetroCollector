//
//  FirebaseDataMgr.swift
//  RetroCollector
//
//  Created by Manuel Carvalho on 13/8/20.
//  Copyright © 2020 Manuel Carvalho. All rights reserved.
//

import Foundation
import Firebase

protocol  FirebaseDataManagerDelegate {
    func didUpdateList(manu: [String])
}

struct FirebaseDataManager {

let db = Firestore.firestore()
var delegate: FirebaseDataManagerDelegate?

func fetchFirebaseData() {
   
    performRequest()
}


func performRequest(){
    
    var parts = [String]()
    
   db.collection("manufacturers").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
                //print("\(document.documentID) => \(document.data())")
                parts.append("\(document.data()["man"]!)")
            }
        }
    self.delegate?.didUpdateList(manu: parts)
    }
    
}
}
