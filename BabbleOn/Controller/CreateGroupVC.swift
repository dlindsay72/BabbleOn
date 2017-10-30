//
//  CreateGroupVC.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-30.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

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
    
    //MARK: - Main Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        enterEmailTextField.delegate = self
        enterEmailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

    }
    
    //MARK: - Custom Methods
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
        
    }
    
}

//MARK: - UITableVieDelegate and DataSource
extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.userCell.rawValue) as? UserCell else {
            return UITableViewCell()
        }
        let profileImage = UIImage(named: "defaultProfileImage")
        cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
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
}

//MARK: - UITextFieldDelegate
extension CreateGroupVC: UITextFieldDelegate {
    
}







