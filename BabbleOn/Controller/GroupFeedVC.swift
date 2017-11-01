//
//  GroupFeedVC.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-31.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupMembersLbl: UILabel!
    @IBOutlet weak var textField: InsetTextField!
    @IBOutlet weak var textFieldStackView: UIStackView!
    
    //MARK: - Properties
    
    var group: Group?
    var groupMessages = [Message]()
    
    //MARK: - Main Methods
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.groupTitle
        if let group = group {
            DataService.instance.getEmailsFor(group: group) { (returnedEmails) in
                self.groupMembersLbl.text = returnedEmails.joined(separator: ", ")
            }
        } else {
            print("Unable to get group info")
        }
        
        DataService.instance.refGroups.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnGroupMessages) in
                self.groupMessages = returnGroupMessages
                self.tableView.reloadData()
                
                if self.groupMessages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath.init(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if textField.text != "" {
            textField.isEnabled = false
            if let currentUserUID = Auth.auth().currentUser?.uid {
                DataService.instance.uploadPost(withMessage: textField.text!, forUID: currentUserUID, withGroupKey: group?.key, sendComplete: { (complete) in
                    if complete {
                        self.textField.text = ""
                        self.textField.isEnabled = true
                    }
                })
            }
        }
        print("we got here")
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
}

//MARK: - UITableViewDelegate and DataSource

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.groupFeedCell.rawValue, for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        let image = UIImage(named: "defaultProfileImage")
        let message = groupMessages[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            cell.configureCell(profileImage: image!, email: email, content: message.content)
            cell.changeSelectedBackgroundColor()
            cell.emailLbl.highlightedTextColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            cell.contentLbl.highlightedTextColor = #colorLiteral(red: 0.6212110519, green: 0.8334299922, blue: 0.3770503998, alpha: 1)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
}

//MARK: - UITextFieldDelegate
extension GroupFeedVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
}











