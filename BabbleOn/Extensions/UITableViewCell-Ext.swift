//
//  UITableViewCell-Ext.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-30.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func changeSelectedBackgroundColor() {
        let selectedBGColorView = UIView()
        selectedBGColorView.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        self.selectedBackgroundView = selectedBGColorView
    }
}
