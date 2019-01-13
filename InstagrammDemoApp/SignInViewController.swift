//
//  SignInViewController.swift
//  InstagrammDemoApp
//
//  Created by Daniil Vereschagin on 1/13/19.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system);
//        button.setTitle("Sign ", for: .normal)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)
            ]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.tintColor = UIColor.white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        button.layer.cornerRadius = 3
        return button
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        
        let imageView = UIImageView(image: UIImage(named: "Instagram_logo_white-1")?.withRenderingMode(.alwaysOriginal))
        imageView.tintColor = UIColor.white
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
        imageView.anchor(top: nil, bottom: nil, left: nil, right: nil, height: 50, width: 200, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)

        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField();
        tf.placeholder = "email"
        tf.backgroundColor =  UIColor(white: 0, alpha: 0.03);
        tf.borderStyle = .roundedRect;
        tf.font = UIFont.systemFont(ofSize: 14);
//        tf.addTarget(self, action: #selector(handleEditChange), for: .editingChanged);
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField();
        tf.placeholder = "password"
        tf.isSecureTextEntry = true;
        tf.backgroundColor =  UIColor(white: 0, alpha: 0.03);
        tf.borderStyle = .roundedRect;
        tf.font = UIFont.systemFont(ofSize: 14);
//        tf.addTarget(self, action: #selector(handleEditChange), for: .editingChanged);
        return tf
    }()
    
    
    @objc fileprivate func handleSignUp() {
        let signUpViewController = SignUpViewController();
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    @objc fileprivate func handleSignIn() {
        guard let MainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
        MainTabBarController.setupViewControllers();
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signInButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        view.addSubview(headerView)
        view.addSubview(signUpButton)
        view.addSubview(stackView)
        
        headerView.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, height: 200, width: view.frame.width, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
        
        stackView.anchor(top: headerView.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, height: 140, width: 300, paddingTop: 40, paddingBottom: 0, paddingLeft: 24, paddingRight: 24)
        signUpButton.anchor(top: nil, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50, width: 50, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)

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
