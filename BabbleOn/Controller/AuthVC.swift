//
//  AuthVC.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-26.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func loginWithFacebookBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func loginWithGooglePlusBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func loginWithEmailBtnPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: Identifiers.loginVC.rawValue) as? LoginVC
        present(loginVC!, animated: true, completion: nil)
    }
}
