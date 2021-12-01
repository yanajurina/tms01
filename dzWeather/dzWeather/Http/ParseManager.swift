//
//  ParseManager.swift
//  dzWeather
//
//  Created by Янина on 30.10.21.
//

import UIKit

class ParseManager {
    static let shared = ParseManager()
    
    func parseData(_ data: Data) -> DataWeather {
        var weatherData: DataWeather = DataWeather(city: "", temp: 0.0, description: "", windSpeed: 0.0, humidity: 0)
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return weatherData }
        guard let cod = json["cod"] as? Int64 else { return weatherData }
        guard let city = json["name"] as? String else { return weatherData }
//              let dt = json["dt"] as? Int64 else { return weatherData }
        guard let wind = json["wind"] as? [String: Any] else { return weatherData}
        var windWindSpeed = 0.00
        wind.forEach { value in
            windWindSpeed = 0
            guard let windSpeed = wind["speed"] as? Double else { return }
            windWindSpeed = windSpeed
        }
        guard let main = json["main"] as? [String: Any] else { return weatherData }
        var mainHumidity: Int64 = 0
        var mainTemp = 0.0
        main.forEach { value in
            guard let humidity = main["humidity"] as? Int64,
                  let temp = main["temp"] as? Double else { return }
            mainHumidity = humidity
            mainTemp = temp
        }
        guard let weather = json["weather"] as? [[String: Any]] else { return weatherData }
        var weatherDescription = ""
        weather.forEach { value1 in
            value1.forEach { value2 in
                guard let description = value1["description"] as? String else { return }
                weatherDescription = description
            }
        }
        weatherData = DataWeather(city: city, temp: mainTemp, description: weatherDescription, windSpeed: windWindSpeed, humidity: mainHumidity)
      return weatherData
    }
}
