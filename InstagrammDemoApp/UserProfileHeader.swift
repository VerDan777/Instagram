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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        imageView.anchor(top: self.topAnchor, bottom: nil, left: self.leftAnchor, right: nil, height: 80, width: 80, paddingTop: 20, paddingBottom: 0, paddingLeft: 20, paddingRight: 0)
        imageView.layer.cornerRadius = 80 / 2;
        imageView.clipsToBounds = true;
        fetchImageProfile();
        
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
