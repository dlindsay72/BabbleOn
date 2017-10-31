//
//  GroupsCell.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-31.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class GroupsCell: UITableViewCell {
    
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescriptionLbl: UILabel!
    @IBOutlet weak var memberslbl: UILabel!
    
    func configureCell(title: String, description: String, memberCount: Int) {
        self.groupTitleLbl.text = title
        self.groupDescriptionLbl.text = description
        self.memberslbl.text = "\(memberCount) members."
    }
    
}
