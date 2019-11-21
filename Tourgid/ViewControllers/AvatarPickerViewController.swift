//
//  AvatarPickerViewController.swift
//  Tourgid
//
//  Created by Akan Akysh on 11/17/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class AvatarPickerViewController: UIViewController {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addProfileImageButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    var firstName: String! = nil
    var lastName: String! = nil
    var email: String! = nil
    var password: String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setValue()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        guard let fname = firstName else { return }
        guard let lname = lastName else { return }
        guard let mail = email else { return }
        guard let pswd = password else { return }
        guard let image = profileImageView.image else { return }
        
        Auth.auth().createUser(withEmail: mail, password: pswd) { (result, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                // Upload the profile image to Firebase storage
                self.uploadProfileImage(image) { url in
                    
                    if url != nil {
                        
                        // Save user data to database
                        let db = Firestore.firestore()
                        db.collection("users").addDocument(data: ["firstname": fname,
                                                                  "lastname": lname,
                                                                  "email": mail,
                                                                  "profileImageURL": url!.absoluteString,
                                                                  "uid": result!.user.uid]) { (error) in
                                                                    
                            if error != nil {
                                print(error!.localizedDescription)
                            } else {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                        
                    } else {
                        print("Error while uploading profile image")
                    }
                    
                }
                
                    
            }
        }
    }
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping (_ url:URL?)->() ){
        guard let uid = Auth.auth().currentUser else { return }
        let storageRef = Storage.storage().reference().child("userProfileImages/\(uid)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData , error in
            if error == nil, metaData != nil {
                
                storageRef.downloadURL { url, error in
                    if error != nil {
                        completion(nil)
                    } else {
                        completion(url)
                    }
                }
            } else {
                completion(nil)
            }
        }
        
    }
    
    func setupView() {
        Utilities.styleButton(signupButton)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(imageTap)
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        
        addProfileImageButton.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
    }
    
    func setValue() {
        if firstName != nil, lastName != nil, email != nil {
            
        }
        fullNameLabel.text = firstName + " " + lastName
        emailLabel.text = email
    }
    
    @objc func chooseImage() {
        let actionSheet = UIAlertController(title: "Choose a photo source", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }

}

// MARK: - image picker controller delegate
extension AvatarPickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImageView.image = pickedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageView.image = originalImage
        }
         
        picker.dismiss(animated: true, completion: nil)
    }
}
