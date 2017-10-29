//
//  FeedCell.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-28.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.profileImage.image = profileImage
        self.userEmailLbl.text = email
        self.contentLbl.text = content
    }

}
