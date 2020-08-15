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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parts2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RetroTableViewCell
       // cell.textLabel?.text = self.parts2[indexPath.row]
        cell.lblHeading?.text = self.parts2[indexPath.row]
        print("cellForRowAtIndexPath")
        return cell
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
        
    }
    
    func didUpdateList(manu: [String]) {
        parts2 = manu
        self.tableView.reloadData()
    }
}
