import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2

        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView(image: nil)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0

        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black

        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black

        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .subtitle,
            reuseIdentifier: reuseIdentifier
        )
        
        addSubviews()
        
        setupConstraints()

        tuneView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isHidden = false
        isSelected = false
        isHighlighted = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        guard let view = selectedBackgroundView else {
            return
        }
        
        contentView.insertSubview(view, at: 0)
        selectedBackgroundView?.isHidden = !selected
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(postImage)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
    }
    
    private func tuneView() {
        backgroundColor = .tertiarySystemBackground
        contentView.backgroundColor = .tertiarySystemBackground
//        textLabel?.backgroundColor = .clear
//        detailTextLabel?.backgroundColor = .clear
//        imageView?.backgroundColor = .clear

        accessoryView = nil
        accessoryType = .none
        
        selectionStyle = .gray
        let selectedView = UIView()
        selectedView.backgroundColor = .systemYellow
        selectedBackgroundView = selectedView
    }
    
    // MARK: - Public
    
    func update(_ model: Post) {
        authorLabel.text = model.author
        postImage.image = UIImage(named: model.image)
        descriptionLabel.text = model.description
        likesLabel.text = "Likes: \(model.likes)"
        viewsLabel.text = "Views: \(model.views)"
    }
    
    private func setupConstraints() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
//            authorLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor),
//            authorLabel.heightAnchor.constraint(equalToConstant: 30.0),
//            authorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12.0),
            postImage.heightAnchor.constraint(equalToConstant: screenSize.width),
            postImage.widthAnchor.constraint(equalToConstant: screenSize.width),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16.0),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            
            viewsLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0)
        ])
    }
}
