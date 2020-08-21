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
    @IBOutlet weak var lblPartNum: UILabel!
    @IBOutlet weak var lblRarity: UILabel!
    @IBOutlet weak var lblYearMade: UILabel!
    @IBOutlet weak var lblRomUse: UILabel!
    @IBOutlet weak var lblComputer: UILabel!
    
    var detailPart:Part? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        fillUI()
        // Do any additional setup after loading the view.
        //print("\(detailPart)")
    }
    
    func fillUI()  {
        lblHeading.text = detailPart?.catridge
        lblPartNum.text = detailPart?.partNum
        lblRarity.text = detailPart?.rarity
        lblYearMade.text = detailPart?.yearMade
        lblRomUse.text = detailPart?.romUse
        lblComputer.text = detailPart?.computer
    }
    

}
