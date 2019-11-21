//
//  Utilities.swift
//  Tourgid
//
//  Created by Akan Akysh on 11/7/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit

class Utilities {
    
    static func styleButton(_ button: UIButton) {
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9]).{6,}")
        return passwordTest.evaluate(with: password)
    }
    
}
