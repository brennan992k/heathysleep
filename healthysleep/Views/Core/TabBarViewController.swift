//
//  TabBarController.swift
//  heathysleep
//
//  Created by Mac on 24/06/2021.
//

import UIKit
import AVFoundation
import MediaPlayer

class TabBarViewController: UITabBarController {
    
    private var vc1 = HomeViewController()
    private var vc2 = FavoriteViewController()
    private var vc3 = MoreViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        
        vc1.title = "Sleeptot"
        vc2.title = "Favorites"
        vc3.title = "More"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        vc1.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: PlayAnimationView())
        vc2.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: PlayAnimationView())
        vc3.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: PlayAnimationView())
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(title: "Sounds", image: UIImage(systemName: "waveform"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "More", image: UIImage(systemName: "ellipsis"), tag: 1)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3], animated: false)
        delegate = self
        
    }

}

extension TabBarViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}

