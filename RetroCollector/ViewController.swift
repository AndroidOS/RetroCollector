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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Auth.auth().createUser(withEmail: "tom@gmail.com", password: "123456"){
        Auth.auth().createUser(withEmail: "lizz@gmail.com", password: "123456"){ authResult, error in
            if (error != nil){
                print(error!)
            } else {
                print(authResult!)
            }
        }


}

}
