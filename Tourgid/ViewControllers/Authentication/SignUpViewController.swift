//
//  SignUpViewController.swift
//  Tourgid
//
//  Created by Akan Akysh on 11/7/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    
    @IBOutlet weak var firstNameBottomLine: UIView!
    @IBOutlet weak var lastNameBottomLine: UIView!
    @IBOutlet weak var emailBottomLine: UIView!
    @IBOutlet weak var passwordBottomLine: UIView!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var passwordIsHidden: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        firstNameTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupView() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        firstNameTextField.returnKeyType = .next
        lastNameTextField.returnKeyType = .next
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .done
        
        firstNameLabel.isHidden = true
        lastNameLabel.isHidden = true
        emailLabel.isHidden = true
        passwordLabel.isHidden = true
        passwordWarningLabel.isHidden = true
        
        errorLabel.alpha = 0
        
        Utilities.styleButton(signUpButton)
    }
    
    @IBAction func showHideButtonTapped(_ sender: Any) {
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
    

    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate text fields
        let error = validateFields()
        
        if error == nil {
            performSegue(withIdentifier: "goToAvatarPickerVC", sender: nil)
        } else {
            showError(error!)
        }
    }
    
    func validateFields() -> String? {
        if firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        // check if the email is valid
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isEmailValid(cleanedEmail) == false {
            return "Please type correct email"
        }
        
        // check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 6 character long, contain 1 letter and 1 number"
        }
        
        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAvatarPickerVC" {
            
            // Create cleaned version of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let viewController = segue.destination as! AvatarPickerViewController
            
            viewController.firstName = firstName
            viewController.lastName = lastName
            viewController.email = email
            viewController.password = password
        }
    }
    
}

// MARK: - text field delegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            textField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
            return true
        } else if textField == lastNameTextField {
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
            return true
        } else if textField == emailTextField {
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
        if textField == firstNameTextField {
            firstNameLabel.isHidden = false
            firstNameLabel.textColor = .systemBlue
            firstNameBottomLine.backgroundColor = .systemBlue
        } else if textField == lastNameTextField {
            lastNameLabel.isHidden = false
            lastNameLabel.textColor = .systemBlue
            lastNameBottomLine.backgroundColor = .systemBlue
        } else if textField == emailTextField {
            emailLabel.isHidden = false
            emailLabel.textColor = .systemBlue
            emailBottomLine.backgroundColor = .systemBlue
        } else if textField == passwordTextField {
            passwordLabel.isHidden = false
            passwordWarningLabel.isHidden = false
            passwordLabel.textColor = .systemBlue
            passwordBottomLine.backgroundColor = .systemBlue
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == firstNameTextField {
            firstNameLabel.textColor = .black
            firstNameBottomLine.backgroundColor = .black
            
            if firstNameTextField.text!.isEmpty {
                firstNameLabel.textColor = .lightGray
                firstNameBottomLine.backgroundColor = .lightGray
            }
            
        } else if textField == lastNameTextField {
            lastNameLabel.textColor = .black
            lastNameBottomLine.backgroundColor = .black
            
            if firstNameTextField.text!.isEmpty {
                lastNameLabel.textColor = .lightGray
                lastNameBottomLine.backgroundColor = .lightGray
            }
            
        } else if textField == emailTextField {
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
                passwordWarningLabel.isHidden = true
            }
            
        }
    }
}
