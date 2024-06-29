import UIKit
import iOSIntPackage

class PhotosViewController : UIViewController {
    
    // MARK: - Data
    
    let subcriber = ImagePublisherFacade()
    
    fileprivate lazy var photos: [UIImage] = []
    
    private enum PhotoCellReuseID: String {
        case base = "PhotoTableViewCell_ReuseID"
    }

    // MARK: - Subviews
        
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCellReuseID.base.rawValue
        )
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        
        subscribeProtocolObserver()
        
        addingPhotosToObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) { //что бы navigationBar не изчез, когда потянул за край и отпустил случайно (контроллер вернулся обратно)
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        unsubscribeProtocolObserver()
    }
    
    
    // MARK: - Private
    
    private func addingPhotosToObserver() {
        
        let createdPhotos = Photo.make()
        
        var photos: [UIImage] = []
        
        createdPhotos.forEach {
            
            if let image = UIImage(named: $0.fileName) {
                photos.append(image)
            }
        }
        
        subcriber.addImagesWithTimer(time: 0.5, repeat: photos.count, userImages: photos)
    }
    
    private func subscribeProtocolObserver() {
        
        subcriber.subscribe(self)
        
    }
    
    private func unsubscribeProtocolObserver() {
        
        subcriber.removeSubscription(for: self)
        
    }

    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = "Back"
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.title = "Photo Gallery"
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
        static let itemsInRow: CGFloat = 3.0
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        photos.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCellReuseID.base.rawValue,
            for: indexPath) as! PhotosCollectionViewCell
        
        let photo = photos[indexPath.row]
        cell.setup(with: photo)

        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let totalSpacing = LayoutConstant.spacing * 4
        let widthWithoutSpacing = (view.frame.width - totalSpacing) / LayoutConstant.itemsInRow
        
        return CGSize(width: widthWithoutSpacing, height: widthWithoutSpacing)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: LayoutConstant.spacing,
            left: LayoutConstant.spacing,
            bottom: LayoutConstant.spacing,
            right: LayoutConstant.spacing
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Did select cell at \(indexPath.row)")
    }
}

extension PhotosViewController : ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        
        self.photos = images
        
        collectionView.reloadData()
        
    }
    
}
