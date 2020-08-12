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
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.delegate = self
        dataManager.fetchFirebaseData()    
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
    

    @IBAction func btnLogout(_ sender: UIBarButtonItem) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "logout") {
            
           print("Logout Segue")
            
            do {
                try Auth.auth().signOut()
            } catch is Error {
                print("Logout Error")
            }
            
        }
        
    }
    
    func didUpdateList(manu: [String]) {
        parts2 = manu
        self.tableView.reloadData()
    }
}
