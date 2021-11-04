//
//  WeatherViewController.swift
//  dzWeather
//
//  Created by Янина on 12.09.21.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempTextLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var dataWeather = DataWeather(city: "", data: 0, temp: 0, description: "", windSpeed: 0, humidity: 0)
    var dataWeatherArray:[DataWeather] = [DataWeather(city: "", data: 0, temp: 0, description: "", windSpeed: 0, humidity: 0)] {
        didSet {
           setup()
        }
    }
    var cityName = "london"
    let urlString = "http://api.openweathermap.org/data/2.5/weather?q=London&appid=54d5120f5e32033ecf6e8ef3a0970d5c"
    let propertiesTitles = ("temperature", "weather", "humidity", "wind speed")
    var image = UIImage(named: "0")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        imageView.contentMode = .scaleToFill
        
        HttpManager.shared.getData { dataWeatherArray in
            self.dataWeatherArray = dataWeatherArray
        }
        
        getData()
        setup()
        
    }
    
    func setup() {
        cityLabel.text = dataWeatherArray[0].city
        dataLabel.text = "\(dataWeatherArray[0].data)"
        tempLabel.text = "\(dataWeatherArray[0].temp)"
        tempTextLabel.text = dataWeatherArray[0].description
        windSpeedLabel.text = "\(dataWeatherArray[0].windSpeed)"
        humidityLabel.text = "\(dataWeatherArray[0].humidity)"
    }
    
    func getData() {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }
            guard let city = json["name"] as? String,
                  let dt = json["dt"] as? Int64 else { return }
            guard let wind = json["wind"] as? [String: Any] else { return }
            var windWindSpeed = 0.00
            wind.forEach { value in
                windWindSpeed = 0
                guard let windSpeed = wind["speed"] as? Double else { return }
                windWindSpeed = windSpeed
            }
            guard let main = json["main"] as? [String: Any] else { return }
            var mainHumidity: Int64 = 0
            var mainTemp = 0.0
            main.forEach { value in
                guard let humidity = main["humidity"] as? Int64,
                      let temp = main["temp"] as? Double else { return }
                mainHumidity = humidity
                mainTemp = temp
            }
            guard let weather = json["weather"] as? [[String: Any]] else { return }
            var weatherDescription = ""
            weather.forEach { value1 in
                value1.forEach { value2 in
                    guard let description = value1["description"] as? String else { return }
                    weatherDescription = description
                }
            }
            dataWeather = DataWeather(city: city, data: dt, temp: mainTemp, description: weatherDescription, windSpeed: windWindSpeed, humidity: mainHumidity)
//            dataWeatherArray.removeAll()
            dataWeatherArray.append(dataWeather)
        }
        session.resume()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
