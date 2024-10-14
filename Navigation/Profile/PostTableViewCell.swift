import UIKit
import StorageService
import CoreData

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Data
    
    var currentPost: Post?
    
    // MARK: - Subviews
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .bwText
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
        label.textColor = .bwText

        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .bwText

        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .default,
            reuseIdentifier: reuseIdentifier
        )
        
        tuneView()
        
        addSubviews()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12.0),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: screenSize.width),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),

            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16.0),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16.0),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),

            contentView.bottomAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 16.0)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func addToFavorite() {
        
        print("double tap!!!")
        
        guard let currentPost else {
            return
        }
        
        let favoritsPosts = CoreDataManager.shared.fetchFavoritePosts()
        
        var flag = false
        favoritsPosts.forEach { post in
            if post.description == currentPost.description && post.image == currentPost.image {
                flag = true
                print("already exist!")
            }
        }
        
        if !flag {
            CoreDataManager.shared.add2Favorite(post: currentPost)
            
            contentView.backgroundColor = .orange
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                options: .curveLinear
            ) {
                self.contentView.backgroundColor = .tertiarySystemBackground
//                self.delegate?.updateTableView()
            }
        }

    }
    
    // MARK: - Public
    
    func update(_ model: Post) {
        authorLabel.text = model.author
        
        self.postImage.image = UIImage(named: model.image)!
        
        descriptionLabel.text = model.description
        likesLabel.text = "Likes: \(model.likes)"
        viewsLabel.text = "Views: \(model.views)"
        
        currentPost = model
    }
    
    func setDubleTapAction() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(addToFavorite)
        )
        tap.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(tap)
    }
    
    func updateWithCoreData(with post: SavedPost) {
        authorLabel.text = post.author
        
        self.postImage.image = UIImage(named: post.image!)
        
        descriptionLabel.text = post.desc
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }
}
