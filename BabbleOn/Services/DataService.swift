//
//  DataService.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-26.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var refBase: DatabaseReference {
        return _REF_BASE
    }
    
    var refUsers: DatabaseReference {
        return _REF_USERS
    }
    
    var refGroups: DatabaseReference {
        return _REF_GROUPS
    }
    
    var refFeed: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        refUsers.child(uid).updateChildValues(userData)
    }
    
}
