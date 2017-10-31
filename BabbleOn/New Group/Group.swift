//
//  Group.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-31.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import Foundation

class Group {
    
    private var _groupTitle: String
    private var _groupDescription: String
    private var _key: String
    private var _memberCount: Int
    private var _members: [String]
    
    var groupTitle: String {
        return _groupTitle
    }
    
    var groupDescription: String {
        return _groupDescription
    }
    
    var memeberCount: Int {
        return _memberCount
    }
    
    var key: String {
        return _key
    }
    
    var members: [String] {
        return _members
    }
    
    init(groupTitle: String, groupDescription: String, key: String, memberCount: Int, members: [String]) {
        self._groupTitle = groupTitle
        self._groupDescription = groupDescription
        self._key = key
        self._memberCount = memberCount
        self._members = members
    }
}



