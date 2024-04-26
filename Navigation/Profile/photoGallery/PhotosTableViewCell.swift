
import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        
        label.text = "Photos"

        return label
    }()
    
    private lazy var arrowIndicator: UIImageView = {
        let image = UIImageView(image: .arrow)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var firstPhoto: UIImageView = {
        let image = UIImageView(image: .Photos._0)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var secondPhoto: UIImageView = {
        let image = UIImageView(image: .Photos._1)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var thirdPhoto: UIImageView = {
        let image = UIImageView(image: .Photos._2)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var fourthPhoto: UIImageView = {
        let image = UIImageView(image: .Photos._3)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
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
        contentView.addSubview(cellLabel)
        
        contentView.addSubview(arrowIndicator)
        
        contentView.addSubview(firstPhoto)
        contentView.addSubview(secondPhoto)
        contentView.addSubview(thirdPhoto)
        contentView.addSubview(fourthPhoto)
    }
    
    private func tuneView() {
        backgroundColor = .tertiarySystemBackground
        contentView.backgroundColor = .tertiarySystemBackground
    }
    
    private func setupConstraints() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let totalSpacing: CGFloat = 12 * 2 + 8 * 3
        let photosInCell: CGFloat = 4
        let photoWidthAndHeight = (screenSize.width - totalSpacing) / photosInCell
        
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            
            arrowIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            arrowIndicator.widthAnchor.constraint(equalToConstant: 30),
            arrowIndicator.heightAnchor.constraint(equalToConstant: 30),
            arrowIndicator.centerYAnchor.constraint(equalTo: cellLabel.centerYAnchor),
            
            firstPhoto.topAnchor.constraint(equalTo: cellLabel.bottomAnchor, constant: 12.0),
            firstPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            firstPhoto.heightAnchor.constraint(equalToConstant: photoWidthAndHeight),
            firstPhoto.widthAnchor.constraint(equalToConstant: photoWidthAndHeight),
            
            secondPhoto.topAnchor.constraint(equalTo: cellLabel.bottomAnchor, constant: 12.0),
            secondPhoto.leadingAnchor.constraint(equalTo: firstPhoto.trailingAnchor, constant: 8.0),
            secondPhoto.heightAnchor.constraint(equalToConstant: photoWidthAndHeight),
            secondPhoto.widthAnchor.constraint(equalToConstant: photoWidthAndHeight),
            
            thirdPhoto.topAnchor.constraint(equalTo: cellLabel.bottomAnchor, constant: 12.0),
            thirdPhoto.leadingAnchor.constraint(equalTo: secondPhoto.trailingAnchor, constant: 8.0),
            thirdPhoto.heightAnchor.constraint(equalToConstant: photoWidthAndHeight),
            thirdPhoto.widthAnchor.constraint(equalToConstant: photoWidthAndHeight),

            fourthPhoto.topAnchor.constraint(equalTo: cellLabel.bottomAnchor, constant: 12.0),
            fourthPhoto.leadingAnchor.constraint(equalTo: thirdPhoto.trailingAnchor, constant: 8.0),
            fourthPhoto.heightAnchor.constraint(equalToConstant: photoWidthAndHeight),
            fourthPhoto.widthAnchor.constraint(equalToConstant: photoWidthAndHeight),
            
            contentView.bottomAnchor.constraint(equalTo: firstPhoto.bottomAnchor, constant: 12.0)
        ])
    }
}
