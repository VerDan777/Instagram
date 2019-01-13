//
//  UserProfileCellCollectionViewCell.swift
//  InstagrammDemoApp
//
//  Created by Daniil Vereschagin on 1/13/19.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class UserProfileCellCollectionViewCell: UICollectionViewCell {
    var imageUrl: String? {
        didSet {
            guard let imageURL = imageUrl else { return }
            guard let url = URL(string: imageURL) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Failed", error)
                }
                
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
                
                }.resume()
        }
    }

    var imageView: UIImageView = {
        let iv = UIImageView();
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
//        fetchImage()
        
        addSubview(imageView)
        
        imageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0, width: 0, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
    }
    
//    fileprivate func fetchImage() {
////        guard let imageURL = imageUrl else { return }
//        guard let url = URL(string: imageURL) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("Failed", error)
//            }
//
//            guard let data = data else { return }
//
//            DispatchQueue.main.async {
//             self.imageView.image = UIImage(data: data)
//            }
//
//        }.resume()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("lol")
    }
    
}
