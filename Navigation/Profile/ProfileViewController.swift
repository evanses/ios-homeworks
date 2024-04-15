//
//  ProfileViewController.swift
//  Navigation
//
//  Created by eva on 04.04.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var headerView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the vie
        
        view.backgroundColor = .lightGray
        title = "Профиль"
        
        view.addSubview(headerView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        headerView.frame = view.frame

    }
}
