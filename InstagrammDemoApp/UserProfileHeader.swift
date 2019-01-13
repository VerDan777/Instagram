//
//  UserProfileHeader.swift
//  InstagrammDemoApp
//
//  Created by Daniil Vereschagin on 1/12/19.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
    let imageView: UIImageView = {
        let im = UIImageView();
        im.backgroundColor = .red
        return im
    }();
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system);
        button.setImage(UIImage(named: "grid"), for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system);
        button.setImage(UIImage(named: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system);
        button.setImage(UIImage(named: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let name: UILabel = {
        let lb = UILabel();
        lb.text = "username"
        lb.textColor = UIColor.black
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        return lb
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel();
        let attributedText = NSMutableAttributedString(string: "11111\n", attributes: [NSAttributedString.Key.foregroundColor:
            UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
            ])
        
        attributedText.append(NSMutableAttributedString(string: "posts", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
            ]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel();
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.foregroundColor:
            UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
            ])
        
        attributedText.append(NSMutableAttributedString(string: "followers", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
            ]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel();
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.foregroundColor:
            UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
            ])
        
        attributedText.append(NSMutableAttributedString(string: "following", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
            ]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profie", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 3
       return button
    }()
    
    var user: User? {
        didSet {
            name.text = user?.username
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(name);
        setupToolBar()
        setupStats()
        setupDivider()
        
        imageView.anchor(top: self.topAnchor, bottom: nil, left: self.leftAnchor, right: nil, height: 80, width: 80, paddingTop: 20, paddingBottom: 0, paddingLeft: 12, paddingRight: 0)

        name.anchor(top: imageView.bottomAnchor, bottom: gridButton.topAnchor, left: leftAnchor, right: rightAnchor, height: 0, width: 0, paddingTop: 20, paddingBottom: 10, paddingLeft: 20, paddingRight: 0)
        addSubview(editButton)
        
        editButton.anchor(top: postsLabel.bottomAnchor, bottom: nil, left: imageView.rightAnchor, right: rightAnchor, height: 34, width: 0, paddingTop: 2, paddingBottom: 8, paddingLeft: 12, paddingRight: 12)
        
        imageView.layer.cornerRadius = 80 / 2;
        imageView.clipsToBounds = true;
        fetchImageProfile();
        
    }
    
    fileprivate func setupDivider() {
        let topDivider = UIView();
        topDivider.backgroundColor = UIColor.lightGray;
        let bottomDivider = UIView();
        bottomDivider.backgroundColor = UIColor.lightGray;
        
        addSubview(topDivider)
//        addSubview(bottomDivider)
        
        topDivider.anchor(top: name.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, height: 0.5, width: 0, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
//        bottomDivider.anchor(top: gridButton.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, height: 0.5, width: 0, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
        
        
    }
    
    fileprivate func setupToolBar() {
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.anchor(top: name.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, height: 50, width: 0, paddingTop: 30, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
    }
    
    fileprivate func setupStats() {
        let statsSubView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel]);
        statsSubView.distribution = .fillEqually
        statsSubView.axis = .horizontal
        
        addSubview(statsSubView)
        
        statsSubView.anchor(top: topAnchor, bottom: nil, left: imageView.rightAnchor, right: rightAnchor, height: 50, width: 0, paddingTop: 12, paddingBottom: 12, paddingLeft: 0, paddingRight: 0)
    }
    
    fileprivate func fetchImageProfile() {
        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/instagrammdemoapp.appspot.com/o/profile_images%2FAB22C656-94A0-4317-804D-1EF00BE86A75?alt=media&token=29fa661e-d990-4e3d-910c-843c0a75d1db") else { return }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print("error", error)
                return
            }
            
            guard let data = data else { return }
            
            let image = UIImage(data: data);
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            
        }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
