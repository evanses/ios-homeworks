//
//  LogInViewController.swift
//  Navigation
//
//  Created by eva on 19.04.2024.
//

import UIKit

class LogInViewController : UIViewController {
    
    // MARK: - Subviews
    
    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.backgroundColor = .white
        
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    private lazy var contentView: UIView = {
        let contentview = UIView()
        
        contentview.translatesAutoresizingMaskIntoConstraints = false
        contentview.backgroundColor = .white
        return contentview
    }()
    
    private lazy var bottomView: UIView = {
        let contentview = UIView()
        
        contentview.translatesAutoresizingMaskIntoConstraints = false
        contentview.backgroundColor = .clear
        return contentview
    }()

    
    private lazy var logoImageView: UIImageView = {
        let logo = UIImageView(image: .logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    private lazy var loginTextField: TextFieldWithPadding = { [unowned self] in
        let textInput = TextFieldWithPadding()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.font = UIFont.systemFont(ofSize: 16)
        textInput.textColor = .black
        textInput.autocapitalizationType = .none
        textInput.tintColor = .my
        textInput.placeholder = "Email or phone"
        textInput.backgroundColor = .systemGray6
        textInput.layer.cornerRadius = 10
        textInput.layer.borderWidth = 0.5
        textInput.layer.borderColor = UIColor.lightGray.cgColor
        textInput.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        textInput.keyboardType = UIKeyboardType.default
        textInput.returnKeyType = UIReturnKeyType.done
        
        textInput.layer.masksToBounds = true
        textInput.clipsToBounds = false
        
        textInput.delegate = self
        return textInput
    }()
    
    private lazy var passwordTextField: TextFieldWithPadding = { [unowned self] in
        let textInput = TextFieldWithPadding()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.font = UIFont.systemFont(ofSize: 16)
        textInput.textColor = .black
        textInput.autocapitalizationType = .none
        textInput.tintColor = .my
        textInput.placeholder = "Password"
        textInput.backgroundColor = .systemGray6
        textInput.layer.cornerRadius = 10
        textInput.layer.borderWidth = 0.5
        textInput.layer.borderColor = UIColor.lightGray.cgColor
        textInput.isSecureTextEntry = true
        textInput.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        textInput.keyboardType = UIKeyboardType.default
        textInput.returnKeyType = UIReturnKeyType.done
        
        textInput.layer.masksToBounds = true
        textInput.clipsToBounds = false
        
        textInput.delegate = self
        return textInput
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(.bluePixel, for: .normal)
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        addSubviews()
        
        setupActions()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    // MARK: - Actions
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120.0).isActive = true
    }
        
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func logInButtonPressed(_ sender: UIButton) {
        let nextViewController = ProfileViewController()

        navigationController?.pushViewController(
            nextViewController,
            animated: true
        )

    }
    
    // MARK: - Private

    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(logInButton)
        contentView.addSubview(bottomView)
    }
    
    private func setupActions() {
        logInButton.addTarget(self, action: #selector(logInButtonPressed(_:)), for: .touchUpInside)
    }

    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate( [
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120.0),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100.0),
            logoImageView.heightAnchor.constraint(equalToConstant: 100.0),
            
            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120.0),
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            loginTextField.heightAnchor.constraint(equalToConstant: 50.0),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16.0),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            logInButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            bottomView.topAnchor.constraint(equalTo: logInButton.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 10,
        bottom: 10,
        right: 10
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
