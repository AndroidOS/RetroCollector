//
//  ListViewController.swift
//  RetroCollector
//
//  Created by Manuel Carvalho on 6/8/20.
//  Copyright © 2020 Manuel Carvalho. All rights reserved.
//

import UIKit
import Firebase

class ListViewController: UIViewController, UITableViewDelegate, FirebaseDataManagerDelegate, UITableViewDataSource   {
    
    
    
    var dataManager = FirebaseDataManager()
    
    let db = Firestore.firestore()
    
    var parts = [Part]()
    
    var parts2 = [String]()
    
    var detailPart:Part? = nil
    
    @IBOutlet weak var lblHeading: UILabel!
    
    @IBOutlet weak var lblText: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.delegate = self
        dataManager.fetchFirebaseData()
        
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 600
        tableView.rowHeight = 100
        
        queryParts()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parts2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RetroTableViewCell
       // cell.textLabel?.text = self.parts2[indexPath.row]
        cell.lblHeading?.text = self.parts[indexPath.row].catridge
        cell.lblText?.text = self.parts[indexPath.row].partNum
        //print("cellForRowAtIndexPath")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailPart = parts[indexPath.row]
     performSegue(withIdentifier: "showDetail", sender: nil)
    }
    

    @IBAction func btnShare(_ sender: UIBarButtonItem) {
        var text = ""
        
        for s in parts2 {
            text.append(contentsOf: "\(s)\n")
        }
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
//
//               // exclude some activity types from the list (optional)
//        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func btnLogout(_ sender: UIBarButtonItem) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "logout") {
            
           print("Logout Segue")
            
            do {
                try Auth.auth().signOut()
            } catch  {
                print("Logout Error")
            }
            
        }
        if (segue.identifier == "showDetail") {
            
           print("showDetail Segue")
            
            if let detailViewController = segue.destination as? DetailViewController {
                detailViewController.detailPart = detailPart
                   }
            
        }
        
        
        
    }
    
    func didUpdateList(manu: [String]) {
        parts2 = manu
        self.tableView.reloadData()
    }
    
    func queryParts(){
        // Create a reference to the cities collection
        let cartsRef = db.collection("carts")
        
       // var count = ""
        

        // Create a query against the collection.
        let query: Void = cartsRef.whereField("manufacturer", isEqualTo: "Commodore").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                       if let cart = document.data()["catridge"] as? String {
                            
                                if let computer = document.data()["computer"] as? String {
                                    if let condition = document.data()["condition"] as? String {
                                        if let gamePlay = document.data()["gamePlay"] as? String {
                                            if let manu = document.data()["manufacturer"] as? String {
                                                if let partNum = document.data()["partNum"] as? String {
                                                    if let rarity = document.data()["rarity"] as? String {
                                                        if let romUse = document.data()["romUse"] as? String {
                                                            if let yearMade = document.data()["yearMade"] as? String {
                                                                
                                                                let newPart = Part(catridge: cart, computer: computer, condition: condition, gamePlay: gamePlay, manufacturer: manu, partNum: partNum, rarity: rarity, romUse: romUse, yearMade: yearMade)
                                                                
                                                                self.parts.append(newPart)
                                                            }
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                  
                    }
                }
        }
        
        //print("\(query)")
    }
    
    
}
