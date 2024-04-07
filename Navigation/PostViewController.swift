//
//  PostViewController.swift
//  Navigation
//
//  Created by eva on 04.04.2024.
//

import UIKit

class PostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the vie
        
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "About", style: .plain, target: self, action: #selector(barButtonPressed))
    }
    
    @objc func barButtonPressed(_ sender: UIButton) {
        let infoViewController = InfoViewController()
        
        infoViewController.modalPresentationStyle = .popover

        self.present(infoViewController, animated: true, completion: nil)
    }
    
    func setPost(post: Post) {
        title = post.title
    }
}
