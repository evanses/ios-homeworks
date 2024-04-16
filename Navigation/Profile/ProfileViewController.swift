//
//  ProfileViewController.swift
//  Navigation
//
//  Created by eva on 04.04.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var headerView: ProfileHeaderView = {
        var view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var newButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("New button", for: .normal)
        return button
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the vie
        
        view.backgroundColor = .lightGray
        title = "Профиль"
        
        view.addSubview(headerView)
        view.addSubview(newButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate( [
            headerView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            headerView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220.0),
            
            newButton.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            newButton.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            newButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            headerView.avatarImageView.heightAnchor.constraint(equalToConstant: 100.0),
            headerView.avatarImageView.widthAnchor.constraint(equalToConstant: 100.0),
            headerView.avatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16.0),
            headerView.avatarImageView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 16.0),
            
            headerView.fullNameLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 27.0),
            headerView.fullNameLabel.leftAnchor.constraint(equalTo: headerView.avatarImageView.rightAnchor, constant: 10.0),
            
            headerView.statusLabel.topAnchor.constraint(equalTo: headerView.fullNameLabel.bottomAnchor, constant: 35),
            headerView.statusLabel.leftAnchor.constraint(equalTo: headerView.fullNameLabel.leftAnchor),
            
            headerView.statusTextField.topAnchor.constraint(equalTo: headerView.statusLabel.bottomAnchor, constant: 10.0),
            headerView.statusTextField.leftAnchor.constraint(equalTo: headerView.statusLabel.leftAnchor),
            headerView.statusTextField.heightAnchor.constraint(equalToConstant: 40.0),
            headerView.statusTextField.widthAnchor.constraint(equalToConstant: 100),
            headerView.statusTextField.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant:  -16.0),
            
            headerView.setStatusButton.topAnchor.constraint(equalTo: headerView.statusTextField.bottomAnchor, constant: 10.0),
            headerView.setStatusButton.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 16.0),
            headerView.setStatusButton.heightAnchor.constraint(equalToConstant: 50.0),
            headerView.setStatusButton.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant:  -16.0)
        
        ])
    }


}
