//
//  EntryViewController.swift
//  Tourgid
//
//  Created by Akan Akysh on 11/17/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        loginButton.layer.cornerRadius = 10
        loginButton.layer.shadowOpacity = 1
        loginButton.layer.shadowRadius = 4
        loginButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        loginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.shadowOpacity = 1
        signUpButton.layer.shadowRadius = 4
        signUpButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        signUpButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        
    }

}
