//
//  SceneDelegate.swift
//  Navigation
//
//  Created by eva on 04.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let mainCoordinator = MainCoordinator()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
//        let appConfiguration: AppConfiguration = {
//            let random = Int.random(in: 0..<2)
//            
//            if random == 0 {
//                return AppConfiguration.people
//            } else if random == 1 {
//                return AppConfiguration.starships
//            } else {
//                return AppConfiguration.planets
//            }
//        }()
        
//        NetworkManager.request(for: appConfiguration)
        
//        let feedViewController = FeedViewController()
//        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
//        
//        
//        let profileViewController = LogInViewController()
//        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
//        profileNavigationController.navigationBar.isHidden = true
//        
//        let loginFactory = MyLoginFactory()
//    
//        profileViewController.loginDelegate = loginFactory.makeLoginInspector()
//        
//        let tabBarController = UITabBarController()
// 
//        feedNavigationController.tabBarItem = UITabBarItem(title: "Лента новостей", image: .menu , tag: 0)
//        profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: .user, tag: 1)
//        
//
//        let controllers = [feedNavigationController, profileNavigationController]
//        tabBarController.viewControllers = controllers.map { $0 }
//        tabBarController.selectedIndex = 0
        
        window.rootViewController = mainCoordinator.tabBarController
        window.makeKeyAndVisible()

        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

