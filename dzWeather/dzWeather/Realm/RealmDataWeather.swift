//
//  RealmDataWeather.swift
//  dzWeather
//
//  Created by Янина on 3.11.21.
//

import UIKit
import RealmSwift

class RealmDataWeather: Object {
    @Persisted var city: String = ""
    @Persisted var temp: Int = 0
    
    convenience init(city: String, temp: Int) {
        self.init()
        self.city = city
        self.temp = temp
    }
}

