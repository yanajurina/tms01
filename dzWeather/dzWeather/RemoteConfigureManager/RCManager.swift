//
//  RCManager.swift
//  dzWeather
//
//  Created by Янина on 21.11.21.
//

import UIKit
import FirebaseRemoteConfig

enum RCValue: String {
    case appleMap
}

class RCManager {
    static let shared = RCManager()
    
    var defaultValue: [String: Any] = [RCValue.appleMap.rawValue: true]
    var remoteConfigConnected: (() -> ())?
    var isActivated: Bool = false
    
    init() {
        RemoteConfig.remoteConfig().setDefaults(defaultValue as? [String: NSObject])
    }
    
    func connected() {
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0.0) { status, error in
            guard status == .success else {
                print (error?.localizedDescription ?? "")
                return
            }
            RemoteConfig.remoteConfig().activate { result, error in
                self.isActivated = result
                
                if !result {
                    print (error?.localizedDescription ?? "")
                }
                self.remoteConfigConnected?()
            }
        }
    }
    
    func getBoolValue(from key: RCValue) -> Bool {
        return RemoteConfig.remoteConfig()[key.rawValue].boolValue
        
    }
}
