
import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    // MARK: - Data
    
    private lazy var statusText = ""
    
    private var startFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    // MARK: - Subviews
    
    private lazy var setStatusButton: UIButton = {
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
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "За вискас и двор..."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Боец ММА KickCat"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let avatar = UIImageView(image: .avatar)
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
        textInput.backgroundColor = .white
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
        
        avatarImageView.snp.makeConstraints { make in
            make.height.equalTo(100.0)
            make.width.equalTo(100.0)
            make.leading.equalTo(self.snp.leading).offset(16.0)
            make.top.equalTo(self.snp.top).offset(16.0)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27.0)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10.0)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(27.0)
            make.leading.equalTo(fullNameLabel.snp.leading)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(10.0)
            make.leading.equalTo(statusLabel.snp.leading)
            make.height.equalTo(40.0)
            make.trailing.equalTo(self.snp.trailing).offset(-16.0)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(statusTextField.snp.bottom).offset(10.0)
            make.leading.equalTo(self.snp.leading).offset(16.0)
            make.height.equalTo(50.0)
            make.trailing.equalTo(self.snp.trailing).offset(-16.0)
        }
        
        animatedView.snp.makeConstraints { make in
            make.height.equalTo(origin.height)
            make.width.equalTo(origin.width)
        }
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).offset(-16.0)
            make.top.equalTo(self.snp.top).offset(16.0)
        }
        
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
}
