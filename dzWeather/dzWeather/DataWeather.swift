//
//  DataWeather.swift
//  dzWeather
//
//  Created by Янина on 26.10.21.
//

import UIKit

class DataWeather {

    var city: String
//    var data: Int64
    var temp: Double
    var description: String
    var windSpeed: Double
    var humidity: Int64
    
    init(city: String, temp: Double, description: String, windSpeed: Double, humidity: Int64) {
        self.city = city
//        self.data = data
        self.temp = temp
        self.description = description
        self.windSpeed = windSpeed
        self.humidity = humidity
    }
}
