import UIKit
import iOSIntPackage

class ParkBenchTimer {
    let startTime:CFAbsoluteTime
    var endTime:CFAbsoluteTime?

    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }

    func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()

        return duration!
    }

    var duration: CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}


class PhotosViewController : UIViewController {
    
    // MARK: - Data
    
    let imageProcessor = ImageProcessor()
    
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        
        let networkService = NetworkService()
        var p: [Photo] = []
        
        do {
            p = try networkService.getPhotos()
        } catch PhotoError.cannotCreatePhotos {
            alertMessage.title = "Не могу загрузить фотографии: Бобер перегрыз патчкорд!"
            self.present(alertMessage, animated: true)
            
        } catch {
            print("default")
        }
        
        p.forEach {
            if let i: UIImage = UIImage(named: $0.fileName) {
                photos.append(i)
            }
        }

        let timer = ParkBenchTimer()
        imageProcessor.processImagesOnThread(
            sourceImages: photos,
            filter: .fade,
            qos: .background,
            completion: { (images: [CGImage?]) in
                
                print("Stop processing in \(timer.stop()) seconds.")
                
                var new: [UIImage] = []
                images.forEach {
                    if let i: CGImage = $0 {
                        new.append(UIImage(cgImage: i))
                    }
                }
                
                self.photos = new
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        )
    }
    
    override func viewDidAppear(_ animated: Bool) { //что бы navigationBar не изчез, когда потянул за край и отпустил случайно (контроллер вернулся обратно)
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - Private
    
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
