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
    
    
    @IBAction func detailShare(_ sender: Any) {
        var text = ""
                
               
        text.append(contentsOf: "\(detailPart?.catridge ?? "N/A")\n")
        text.append(contentsOf: "\(detailPart?.computer ?? "N/A")\n")
        text.append(contentsOf: "\(detailPart?.partNum ?? "N/A")\n")
        text.append(contentsOf: "\(detailPart?.rarity ?? "N/A")\n")
        text.append(contentsOf: "\(detailPart?.romUse ?? "N/A")\n")
        text.append(contentsOf: "\(detailPart?.yearMade ?? "N/A")\n")
                
                
                // set up activity view controller
                let textToShare = [ text ]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
       
                self.present(activityViewController, animated: true, completion: nil)
    }
    

}
