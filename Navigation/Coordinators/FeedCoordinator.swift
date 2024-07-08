import UIKit

class FeedCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let feedViewController = FeedViewController()
        
        feedViewController.onTapButton = { [weak self] in
            guard let controller = self?.configurePost() else { return }
            self?.navigationController.pushViewController(controller, animated: true)
        }
        
        navigationController.pushViewController(feedViewController, animated: true)
    }
    
    func configurePost() -> PostViewController {
        let postViewController = PostViewController()
        let postNavigationController = UINavigationController(rootViewController: postViewController)
        
        postNavigationController.modalPresentationStyle = .fullScreen
            
        let post = PostV(title: "Какой-то пост")
        postViewController.setPost(post: post)
        
        return postViewController
    }
}
