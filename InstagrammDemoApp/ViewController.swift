//
//  ViewController.swift
//  InstagrammDemoApp
//
//  Created by Daniil Vereschagin on 1/12/19.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system);
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        button.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        return button;
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[.editedImage] as? UIImage {
            plusPhotoButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let orImage = info[.originalImage] as? UIImage {
            plusPhotoButton.setImage(orImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2;
        plusPhotoButton.layer.masksToBounds = true;
        plusPhotoButton.layer.borderWidth = 3;
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        self.dismiss(animated: true, completion: nil);
    }
    
    let emailTextField: UITextField = {
        let tf = UITextField();
        tf.placeholder = "email"
        tf.backgroundColor =  UIColor(white: 0, alpha: 0.03);
        tf.borderStyle = .roundedRect;
        tf.font = UIFont.systemFont(ofSize: 14);
        tf.addTarget(self, action: #selector(handleEditChange), for: .editingChanged);
        tf.translatesAutoresizingMaskIntoConstraints = false;
        return tf
    }()
    
    let userTextField: UITextField = {
        let tf = UITextField();
        tf.placeholder = "user"
        tf.backgroundColor =  UIColor(white: 0, alpha: 0.03);
        tf.borderStyle = .roundedRect;
        tf.font = UIFont.systemFont(ofSize: 14);
        tf.addTarget(self, action: #selector(handleEditChange), for: .editingChanged);
        tf.translatesAutoresizingMaskIntoConstraints = false;
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField();
        tf.placeholder = "password"
        tf.isSecureTextEntry = true;
        tf.backgroundColor =  UIColor(white: 0, alpha: 0.03);
        tf.borderStyle = .roundedRect;
        tf.font = UIFont.systemFont(ofSize: 14);
        tf.addTarget(self, action: #selector(handleEditChange), for: .editingChanged);
        tf.translatesAutoresizingMaskIntoConstraints = false;
        return tf
    }()
    
    let signUpButton: UIButton = {
        let signButton = UIButton(type: .system);
        signButton.setTitle("Sign Up", for: .normal);
        signButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244);
        signButton.tintColor = UIColor.white;
        signButton.layer.cornerRadius = 5;
        signButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14);
        signButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        signButton.isEnabled = false
        return signButton
    }();
    
    
    let activityIndicator: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView();
        ac.color = UIColor.gray;
        return ac;
    }();
    
    @objc func handleEditChange() {
        let isEmailValid =
            emailTextField.text?.count ?? 0 > 0
            &&
            userTextField.text?.count ?? 0 > 0
            &&
            passwordTextField.text?.count ?? 0 > 0
        
        if isEmailValid {
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237);
            signUpButton.isEnabled = true;
        } else {
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244);
        }
    }
    
    @objc func pickImage() {
        let picker = UIImagePickerController();
        picker.allowsEditing = true;
        picker.delegate = self;
        present(picker, animated: true);
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return };
        guard let password = passwordTextField.text else { return };

        Auth.auth().createUser(withEmail: email, password: password, completion: { (authResult, error: Error?) in
            if let error = error {
                print("erorr:", error);
                return;
            }
            
            guard let image = self.plusPhotoButton.imageView?.image else { return };
            guard let uploadData = image.jpegData(compressionQuality: 0.75) else { return };
            let filename = NSUUID().uuidString

            Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil) {
                (metadata, err) in
                if let err = err {
                    print("failed", err);
                }
                
                Storage.storage().reference().child("profile_images").child(filename).downloadURL(completion: {
                    (url, error) in
                    if let err = error {
                        print("failed", err)
                    }
                    
                    guard let id = authResult?.user.uid else { return }
                    guard let url = url else { return }
                    
                    let dictinary: [String: Any] = [
                        "username": self.userTextField.text!,
                        "profile_image_url": url.absoluteString
                    ];
                    
                    let values = [id: dictinary];
                    
                    let ref = Database.database().reference();
                    
                    ref.child("users").updateChildValues(values) { (err, ref) in
                        if let error = err {
                            print("Failed", error)
                            return
                        }
                        
                        
                        
                    }
                    
                })
               
            }
            
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(plusPhotoButton);
        view.addSubview(emailTextField);
        
        
        plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true;
        plusPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true;
        plusPhotoButton.topAnchor.constraint(equalTo:view.topAnchor, constant: 40).isActive = true;
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        
        setupStackView();
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    fileprivate func setupStackView() {
//        let stackview: UIStackView;
        let greenView = UIView();
        greenView.backgroundColor = .green
        
        let redView = UIView();
        redView.backgroundColor = .red
        
        let stackview = UIStackView(arrangedSubviews: [emailTextField, userTextField, passwordTextField, signUpButton]);
        stackview.axis = .vertical;
        stackview.spacing = 10;
        stackview.distribution = .fillEqually;
        
        view.addSubview(stackview);
    
        stackview.anchor(top: plusPhotoButton.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor,height: 200, width: 300, paddingTop: 40, paddingBottom: 0, paddingLeft: 40, paddingRight: -40);
    }

}

