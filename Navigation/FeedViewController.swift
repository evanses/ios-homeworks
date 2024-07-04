//
//  FeedViewController.swift
//  Navigation
//
//  Created by eva on 04.04.2024.
//

import UIKit

struct PostV {
    let title: String
}

class FeedModel {
    let secretWord = "word"
    
    func check(word: String) -> Bool {
        word == self.secretWord
    }
}

class FeedViewController: UIViewController {
    
    // MARK: - Subviews
    
    private lazy var alertMessage: UIAlertController = {
        let newAlertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .alert
        )
        
        newAlertController.addAction(UIAlertAction(
            title: "Закрыть",
            style: .default,
            handler: { action in })
        )
    
        return newAlertController
    }()
    
    private lazy var firstButton = CustomButton(
        title: "Первая кнопка",
        titleColor: .black,
        backgroundColor: .clear,
        action: { self.buttonPressed() }
    )
    
    private lazy var secondButton = CustomButton(
        title: "Вторая кнопка",
        titleColor: .yellow,
        backgroundColor: .clear,
        action: { self.buttonPressed() }
    )
    
    private lazy var passwordTextField: TextFieldWithPadding = { [unowned self] in
        let textInput = TextFieldWithPadding()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.font = UIFont.systemFont(ofSize: 16)
        textInput.textColor = .black
        textInput.autocapitalizationType = .none
        textInput.tintColor = .my
        textInput.backgroundColor = .systemGray6
        textInput.layer.cornerRadius = 10
        textInput.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        textInput.keyboardType = UIKeyboardType.default
        textInput.returnKeyType = UIReturnKeyType.done
    
        return textInput
    }()
    
    private lazy var checkGuessButton = CustomButton(
        title: "Проверить",
        titleColor: .black,
        backgroundColor: .systemGray,
        action: { self.checkGuessButtonPressed() }
    )
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .clear
        label.backgroundColor = .clear
        return label
    }()

    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10.0
        
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(checkGuessButton)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        return stackView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the vie
        
        view.backgroundColor = .systemGray
        title = "Лента новостей"
        
        view.addSubview(stackView)
        
        setupContraints()
    }
    
    // MARK: - Private
    
    private func setupContraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate( [
            stackView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc func buttonPressed() -> Void {
        let postViewController = PostViewController()
        let postNavigationController = UINavigationController(rootViewController: postViewController)
        
        postNavigationController.modalPresentationStyle = .fullScreen
            
        let post = PostV(title: "Какой-то пост")
        postViewController.setPost(post: post)

        self.present(postNavigationController, animated: false, completion: nil)
    }
    
    @objc func checkGuessButtonPressed() -> Void {
        
        if let inputedText: String = passwordTextField.text {
            
            if inputedText.count == 0 {
                
                alertMessage.title = "Вы не ввели слово!"
                
                self.present(alertMessage, animated: true)
            } else {
                
                let checker = FeedModel()
                let check = checker.check(word: inputedText)
                
                if check {
                    statusLabel.textColor = .green
                    statusLabel.text = "Слово верное!"
                } else {
                    statusLabel.textColor = .red
                    statusLabel.text = "Слово неверное!"
                }
                
            }
            
        } else {
            
            alertMessage.title = "Вы не ввели слово!"
            
            self.present(alertMessage, animated: true)
            
        }
    }
}
