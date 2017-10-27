//
//  EnumsAndGlobalConstants.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-26.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import Foundation

enum Identifiers: String {
    case authVC = "AuthVC"
    case loginVC = "LoginVC"
    case feedVC = "FeedVC"
    case groupsVC = "GroupsVC"
    case feedCell = "feedCell"
    case groupsCell = "groupsCell"
}

enum DatabaseKeys: String {
    case provider = "provider"
    case email = "email"
}
