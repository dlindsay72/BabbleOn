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
            if let groupKey = groupKey {
                refGroups.child(groupKey).child(DatabaseKeys.messages.rawValue).childByAutoId().updateChildValues([DatabaseKeys.content.rawValue: message, DatabaseKeys.senderId.rawValue: uid])
            } else {
                print("Could not get the groupKey")
            }
            sendComplete(true)
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
    
    func getAllMessagesFor(desiredGroup: Group, handler: @escaping (_ messagesArray: [Message]) -> ()) {
        var groupMessageArray = [Message]()
        refGroups.child(desiredGroup.key).child(DatabaseKeys.messages.rawValue).observeSingleEvent(of: .value) { (groupMessageSnapshot) in
            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for groupMessage in groupMessageSnapshot {
                let content = groupMessage.childSnapshot(forPath: DatabaseKeys.content.rawValue).value as! String
                let senderId = groupMessage.childSnapshot(forPath: DatabaseKeys.senderId.rawValue).value as! String
                let groupMessage = Message(content: content, senderId: senderId)
                
                groupMessageArray.append(groupMessage)
            }
            handler(groupMessageArray)
        }
    }
    
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        refUsers.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: DatabaseKeys.email.rawValue).value as! String
                
                if email.contains(query) == true  && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getIds(forUsernames usernames: [String], handler: @escaping (_ uidArray: [String]) -> ()) {
        refUsers.observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: DatabaseKeys.email.rawValue).value as! String
                if usernames.contains(email) {
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    func getEmailsFor(group: Group, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        refUsers.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                if group.members.contains(user.key) {
                    let email = user.childSnapshot(forPath: DatabaseKeys.email.rawValue).value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func createGroup(withTitle title: String, andDescription description: String, forUserIfs ids: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
        refGroups.childByAutoId().updateChildValues([DatabaseKeys.title.rawValue: title, DatabaseKeys.description.rawValue: description, DatabaseKeys.members.rawValue: ids])
        handler(true)
        //may have to use the completion to handle any errors
    }
    
    func getAllGroups(handler: @escaping (_ groupsArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        refGroups.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for group in groupSnapshot {
                let memberArray = group.childSnapshot(forPath: DatabaseKeys.members.rawValue).value as! [String]
                if let currentUserUID = Auth.auth().currentUser?.uid {
                    if memberArray.contains(currentUserUID) {
                        let title = group.childSnapshot(forPath: DatabaseKeys.title.rawValue).value as! String
                        let description = group.childSnapshot(forPath: DatabaseKeys.description.rawValue).value as! String
                        
                        let group = Group(groupTitle: title, groupDescription: description, key: group.key, memberCount: memberArray.count, members: memberArray)
                        groupsArray.append(group)
                    }
                } else {
                    print("Could not get current user uid")
                }
            }
            handler(groupsArray)
        }
    }
    
    
    
}








