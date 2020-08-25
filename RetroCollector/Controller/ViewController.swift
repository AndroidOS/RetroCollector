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
        navigationItem.hidesBackButton = true
        //performSegue(withIdentifier: "toList", sender: nil)
        



}
    
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: txtEmail.text ?? "", password: txtPassword.text ?? "") { [weak self] authResult, error in
          //guard let strongSelf = self else { return }
            if(error != nil){
                self?.lblError.text = "\(error!)"
            } else {
                self?.performSegue(withIdentifier: "toList", sender: nil)
            }
        }
        
    }
    
    
}
