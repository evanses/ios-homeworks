//
//  FeedViewController.swift
//  Navigation
//
//  Created by eva on 04.04.2024.
//

import UIKit

struct Post {
    let title: String
}

class FeedViewController: UIViewController {
    
    private lazy var someButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Октрыть пост", for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the vie
        
        view.backgroundColor = .systemGray
        title = "Лента новостей"
        
        view.addSubview(someButton)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            someButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            someButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            someButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            someButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        
        someButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        let postNavigationController = UINavigationController(rootViewController: postViewController)
        
        postNavigationController.modalPresentationStyle = .fullScreen
            
        let post = Post(title: "Какой-то пост")
        postViewController.setPost(post: post)

        self.present(postNavigationController, animated: false, completion: nil)
        

    }
}
