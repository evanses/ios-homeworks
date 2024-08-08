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
    
    // MARK: - Data
    
    var onTapButton: (() -> Void)?
    
    private var counterForTimer: Int = 10
    
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
        title: "Кнопка будет доступна через 10",
        titleColor: .black,
        backgroundColor: .clear,
        action: { self.buttonPressed() }
    )
    
    private lazy var secondButton = CustomButton(
        title: "Кнопка будет доступна через 10",
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
    
    private lazy var openPlayerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Открыть плеер", for: .normal)
        
        button.addTarget(self, action: #selector(openPlayer), for: .touchUpInside)
        
        return button
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
        stackView.addArrangedSubview(openPlayerButton)
        
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

        initTimer()
    }
    
    // MARK: - Private
    
    private func initTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.counterForTimer == 0 {
                timer.invalidate()
                
                self.firstButton.setTitle("Первая кнопка", for: .normal)
                self.firstButton.isEnabled = true
                
                self.secondButton.setTitle("Вторая кнопка", for: .normal)
                self.secondButton.isEnabled = true
                
                return
            }
            
            self.counterForTimer -= 1
            
            self.firstButton.setTitle("Кнопка будет доступна через \(self.counterForTimer)", for: .normal)
            
            self.secondButton.setTitle("Кнопка будет доступна через \(self.counterForTimer)", for: .normal)
        }
    }
    
    private func setupContraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate( [
            stackView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc func openPlayer() -> Void {
        let playerVC = PlayerViewController()
        playerVC.modalPresentationStyle = .formSheet
        
        self.present(playerVC, animated: true)
    }
    
    @objc func buttonPressed() -> Void {        
        onTapButton!()
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
