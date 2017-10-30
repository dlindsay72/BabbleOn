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
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
        if groupKey != nil {
            // send to groups reference
        } else {
            refFeed.childByAutoId().updateChildValues([DatabaseKeys.content.rawValue: message, DatabaseKeys.senderId.rawValue: uid])
            sendComplete(true)
        }
    }
    
    func getAllMessages(handler: @escaping (_ messages: [Message]) -> ()) {
        var messageArray = [Message]()
        refFeed.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: DatabaseKeys.content.rawValue).value as! String
                let senderId = message.childSnapshot(forPath: DatabaseKeys.senderId.rawValue).value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            
            handler(messageArray)
        }
    }
    
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        refUsers.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: DatabaseKeys.email.rawValue).value as! String)
                }
            }
        }
    }
    
}








