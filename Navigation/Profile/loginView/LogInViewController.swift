import UIKit
import FirebaseAuth

protocol LoginViewControllerDelegate {
    
    func check(with login: String, and password: String, completion: @escaping((Result<User, LoginError>) -> Void))
    
    func singUp(with login: String, and password: String, completion: @escaping((Result<Bool, SingupError>) -> Void))
    
}

class LogInViewController : UIViewController {
    
    // MARK: - Date
    
    var loginDelegate: LoginViewControllerDelegate?
    
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.backgroundColor = .clear
        
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    private lazy var contentView: UIView = {
        let contentview = UIView()
        
        contentview.translatesAutoresizingMaskIntoConstraints = false
        contentview.backgroundColor = .clear
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
    
    private lazy var viewBetweenTextFields: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        
        return view
    }()
    

    private lazy var loginTextField: TextFieldWithPadding = { [unowned self] in
        let textInput = TextFieldWithPadding()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.font = UIFont.systemFont(ofSize: 16)
        textInput.textColor = .bwText
        textInput.autocapitalizationType = .none
        textInput.tintColor = .my
        textInput.placeholder = "Login"
        textInput.backgroundColor = .systemGray6
        textInput.layer.cornerRadius = 10
        textInput.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        textInput.keyboardType = UIKeyboardType.default
        textInput.returnKeyType = UIReturnKeyType.done
        
        textInput.layer.masksToBounds = true
        
        textInput.delegate = self
        return textInput
    }()
    
    private lazy var passwordTextField: TextFieldWithPadding = { [unowned self] in
        let textInput = TextFieldWithPadding()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.font = UIFont.systemFont(ofSize: 16)
        textInput.textColor = .bwText
        textInput.autocapitalizationType = .none
        textInput.tintColor = .my
        textInput.placeholder = "Password"
        textInput.backgroundColor = .systemGray6
        textInput.layer.cornerRadius = 10
        textInput.isSecureTextEntry = true
        textInput.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        textInput.keyboardType = UIKeyboardType.default
        textInput.returnKeyType = UIReturnKeyType.done
    
        textInput.delegate = self
        return textInput
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray6
        
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        
        stackView.layer.masksToBounds = true
        stackView.clipsToBounds = false
        
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(viewBetweenTextFields)
        stackView.addArrangedSubview(passwordTextField)
        
        return stackView
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = false        
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .my
        return button
    }()
    
