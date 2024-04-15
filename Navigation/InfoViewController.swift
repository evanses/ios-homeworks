//
//  InfoViewController.swift
//  Navigation
//
//  Created by eva on 04.04.2024.
//

import UIKit

class InfoViewController: UIViewController {
    private lazy var someButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Alert", for: .normal)
        
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        view.addSubview(self.someButton)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            someButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            someButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            someButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            someButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        
        someButton.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let newAlertController = UIAlertController()
        newAlertController.title = "Какой-то алерт!!!!"
        newAlertController.message = "Что-то случилось и поэтому алерт!"
        newAlertController.addAction(UIAlertAction(title: "Паниковать!", style: .default, handler: { action in
            print("put your hands up and run in circles!")
        }))
        newAlertController.addAction(UIAlertAction(title: "Keep calm...", style: .cancel, handler: { action in
            print("drink coffie and just relax!")
        }))

        self.present(newAlertController, animated: true)
        
    }
}
