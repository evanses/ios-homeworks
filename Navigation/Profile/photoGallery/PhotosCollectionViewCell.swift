import UIKit

class PhotosCollectionViewCell : UICollectionViewCell {
    private enum Constants {
        static let imageHeight: CGFloat = 130
    }
    
    // MARK: - Subviews

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setupLayouts()
    }
    
    // MARK: - Private
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .clear
    }

    private func setupSubviews() {
        contentView.addSubview(imageView)
    }

    private func setupLayouts() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
        ])
    }
    
    // MARK: - Public

    func setup(with photo: Photo) {
        imageView.image = UIImage(named: photo.fileName)
    }
        
}
