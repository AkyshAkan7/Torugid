//
//  User.swift
//  Tourgid
//
//  Created by Akan Akysh on 11/27/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import Foundation

struct UserProfile {
    var firstName: String
    var lastName: String
    var email: String
    var profileImageUrl: URL
    
    
    init(firstName: String, lastName: String, email: String, profileImageUrl: URL) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.profileImageUrl = profileImageUrl
    }
}
