//
//  APIConstants.swift
//  dzWeather
//
//  Created by Янина on 30.10.21.
//

import UIKit
import CoreLocation

enum APIConstants: String {
    case urlCityName = "http://api.openweathermap.org/data/2.5/weather?q=%@&appid=54d5120f5e32033ecf6e8ef3a0970d5c"
    case urlCityLocation = "http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=54d5120f5e32033ecf6e8ef3a0970d5c"
    case urlNews = "http://wn.com/"
    
    static func getCityForUrl(from city: String?) -> URL? {
        return URL(string: String(format: APIConstants.urlCityName.rawValue, city ?? ""))
    }
    
    static func getLocationForUrl(from locationLat: String, locationLon: String ) -> URL? {
        return URL(string: String(format: APIConstants.urlCityLocation.rawValue, locationLat, locationLon ))
        
    }
}
