//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by eva on 15.04.2024.
//

import UIKit

class ProfileHeaderView : UIView {
    lazy var showStatusButton = UIButton()
    lazy var statusLabel = UILabel()
    lazy var nickName = UILabel()
    lazy var avatarImage = UIImageView(image: .avatar)
    
    lazy var statusInput = UITextField()
    private var statusText = ""

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        
        avatarImage.frame = CGRect(
            x: 20,
            y: 110,
            width: 100,
            height: 100
        )
        avatarImage.layer.cornerRadius = 50.0
        avatarImage.layer.borderWidth = 3
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.clipsToBounds = true
        self.addSubview(avatarImage)
        
        
        nickName.frame = CGRect(
            x: avatarImage.frame.origin.x + 120,
            y: 120,
            width: 200,
            height: 21
        )
        nickName.text = "Боец ММА KickCat"
        nickName.font = UIFont.boldSystemFont(ofSize: 18)
        nickName.textColor = .black
        self.addSubview(nickName)
        
        
        statusLabel.frame = CGRect(
            x: nickName.frame.origin.x,
            y: nickName.frame.origin.y + 50,
            width: 200,
            height: 21
        )
        statusLabel.text = "За вискас и двор..."
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        self.addSubview(statusLabel)
        
        
        statusInput.frame = CGRect(
            x: statusLabel.frame.origin.x,
            y: statusLabel.frame.origin.y + 30,
            width: screenSize.width - statusLabel.frame.origin.x - 16,
            height: 40
        )
        statusInput.placeholder = "Enter text here"
        statusInput.font = UIFont.systemFont(ofSize: 15)
        statusInput.attributedPlaceholder = NSAttributedString(
            string: "Listening to music...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        statusInput.backgroundColor = .white
        statusInput.layer.cornerRadius = 12
        statusInput.layer.borderWidth = 1
        statusInput.layer.borderColor = UIColor.black.cgColor
        statusInput.clipsToBounds = true
        statusInput.addTarget(self, action: #selector(self.someInputAction(_:)), for: .editingChanged)
        self.addSubview(statusInput)
            
        
        showStatusButton.frame = CGRect(
            x: self.frame.origin.x + 16.0,
            y: statusInput.frame.origin.y + 55,
            width: screenSize.width - 16 - 16,
            height: 50
        )
        showStatusButton.backgroundColor = .systemBlue
        showStatusButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        showStatusButton.setTitleColor(.white, for: .normal)
        showStatusButton.setTitle("Show status", for: .normal)
        showStatusButton.layer.cornerRadius = 4
        showStatusButton.layer.masksToBounds = true
        showStatusButton.clipsToBounds = false
        showStatusButton.layer.shadowColor = UIColor.black.cgColor
        showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatusButton.layer.shadowOpacity = 0.7
        showStatusButton.layer.shadowRadius = 4
        self.addSubview(showStatusButton)
        showStatusButton.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchUpInside)
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
