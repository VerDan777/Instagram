//
//  CustomTabBarController.swift
//  InstagrammDemoApp
//
//  Created by Daniil Vereschagin on 1/12/19.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if 5 == 5 {
            DispatchQueue.main.async {
                let signIn = SignInViewController();
                let navContoller = UINavigationController(rootViewController: signIn);
                self.present(navContoller, animated:  true, completion: nil)
                return
            }
        }
        
        setupViewControllers()

        }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.index(of: viewController) else { return false }
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorViewController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            present(navController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func setupViewControllers() {
        let layout = UICollectionViewFlowLayout();
        // home
        
        let homeController = HomeViewController(collectionViewLayout: layout);
        let navHomeController = UINavigationController(rootViewController: homeController)
        navHomeController.tabBarItem.image = UIImage(named: "home_unselected")
        navHomeController.tabBarItem.selectedImage = UIImage(named: "home_selected")
        
        // search
        let searchController = SearchViewController();
        searchController.view.backgroundColor = .white
        let navSearchController = UINavigationController(rootViewController: searchController)
        navSearchController.tabBarItem.image = UIImage(named: "search_unselected")
        navSearchController.tabBarItem.selectedImage = UIImage(named: "search_selected")
        
        // add
        let addController = UIViewController();
        addController.view.backgroundColor = .white
        let navAddController = UINavigationController(rootViewController: addController)
        navAddController.tabBarItem.image = UIImage(named: "plus_unselected")
        navAddController.tabBarItem.selectedImage = UIImage(named: "plus_selected")
        
        // feed
        
        let feedController = FeedViewController();
        feedController.view.backgroundColor = .white
        let feedNavController = UINavigationController(rootViewController: feedController)
        feedNavController.tabBarItem.image = UIImage(named: "like_unselected")
        feedNavController.tabBarItem.selectedImage = UIImage(named: "like_selected")
    
        
        let userProfile = UserProfileController(collectionViewLayout: layout);
        
        
        let UserProfileNavController = UINavigationController(rootViewController: userProfile);
        
        UserProfileNavController.tabBarItem.image = UIImage(named: "profile_unselected")
        UserProfileNavController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        tabBar.tintColor = .black
        
        viewControllers = [
            navHomeController,
            navSearchController,
            navAddController,
            feedNavController,
            UserProfileNavController];
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            item.title = ""
        }
    }
    
}
