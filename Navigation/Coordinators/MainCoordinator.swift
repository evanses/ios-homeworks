import UIKit

class MainCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let tabBarController: TabBarController
    
    init() {
        tabBarController = TabBarController()
        
        let feedModule = configureFeed()
        coordinators.append(feedModule)
        feedModule.start()
        
        let profileModule = configureProfile()
        let favoriteModule = configureFavorits()
        
        tabBarController.viewControllers = [feedModule.navigationController, profileModule, favoriteModule]
    }
    
    private func configureFeed() -> FeedCoordinator {

        let feedNavigationController = UINavigationController()
        feedNavigationController.tabBarItem = UITabBarItem(title: "Лента новостей", image: .menu , tag: 0)
        
        let coordinator = FeedCoordinator(navigation: feedNavigationController)
        
        return coordinator
    }
    
    private func configureProfile() -> UINavigationController {
        let profileViewController = LogInViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.navigationBar.isHidden = true
        
        let loginFactory = MyLoginFactory()
    
        profileViewController.loginDelegate = loginFactory.makeLoginInspector()
        
        profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: .user, tag: 1)
        
        return profileNavigationController
    }
    
    private func configureFavorits() -> UINavigationController {
        let favoriteViewController = FavoriiteViewController()
        let favoriteNavigationController = UINavigationController(rootViewController: favoriteViewController)
        favoriteNavigationController.navigationBar.isHidden = true
        
        favoriteNavigationController.tabBarItem = UITabBarItem(title: "Лайки", image: UIImage(systemName: "star.fill"), tag: 2)
        
        return favoriteNavigationController
    }
}
