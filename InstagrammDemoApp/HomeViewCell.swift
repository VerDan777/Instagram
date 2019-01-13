//
//  HomeViewCell.swift
//  InstagrammDemoApp
//
//  Created by Daniil Vereschagin on 1/14/19.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit


class HomeViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView();
        iv.contentMode = .scaleAspectFill
        return iv
    }()
//    let profileImage: UIImageView = {
//        let image = UIImageView()
//        image.backgroundColor = .blue
//        image.contentMode = .scaleAspectFill
//        image.layer.cornerRadius = 50
//        image.clipsToBounds = true
//       return image
//    }()
    
//    let header: UIStackView = {
//        let header = UIStackView(arrangedSubviews: [self.profileImage]);
//        header.backgroundColor = .red
//        addSubview(profileImage)
//        return header
//    }()
    
    var imageurl: String? {
        didSet {
            guard let urlForDonwload = imageurl else { return }
            guard let url = URL(string: urlForDonwload) else { return }
            URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                if let error = error {
                    print("fatal error", error)
                }
                
                guard let data = data else { return }
                
                let image = UIImage(data: data)
                print(image)
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }.resume()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let header = UIStackView(arrangedSubviews: [profileImage])
//        header.backgroundColor = .red
//        header.axis = .horizontal
//        header.spacing = 10
        
        
//        addSubview(header)
        addSubview(imageView)
        
//        header.anchor(top: nil, bottom: imageView.topAnchor, left: leftAnchor, right: rightAnchor, height: 100, width: 0, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
        imageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0, width: 0, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
        
//        profileImage.anchor(top: header.topAnchor, bottom: nil, left: header.leftAnchor, right: rightAnchor, height: 30, width: 30, paddingTop: 5, paddingBottom: 5, paddingLeft: 12, paddingRight: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
}
