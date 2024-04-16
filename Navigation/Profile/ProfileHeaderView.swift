//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by eva on 15.04.2024.
//

import UIKit

class ProfileHeaderView: UIView {
    let showStatusButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(
            x: 16.0,
            y: 250,
            width: 350,
            height: 50
        )
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
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(
            x: 130,
            y: 160,
            width: 200,
            height: 21
        )
        label.text = "За вискас и двор..."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let nickName: UILabel = {
        let label = UILabel()
        label.frame = CGRect(
            x: 130,
            y: 110,
            width: 200,
            height: 21
        )
        label.text = "Боец ММА KickCat"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    let avatarImage: UIImageView = {
        let avatar = UIImageView(image: .avatar)
        avatar.frame = CGRect(
            x: 16,
            y: 100,
            width: 100,
            height: 100
        )
        avatar.layer.cornerRadius = 50.0
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.clipsToBounds = true
        return avatar
    }()
    
    let statusInput: UITextField = {
        let textInput = UITextField()
        textInput.frame = CGRect(
            x: 130,
            y: 195,
            width: 250,
            height: 40
        )
        textInput.placeholder = "Enter text here"
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
    
    private var statusText = ""

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.showStatusButton)
        self.showStatusButton.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchUpInside)
        self.addSubview(self.avatarImage)
        self.addSubview(nickName)
        self.addSubview(statusLabel)
        statusInput.addTarget(self, action: #selector(self.someInputAction(_:)), for: .editingChanged)
        self.addSubview(statusInput)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonPressed(_ sender: UIButton) {
        if let text = self.statusLabel.text {
            print(text)
        }
        
        self.statusLabel.text = self.statusText
    }
    
    
    @objc func someInputAction(_ sender: UIButton) {
        if let text = self.statusInput.text {
            self.statusText = text
        }
    }

}
