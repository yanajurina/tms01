//
//  RealmManager.swift
//  dzWeather
//
//  Created by Янина on 3.11.21.
//

import UIKit
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    let localRealm = try! Realm()
    
    func saveDataWeather(whith city: String, temp: Int ) {
        let data = RealmDataWeather(city: city, temp: temp)
        
        do {
            try localRealm.write {
                localRealm.add(data)
            }
            
        } catch (let e) {
            print(e)
        }
    }
    
    func getDataWeather() -> [RealmDataWeather] {
        let data = localRealm.objects(RealmDataWeather.self)
        return data.shuffled()
    }
}
 
