//
//  UserProfileController.swift
//  InstagrammDemoApp
//
//  Created by Daniil Vereschagin on 1/12/19.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var images: [String] = [
        "https://images.unsplash.com/photo-1540202404-fad3e2190841?ixlib=rb-1.2.1&ixidvarJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",
        "https://images.unsplash.com/photo-1542841791-3f32162641bc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
        "https://images.unsplash.com/photo-1547200413-5f93d7e3673e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
        "https://images.unsplash.com/photo-1547185942-2b5661136b1b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1051&q=80",
        "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1052&q=80",
        "https://images.unsplash.com/photo-1522083165195-3424ed129620?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1160&q=80",
        "https://images.unsplash.com/photo-1500916434205-0c77489c6cf7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=633&q=80",
        "https://images.unsplash.com/photo-1506598417715-e3c191368ac0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
        "https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white;
        
        fetchUser();
        
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView?.register(UserProfileCellCollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
        
        setupLogoutIcon()
    }
    
//    fileprivate func fetchImage() {
////        guard let imageURL = imageUrl else { return }
////        guard let url = URL(string: imageURL) else { return }
////        URLSession.shared.dataTask(with: url) { (data, response, error) in
////            if let error = error {
////                print("Failed", error)
////            }
////
////            guard let data = data else { return }
////
////            DispatchQueue.main.async {
////                self.imageView.image = UIImage(data: data)
////            }
////
////            }.resume()
//    }
    
    fileprivate func setupLogoutIcon() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
       
    }
    
    @objc func handleLogout() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logout = UIAlertAction(title: "Logout", style: .default, handler: { (_) in
            let navController = UINavigationController(rootViewController: SignInViewController())
            self.present(navController, animated: true)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        ac.addAction(logout)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(images[indexPath.row])
        
//        let viewFullController = UIViewController();
//        viewFullController.view.backgroundColor = .red
//        self.present(viewFullController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 2) / 3, height: view.frame.width / 3 )
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! UserProfileCellCollectionViewCell
        print(images[indexPath.row])
        cell.imageUrl = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! UserProfileHeader
        self.user = User(json: ["username": "Danya", "profile_image_url": "https://firebasestorage.googleapis.com/v0/b/instagrammdemoapp.appspot.com/o/profile_images%2FAB22C656-94A0-4317-804D-1EF00BE86A75?alt=media&token=29fa661e-d990-4e3d-910c-843c0a75d1db"]);
        header.user = self.user
        return header;
    }
    
    var user: User?
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: {
            (snapshot) in
//            guard let dictionary = snapshot.value as? [String:Any] else { return }
            self.user = User(json: ["username": "Danya", "profile_image_url": "https://firebasestorage.googleapis.com/v0/b/instagrammdemoapp.appspot.com/o/profile_images%2FAB22C656-94A0-4317-804D-1EF00BE86A75?alt=media&token=29fa661e-d990-4e3d-910c-843c0a75d1db"]);
            let name = self.user?.username
            self.navigationItem.title = name
        })
        
    }
}


struct User {
    var username: String?
    var profileImageUrl: String
    
    init(json: [String: Any]) {
        self.username = json["username"] as! String? ?? ""
        self.profileImageUrl = json["profile_image_url"] as? String ?? ""
    }
}
