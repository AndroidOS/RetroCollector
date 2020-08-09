//
//  ListViewController.swift
//  RetroCollector
//
//  Created by Manuel Carvalho on 6/8/20.
//  Copyright © 2020 Manuel Carvalho. All rights reserved.
//

import UIKit
import Firebase

class ListViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource  {
    
    let db = Firestore.firestore()
    
    var parts = [Part]()
    
    var parts2 = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("manufacturers").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.parts2.append("\(document.data()["man"]!)")
                }
            }
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parts2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RetroTableViewCell
        cell.textLabel?.text = self.parts2[indexPath.row]
        print("cellForRowAtIndexPath")
        return cell
    }
    

}
