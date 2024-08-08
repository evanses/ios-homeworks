import UIKit
import AVFoundation

struct Track {
    let filename: String
    let title: String
}

class PlayerViewController: UIViewController {
    
    //MARK: -- Data
    
    private var Player = AVAudioPlayer()
    
    private let tracks = {
        [
            Track(filename: "Deutschland", title: "Rammstein - Deutschland"),
            Track(filename: "insideOfMe", title: "Dead By Sunrise - Inside Of Me"),
            Track(filename: "itsMyLife", title: "Bon Jovi - It's My Life"),
            Track(filename: "moscowCalling", title: "Gorky Park - Moscow Calling"),
            Track(filename: "paradiseCity", title: "Gans N' Roses - Paradise City"),
            Track(filename: "Queen", title: "Queen - Show must go on")
        ]
    }()
    
    private var currentSong: Int = 0 {
        didSet {
            if currentSong >= 6 {
                currentSong = 0
            } else if currentSong <= -1 {
                currentSong = 5
            }
        }
    }
    
    
    //MARK: -- Subview
    
    private lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor = .clear
        
        label.text = "Сейчас ничего не играет!"
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        
        button.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        
        button.addTarget(self, action: #selector(stopPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var privButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left.to.line.alt"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        
        button.addTarget(self, action: #selector(privPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right.to.line.alt"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        
        button.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Плеер"
        
        view.addSubview(songNameLabel)
        view.addSubview(playButton)
        view.addSubview(stopButton)
        view.addSubview(privButton)
        view.addSubview(nextButton)
        
        setupContraints()
        loadPlayer()
    }
    
    //MARK: -- Private
    
    private func loadPlayer() {
        do {
            Player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: tracks[currentSong].filename, ofType: "mp3")!))
            Player.prepareToPlay()
            
            songNameLabel.text = tracks[currentSong].title
        }
        catch {
            print(error)
        }
    }
    
    private func setupContraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate( [
            songNameLabel.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            songNameLabel.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            
            
            playButton.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 20.0),
            playButton.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor, constant: -30),
            
            privButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -40.0),
            privButton.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 20.0),
            
            
            stopButton.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 20.0),
            stopButton.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor, constant: 30),
            
            nextButton.leadingAnchor.constraint(equalTo: stopButton.trailingAnchor, constant: 40.0),
            nextButton.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 20.0)

        ])
    }
    
    private func changePlayer() {
        let playing = Player.isPlaying
        
        if Player.isPlaying {
            Player.stop()
        }
        
        do {
            Player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: tracks[currentSong].filename, ofType: "mp3")!))
            Player.prepareToPlay()
            
            songNameLabel.text = tracks[currentSong].title
            
            if playing {
                Player.play()
            }
        }
        catch {
            print(error)
        }
    }
    
    //MARK: -- Actions
    
    @objc private func playPressed() {
        if Player.isPlaying {
            Player.pause()
            
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            
        } else {
            Player.play()
            
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        
    }
    
    @objc private func stopPressed() {
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        
        Player.stop()
        Player.currentTime = 0
    }
    
    @objc private func privPressed() {
        currentSong -= 1
    
        changePlayer()
    }
    
    @objc private func nextPressed() {
        currentSong += 1
        
        changePlayer()
    }
}
