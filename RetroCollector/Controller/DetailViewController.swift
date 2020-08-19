//
//  DetailViewController.swift
//  RetroCollector
//
//  Created by Manuel Carvalho on 20/8/20.
//  Copyright © 2020 Manuel Carvalho. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lblHeading: UILabel!
    
    var detailPart:Part? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\(detailPart)")
    }
    

}
