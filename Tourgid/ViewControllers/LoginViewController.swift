//
//  LoginViewController.swift
//  Tourgid
//
//  Created by Akan Akysh on 11/7/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import FirebaseAuth
import MBProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var emailBottomLine: UIView!
    @IBOutlet weak var passwordBottomLine: UIView!
    
    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var passwordIsHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupView() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .done
        
        emailLabel.isHidden = true
        passwordLabel.isHidden = true
        
        errorLabel.alpha = 0
        
        Utilities.styleButton(loginButton)
    }
    
    @IBAction func showHideButtonPressed(_ sender: Any) {
        if passwordIsHidden {
            passwordIsHidden = false
            passwordTextField.isSecureTextEntry = false
            
            let image = UIImage(named: "closedEye")
            showHideButton.setImage(image, for: .normal)
        } else {
            passwordIsHidden = true
            passwordTextField.isSecureTextEntry = true
            
            let image = UIImage(named: "eye")
            showHideButton.setImage(image, for: .normal)
        }
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // Validate text fields
        let error = validateFields()

        if error != nil {
            self.showError(error!)
        } else {
            let activityIndicator = MBProgressHUD.showAdded(to: view, animated: true)
            activityIndicator.label.text = "Login..."
            activityIndicator.backgroundView.color = .lightGray
            activityIndicator.backgroundView.alpha = 0.5
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in

                if error != nil {
                    activityIndicator.hide(animated: true)
                    self.showError(error!.localizedDescription)
                } else {
                    activityIndicator.hide(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func validateFields() -> String? {
        if emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

}

//MARK: - text field delegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return true
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailLabel.isHidden = false
            emailLabel.textColor = .systemBlue
            emailBottomLine.backgroundColor = .systemBlue
        } else if textField == passwordTextField {
            passwordLabel.isHidden = false
            passwordLabel.textColor = .systemBlue
            passwordBottomLine.backgroundColor = .systemBlue
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailLabel.textColor = .black
            emailBottomLine.backgroundColor = .black
            
            if emailTextField.text!.isEmpty {
                emailLabel.textColor = .lightGray
                emailBottomLine.backgroundColor = .lightGray
            }
            
        } else if textField == passwordTextField {
            passwordLabel.textColor = .black
            passwordBottomLine.backgroundColor = .black
            
            if passwordTextField.text!.isEmpty {
                passwordLabel.textColor = .lightGray
                passwordBottomLine.backgroundColor = .lightGray
            }
            
        }
    }
    
}