    private lazy var singUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .my
        return button
    }()

    
    private lazy var bruteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.setTitle("Подобрать пароль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        let activitiIndicator = UIActivityIndicatorView(style: .large)
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activitiIndicator.isHidden = true
        
        return activitiIndicator
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
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom = keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
        
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
    @objc func bruteButtonPressed(_ sender: UIButton) {
        let queue = DispatchQueue(label: "myFirstQueue", qos: .background)

        let randomPass: String = "QaZ"
        
        self.spinnerView.isHidden = false
        self.spinnerView.startAnimating()
        
        queue.async {
            
            self.bruteForce(passwordToUnlock: randomPass)
            
            DispatchQueue.main.async {
                self.spinnerView.stopAnimating()
                self.spinnerView.isHidden = true
                
                self.passwordTextField.text = randomPass
                self.passwordTextField.isSecureTextEntry = false
            }

        }
    }
    
    private func bruteForce(passwordToUnlock: String) {
            let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

            var password: String = ""
        
            print("brute starting...")

            while password != passwordToUnlock {
                password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            }
            
            print("Success: \(password)")
        }
    
    @objc func singUpButtonPressed(_ sender: UIButton) {
        guard let login = loginTextField.text, !login.isEmpty else {
            alertMessage.title = "Вы не ввели почту!"
            self.present(alertMessage, animated: true)
            return
        }
        
        guard let pass = passwordTextField.text, !pass.isEmpty else {
            alertMessage.title = "Пароль не может быть пустой!"
            self.present(alertMessage, animated: true)
            return
        }
        
        loginDelegate?.singUp(with: login, and: pass, completion: { [weak self] result in
            
            guard let self else {
                return
            }
            
            switch result {
                
            case .success(true):
                alertMessage.title = "Пользователь успешно зарегистрирован!"
                self.present(alertMessage, animated: true)
                
            case .failure(.emailAlreadyInUse):
                alertMessage.title = SingupError.emailAlreadyInUse.description
                self.present(alertMessage, animated: true)

            case .failure(.invalidEmail):
                alertMessage.title = SingupError.invalidEmail.description
                self.present(alertMessage, animated: true)
                
            case .failure(.wrongPassword):
                alertMessage.title = SingupError.wrongPassword.description
                self.present(alertMessage, animated: true)
                
            default:
                alertMessage.title = SingupError.smthWentWrong.description
                self.present(alertMessage, animated: true)
            }
        })
    }
    
    @objc func logInButtonPressed(_ sender: UIButton) {
        guard let login = loginTextField.text, !login.isEmpty else {
            alertMessage.title = "Вы не ввели почту!"
            self.present(alertMessage, animated: true)
            return
        }
        
        guard let pass = passwordTextField.text, !pass.isEmpty else {
            alertMessage.title = "Вы не ввели пароль!"
            self.present(alertMessage, animated: true)
            return
        }
        
        loginDelegate?.check(with: login, and: pass, completion: { [weak self] result in
            
            guard let self else {
                return
            }
            
            switch result {
                
            case .success(let user):
                let viewModel = ProfileVM(user: user)

                let nextViewController = ProfileViewController(viewModel: viewModel)

                navigationController?.pushViewController(
                    nextViewController,
                    animated: true
                )
                
            case .failure(.invalidCreds):
                alertMessage.title = LoginError.invalidCreds.description
                self.present(alertMessage, animated: true)
                
            case .failure(.invalidEmail):
                alertMessage.title = LoginError.invalidEmail.description
                self.present(alertMessage, animated: true)
            }
        })
    }
    
    // MARK: - Private

    private func setupView() {
        view.backgroundColor = .backgroundLoginView
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(stackView)
        stackView.addSubview(loginTextField)
        stackView.addSubview(viewBetweenTextFields)
        stackView.addSubview(passwordTextField)
        contentView.addSubview(logInButton)
        contentView.addSubview(singUpButton)
        contentView.addSubview(bottomView)
        
        passwordTextField.addSubview(spinnerView)
        
        contentView.addSubview(bruteButton)
    }
    
    private func setupActions() {
        logInButton.addTarget(self, action: #selector(logInButtonPressed(_:)), for: .touchUpInside)
        singUpButton.addTarget(self, action: #selector(singUpButtonPressed(_:)), for: .touchUpInside)
        
        bruteButton.addTarget(self, action: #selector(bruteButtonPressed(_:)), for: .touchUpInside)
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
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            loginTextField.topAnchor.constraint(equalTo: stackView.topAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 49.75),
            
            viewBetweenTextFields.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            viewBetweenTextFields.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            viewBetweenTextFields.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            viewBetweenTextFields.heightAnchor.constraint(equalToConstant: 0.5),
            
            passwordTextField.topAnchor.constraint(equalTo: viewBetweenTextFields.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 49.75),
            
            spinnerView.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 4.0),
            spinnerView.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            spinnerView.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -4.0),
            spinnerView.widthAnchor.constraint(equalTo: passwordTextField.heightAnchor),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16.0),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            logInButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            singUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16.0),
            singUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            singUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            singUpButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            bruteButton.topAnchor.constraint(equalTo: singUpButton.bottomAnchor, constant: 16.0),
            bruteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            bruteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            bruteButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            bottomView.topAnchor.constraint(equalTo: bruteButton.bottomAnchor),
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
