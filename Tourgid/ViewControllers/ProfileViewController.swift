//
//  ProfileViewController.swift
//  Tourgid
//
//  Created by Akan Akysh on 11/11/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var signOutLabel: UIButton!
    @IBOutlet weak var loginLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.signOutLabel.isHidden = false
                self.loginLabel.isHidden = true
            } else {
                self.signOutLabel.isHidden = true
                self.loginLabel.isHidden = false
            }
        }
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        try! Auth.auth().signOut()
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
