//
//  MyProfileVC.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-27.
//  Copyright © 2017 Dan Lindsay. All rights reserved.

/*
 JHTAlertController copyright below
 
 MIT License
 
 Copyright (c) 2016 Jacuzzi Hot Tubs, LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 */

import UIKit
import Firebase
import JHTAlertController


class MyProfileVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Main Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userEmailLbl.text = Auth.auth().currentUser?.email
    }
    
    //MARK: - IBActions

    @IBAction func logoutBtnWasPressed(_ sender: Any) {

        let logoutPopup = JHTAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let popover = logoutPopup.popoverPresentationController
        logoutPopup.alertBackgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)  //#colorLiteral(red: 0.258797586, green: 0.2588401437, blue: 0.2587882876, alpha: 1)
        logoutPopup.dividerColor = #colorLiteral(red: 0.619772613, green: 0.8343737721, blue: 0.3795454502, alpha: 1)
        logoutPopup.titleTextColor = #colorLiteral(red: 0.619772613, green: 0.8343737721, blue: 0.3795454502, alpha: 1)
        logoutPopup.messageTextColor = #colorLiteral(red: 0.2492365539, green: 0.7473707795, blue: 0.9988636374, alpha: 1)
        logoutPopup.titleFont = UIFont(name: "American Typewriter", size: 30)
        logoutPopup.titleViewBackgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        popover?.permittedArrowDirections = []
        popover?.sourceView = view
        
        popover?.sourceRect = CGRect(x: 0, y: self.view.bounds.midY, width: self.view.bounds.width, height: 0)
        let logoutAction = JHTAlertAction(title: "_logout", style: .default) { (buttonTapped) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: Identifiers.authVC.rawValue) as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        let cancelAction = JHTAlertAction(title: "_cancel", style: .cancel, bgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), handler: nil)
        logoutPopup.addActions([logoutAction, cancelAction])
        present(logoutPopup, animated: true, completion: nil)
    }
}







