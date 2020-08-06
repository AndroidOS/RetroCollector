//
//  ViewController.swift
//  RetroCollector
//
//  Created by Manuel Carvalho on 4/8/20.
//  Copyright © 2020 Manuel Carvalho. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().createUser(withEmail: "lizz@gmail.com", password: "123456"){ authResult, error in
            if (error != nil){
                self.lblError.text = "\(error!)"
                print(error!)
            } else {
                print(authResult!)
            }
        }


}

    @IBAction func btnLogin(_ sender: UIButton) {
    }
}
