//
//  UserCell.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-30.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import Firebase

class UserCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    
    var showing = false

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            if showing == false {
                checkmarkImage.isHidden = false
                showing = true
            } else {
                checkmarkImage.isHidden = true
                showing = false
            }
        }
    }
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool) {
        profileImage.image = image
        emailLbl.text = email
        if isSelected {
            checkmarkImage.isHidden = false //possibly use self here if any problems
        } else {
            checkmarkImage.isHidden = true
        }
    }

}
