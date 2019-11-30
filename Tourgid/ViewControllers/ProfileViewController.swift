//
//  ProfileViewController.swift
//  Tourgid
//
//  Created by Akan Akysh on 11/11/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import FirebaseAuth
import MBProgressHUD

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var signOutLabel: UIButton!
    @IBOutlet weak var loginLabel: UIButton!
    
    fileprivate var listener: AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        didChangeListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(listener)
    }
    
    func didChangeListener() {
        listener = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                
                UserService.observeUserProfile(user!.uid) { userProfile in
                    
                    self.fullnameLabel.text = (userProfile?.firstName ?? "") + " " + (userProfile?.lastName ?? "")
                    self.emailLabel.text = userProfile?.email ?? ""
                    let imageUrl = userProfile!.profileImageUrl
                    ImageService.getImage(withUrl: imageUrl) { image in
                        self.profileImageView.image = image
                    }
                }
                
                self.fullnameLabel.isHidden = false
                self.emailLabel.isHidden = false
                self.signOutLabel.isHidden = false
                self.loginLabel.isHidden = true
                
            } else {
                
                self.fullnameLabel.isHidden = true
                self.emailLabel.isHidden = true
                self.signOutLabel.isHidden = true
                self.loginLabel.isHidden = false
                self.profileImageView.image = UIImage(named: "user")
                
            }
        }
        
    }
    
    func setupView() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        try! Auth.auth().signOut()
    }

}
