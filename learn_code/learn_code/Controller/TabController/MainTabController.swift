//
//  MainTabController.swift.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 18/12/2023.
//

import UIKit


class MainTabController : UITabBarController, UITabBarControllerDelegate {
    
    
    //  MARK:  View Lifecycle Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabLayout()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func configureTabLayout() {
        self.delegate = self
        let tabStoryboard = UIStoryboard(name: AppStoryboard.Tab.rawValue, bundle: nil)
        
        let vc1 = tabStoryboard.instantiateViewController(withIdentifier: HomeViewController.className) as! HomeViewController
        let nav1 = UINavigationController(rootViewController: vc1)
        
        let vc2 = tabStoryboard.instantiateViewController(withIdentifier: HomeViewController.className) as! HomeViewController
        let nav2 = UINavigationController(rootViewController: vc2)
        
        let vc3 = tabStoryboard.instantiateViewController(withIdentifier: FeedViewController.className) as! FeedViewController
        let nav3 = UINavigationController(rootViewController: vc3)
        
        let vc4 = tabStoryboard.instantiateViewController(withIdentifier: HomeViewController.className) as! HomeViewController
        let nav4 = UINavigationController(rootViewController: vc4)
        
        let vc5 = tabStoryboard.instantiateViewController(withIdentifier: ProfileViewController.className) as! ProfileViewController
        let nav5 = UINavigationController(rootViewController: vc5)
        
        nav1.title = "Home"
        nav2.title = "Feeds"
        nav3.title = "Post"
        nav4.title = "Feeds"
        nav5.title = "Profile"
        
        nav1.tabBarItem.image = UIImage(named: ImageCollection.homeTab)?.withRenderingMode(.alwaysOriginal)
        nav2.tabBarItem.image = UIImage(named: ImageCollection.homeTab)?.withRenderingMode(.alwaysOriginal)
        nav3.tabBarItem.image = UIImage(named: ImageCollection.postTab)?.withRenderingMode(.alwaysOriginal)
        nav4.tabBarItem.image = UIImage(named: ImageCollection.homeTab)?.withRenderingMode(.alwaysOriginal)
        nav5.tabBarItem.image = UIImage(named: ImageCollection.profileTab)?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.backgroundColor = .lightText
        self.tabBar.barTintColor = .blackColor
        self.tabBar.tintColor = .blackColor
        self.viewControllers = [nav1 , nav2 , nav3, nav4, nav5]

    }
}
