//
//  ListViewController.swift
//  RetroCollector
//
//  Created by Manuel Carvalho on 6/8/20.
//  Copyright © 2020 Manuel Carvalho. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource  {
    
    let streets = ["Albemarle", "Brandywine", "Chesapeake"]
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RetroTableViewCell
        cell.textLabel?.text = self.streets[indexPath.row]
        print("cellForRowAtIndexPath")
        return cell
    }
    

}
