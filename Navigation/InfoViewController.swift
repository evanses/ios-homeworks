import UIKit

class InfoViewController: UIViewController {
    
    // MARK: Subviews
    
    private lazy var someButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Alert", for: .normal)
        
        return button
    }()
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()

    // MARK: Livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        view.addSubview(self.someButton)
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            someButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            someButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            someButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            someButton.heightAnchor.constraint(equalToConstant: 44.0),
            
            firstLabel.topAnchor.constraint(equalTo: someButton.bottomAnchor, constant: 10.0),
            firstLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 18.0),
            secondLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

        ])
        
        someButton.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchUpInside)
        
        updateLabels()
    }
    
    // MARK: Private
    
    private func updateLabels() {
        NetworkManager.shared.getUser(by: 10) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else {
                    return
                }
                
                switch result{
                case .success(let text):
                    self.firstLabel.text = text
                case .failure(let error):
                    self.firstLabel.text = error.description
                }
            }
        }
        
        NetworkManager.shared.getPlanetOrbitalPeriod { [weak self] result in
            DispatchQueue.main.async {
                guard let self else {
                    return
                }
                
                switch result{
                case .success(let orbitalPeriod):
                    self.secondLabel.text = "Период обращения - \(orbitalPeriod)"
                case .failure(let error):
                    self.secondLabel.text = error.description
                }
            }
        }
    }
    
    // MARK: Actions
    
    @objc func buttonPressed(_ sender: UIButton) {
        let newAlertController = UIAlertController()
        newAlertController.title = "Какой-то алерт!!!!"
        newAlertController.message = "Что-то случилось и поэтому алерт!"
        newAlertController.addAction(UIAlertAction(title: "Паниковать!", style: .default, handler: { action in
            print("put your hands up and run in circles!")
        }))
        newAlertController.addAction(UIAlertAction(title: "Keep calm...", style: .cancel, handler: { action in
            print("drink coffie and just relax!")
        }))

        self.present(newAlertController, animated: true)
        
    }
}
