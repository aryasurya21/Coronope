//
//  SceneDelegate.swift
//  Coronope
//
//  Created by IT Division on 15/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
      
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = self.setupRootController()
        self.window?.makeKeyAndVisible()
    }
    
    private func setupRootController() -> UINavigationController {
        let tabbar = UITabBarController()
        let newsPresenter = Injector.shared.injectNewsPresenter()
        let statsPresenter = Injector.shared.injectStatsPresenter()
        
        let statsVC = StatsViewController(statsPresenter)
        statsVC.tabBarItem = UITabBarItem(title: "Stats", image: #imageLiteral(resourceName: "stats"), tag: 0)
        let newsVC = NewsViewController(newsPresenter)
        newsVC.tabBarItem = UITabBarItem(title: "News", image: #imageLiteral(resourceName: "news"), tag: 1)
        tabbar.viewControllers = [statsVC, newsVC]
        tabbar.selectedIndex = 0
        let navController = UINavigationController(rootViewController: tabbar)
        return navController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

