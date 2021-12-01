//
//  WeatherViewController.swift
//  dzWeather
//
//  Created by Янина on 12.09.21.
//

import UIKit
import AVFoundation
import AVKit
import NVActivityIndicatorView

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var videoView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempTextLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    var player: AVPlayer?
    var cityName = ""
    var dataWeather: DataWeather? {
        didSet {
            DispatchQueue.main.async {
                self.setup()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let activ = NVActivityIndicatorView(frame: CGRect(x: view.center.x - 30.0, y: view.center.y - 30.0, width: 60.0, height: 60.0), type: .ballSpinFadeLoader, color: .gray, padding: 0.0)
//        view.addSubview(activ)
//        activ.startAnimating()
//        activ.stopAnimating()
        
        setupVideo()
        
        HttpManager.shared.getData(city: cityName) { dataWeather in
            self.dataWeather = dataWeather
        }
    }
    
    func setup() {
        guard let dataWeather = dataWeather  else { return }
        guard !dataWeather.city.isEmpty else {
            cityLabel.text = "city not found..."
            tempLabel.text = ""
            tempTextLabel.text = ""
            windSpeedLabel.text = ""
            humidityLabel.text = ""
            return
        }
        cityLabel.text = dataWeather.city
        tempLabel.text = "\(Int(dataWeather.temp - 273.15))°C"
        tempTextLabel.text = dataWeather.description
        windSpeedLabel.text = "wind \(dataWeather.windSpeed)"
        humidityLabel.text = "humidity \(dataWeather.humidity)%"
        RealmManager.shared.saveDataWeather(whith: "\(dataWeather.city)", temp: Int(dataWeather.temp - 273.15))
    }
    
    func setupVideo() {
        guard let pathVideo = Bundle.main.path(forResource: "Mountains", ofType: "mp4") else { return }
        
        let urlVideo = URL(fileURLWithPath: pathVideo)
        let asset = AVAsset(url: urlVideo)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        self.player = player
        let videoLayer = AVPlayerLayer(player: player)
        videoLayer.frame = CGRect(origin: .zero, size: view.frame.size)
        videoLayer.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(videoLayer, at: 0)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: .main) { _ in
                self.player?.volume = 0.0
                self.player?.seek(to: .zero)
                self.player?.play()
            }
        player.play()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
