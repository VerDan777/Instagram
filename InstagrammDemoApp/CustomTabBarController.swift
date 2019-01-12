//
//  CustomTabBarController.swift
//  InstagrammDemoApp
//
//  Created by Daniil Vereschagin on 1/12/19.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue;
        let layout = UICollectionViewFlowLayout();
        
        let userProfile = UserProfileController(collectionViewLayout: layout);
        
        
        let navController = UINavigationController(rootViewController: userProfile);
        
        navController.tabBarItem.image = UIImage(named: "profile_unselected")
        navController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        tabBar.tintColor = .black
        
        viewControllers = [navController];
        
    }
    
}
