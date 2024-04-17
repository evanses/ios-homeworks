//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by eva on 15.04.2024.
//

import UIKit

class ProfileHeaderView: UIView {
    private lazy var statusText = ""

    
    lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Show status", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        return button
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "За вискас и двор..."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Боец ММА KickCat"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let avatar = UIImageView(image: .avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 50.0
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.clipsToBounds = true
        return avatar
    }()
    
    lazy var statusTextField: UITextField = {
        let textInput = UITextField()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.font = UIFont.systemFont(ofSize: 15)
        textInput.attributedPlaceholder = NSAttributedString(
            string: "Listening to music...",
            attributes: nil
        )
        textInput.backgroundColor = .white
        textInput.layer.cornerRadius = 12
        textInput.layer.borderWidth = 1
        textInput.layer.borderColor = UIColor.black.cgColor
        textInput.clipsToBounds = true
        return textInput
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.setStatusButton)
        self.addSubview(self.avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        
        self.setupActions()
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate( [
            avatarImageView.heightAnchor.constraint(equalToConstant: 100.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100.0),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),

            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27.0),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10.0),
            
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 35),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10.0),
            statusTextField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40.0),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -16.0),
            
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 10.0),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50.0),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -16.0),
        ])
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupActions() {
        self.setStatusButton.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchUpInside)
        self.statusTextField.addTarget(self, action: #selector(self.someInputAction(_:)), for: .editingChanged)
    }
    
    
    @objc func buttonPressed(_ sender: UIButton) {
        if let text = self.statusLabel.text {
            print(text)
        }
        
        self.statusLabel.text = self.statusText
    }
    
    
    @objc func someInputAction(_ sender: UIButton) {
        if let text = self.statusTextField.text {
            self.statusText = text
        }
    }

}
