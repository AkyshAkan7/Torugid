//
//  UserService.swift
//  Tourgid
//
//  Created by Akan Akysh on 11/26/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import FirebaseFirestore

class UserService {
    
    static func observeUserProfile(_ uid: String, completion: @escaping (_ userProfile: UserProfile?) ->()) {
        let ref = Firestore.firestore().collection("users").document(uid)
        
        ref.getDocument { document, error in
            var userProfile: UserProfile?
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let document = document, document.exists {
                let firstName = document["firstname"] as! String
                let lastName = document["lastname"] as! String
                let email = document["email"] as! String
                let profileImageUrl = document["profileImageUrl"] as! String
                let url = URL(string: profileImageUrl)!
                
                userProfile = UserProfile(firstName: firstName, lastName: lastName, email: email, profileImageUrl: url)
            }
            
            completion(userProfile)
        }
    }
    
}

