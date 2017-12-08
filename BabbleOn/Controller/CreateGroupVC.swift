//
//  CreateGroupVC.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-30.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var enterEmailTextField: InsetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    //MARK: - Properties
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    //MARK: - Main Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        enterEmailTextField.delegate = self
        enterEmailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
//        self.view.addGestureRecognizer(tap)
    }
    
    //MARK: - Custom Methods
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func textFieldDidChange() {
        if enterEmailTextField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: enterEmailTextField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }
    
    //MARK: - IBActions

    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        if titleTextField.text != "" && descriptionTextField.text != "" {
            DataService.instance.getIds(forUsernames: chosenUserArray, handler: { (idsArray) in
                var userIds = idsArray
                if let currentUserUid = Auth.auth().currentUser?.uid {
                    userIds.append(currentUserUid)
                }
                DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIfs: userIds, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Group could not be created. Please try again.")
                    }
                })
                
            })
        }
    }
    
}

//MARK: - UITableVieDelegate and DataSource
extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.userCell.rawValue) as? UserCell else {
            return UITableViewCell()
        }
        let profileImage = UIImage(named: "defaultProfileImage")
        if chosenUserArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        
        cell.changeSelectedBackgroundColor()
        cell.emailLbl.highlightedTextColor = #colorLiteral(red: 0.1679556072, green: 0.6836873889, blue: 0.7895566821, alpha: 1)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {
            return
        }
        if !chosenUserArray.contains(cell.emailLbl.text!) {
            chosenUserArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLbl.text! })
            if chosenUserArray.count >= 1 {
                groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            } else {
                groupMemberLbl.text = "add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
}

//MARK: - UITextFieldDelegate
extension CreateGroupVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterEmailTextField.resignFirstResponder()
        return true
    }
}







