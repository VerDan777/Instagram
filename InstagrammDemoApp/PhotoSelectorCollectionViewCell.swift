//
//  PhotoSelectorCollectionViewCell.swift
//  InstagrammDemoApp
//
//  Created by Daniil Vereschagin on 1/13/19.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class PhotoSelectorCollectionViewCell: UICollectionViewCell {
    
    let photoImageView: UIImageView = {
        let photo = UIImageView();

        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        
        photoImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0, width: 0, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("failed")
    }
}
