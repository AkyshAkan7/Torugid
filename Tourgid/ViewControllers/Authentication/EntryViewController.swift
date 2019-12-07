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
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupView() {
        Utilities.styleLoginButton(loginButton)
        Utilities.styleButton(signUpButton)
    }

}
