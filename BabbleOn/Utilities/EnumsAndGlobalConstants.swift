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
    case myProfileVC = "MyProfileVC"
    case createPostVC = "CreatePostVC"
    case createGroupVC = "CreateGroupVC"
    case groupFeedVC = "GroupFeedVC"
    case feedCell = "feedCell"
    case groupsCell = "groupsCell"
    case myProfileCell = "myProfileCell"
    case userCell = "userCell"
    case groupFeedCell = "groupFeedCell"
    case segueCreatePostVC = "segueCreatePostVC"
}

enum DatabaseKeys: String {
    case provider = "provider"
    case email = "email"
    case content = "content"
    case senderId = "senderId"
    case title = "title"
    case description = "description"
    case members = "members"
    case messages = "messages"
}


