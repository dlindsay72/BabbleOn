//
//  GroupsVC.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-26.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func addToGroupBtnWasPressed(_ sender: Any) {
        
    }
}

extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.groupsCell.rawValue, for: indexPath) as? GroupsCell else {
            return UITableViewCell()
        }
        cell.configureCell(title: "Nerd herd", description: "bunch of smart dorks chilling...", memberCount: 3)
        cell.changeSelectedBackgroundColor()
        cell.groupTitleLbl.highlightedTextColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        cell.groupDescriptionLbl.highlightedTextColor = #colorLiteral(red: 0.6212110519, green: 0.8334299922, blue: 0.3770503998, alpha: 1)
        cell.memberslbl.highlightedTextColor = #colorLiteral(red: 0.6197391152, green: 0.8343659043, blue: 0.3749347329, alpha: 1)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}

