
import UIKit

class ProfileHeaderView: UIView {
    
    // MARK: - Data
    
    private lazy var statusText = ""
    
    private var startFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    // MARK: - Subviews
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .my
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
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .bwText
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 50.0
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.clipsToBounds = true
        
        avatar.isUserInteractionEnabled = true
        
        let tapAvatar = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapAvatar)
        )
        tapAvatar.numberOfTapsRequired = 1
        avatar.addGestureRecognizer(tapAvatar)
        return avatar
    }()
    
    private lazy var statusTextField: TextFieldWithPadding = {
        let textInput = TextFieldWithPadding()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.font = UIFont.systemFont(ofSize: 15)
        textInput.attributedPlaceholder = NSAttributedString(
            string: "Listening to music...",
            attributes: nil
        )
        textInput.backgroundColor = .systemGray6
        textInput.layer.cornerRadius = 12
        textInput.layer.borderWidth = 1
        textInput.layer.borderColor = UIColor.black.cgColor
        textInput.clipsToBounds = true
        return textInput
    }()
    
    private lazy var animatedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .black
        view.alpha = 0.0
        
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.alpha = 0.0
        
        button.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapCloseButton)
        )
        tap.numberOfTapsRequired = 1
        button.addGestureRecognizer(tap)

        
        return button
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews()
                
        self.setupActions()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Layout
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: UIView.noIntrinsicMetric,
            height: 220.0
        )
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        self.addSubview(setStatusButton)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(animatedView)
        self.addSubview(avatarImageView)

        self.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        let origin = UIScreen.main.bounds
        
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
            
            animatedView.heightAnchor.constraint(equalToConstant: origin.height),
            animatedView.widthAnchor.constraint(equalToConstant: origin.width),
            
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0)
        ])
        
    }
    
    // MARK: - Actions
    
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
    
    @objc private func didTapAvatar() {
        let origin = UIScreen.main.bounds
        let difference = origin.width - self.avatarImageView.bounds.width
        let newImageHeight = self.avatarImageView.layer.frame.height + difference
        
        self.startFrame = self.avatarImageView.frame
                
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .curveLinear
        ) {
            self.animatedView.alpha = 0.8
            
            self.avatarImageView.layer.frame.size = CGSize(width: origin.width, height: newImageHeight)
            self.avatarImageView.center = CGPoint(
                x: origin.width/2,
                y: (origin.height-50)/2
            )
            
            self.avatarImageView.layer.cornerRadius = 0
            
        } completion: { finished in
            self.showCloseButton()
        }
    }
    
    private func showCloseButton() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: .curveLinear
        ) {
            self.closeButton.alpha = 1
        }
    }
    
    @objc private func didTapCloseButton() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: .curveLinear
        ) {
            self.animatedView.alpha = 0.0
            self.closeButton.alpha = 0.0
            
            self.avatarImageView.frame = self.startFrame
            
            self.avatarImageView.layer.cornerRadius = 50.0
        }
    }
    
    //MARK: - Public
    
    func setup(with user: User) {
        fullNameLabel.text = user.fullName
        
        avatarImageView.image = user.avatar
        
        statusLabel.text = user.status
    }
}
