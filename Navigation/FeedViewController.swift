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
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("Первая кнопка", for: .normal)
        
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вторая кнопка", for: .normal)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10.0
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        return stackView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the vie
        
        view.backgroundColor = .systemGray
        title = "Лента новостей"
        
        view.addSubview(stackView)
        
        setupContraints()
        setupActions()
    }
    
    func setupContraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate( [
            stackView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor)
        ])
    }
    
    func setupActions() {
        firstButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
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
