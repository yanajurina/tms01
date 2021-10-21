//
//  StyleChecker.swift
//  DZlesson15
//
//  Created by Янина on 14.10.21.
//

import UIKit

class StyleChecker: NSObject, NSCoding, NSSecureCoding {
    
    static var supportsSecureCoding: Bool = true
    
    
    var whiteChecker: String?
    var blackChecker: String?
    var stateSwitch: Bool
    
    init(whiteChecker: String, blackChecker: String, stateSwitch: Bool ) {
        self.whiteChecker = whiteChecker
        self.blackChecker = blackChecker
        self.stateSwitch = stateSwitch
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(whiteChecker, forKey: KeysUserDefaults.whiteChecker.rawValue)
        coder.encode(blackChecker, forKey: KeysUserDefaults.blackChecker.rawValue)
        coder.encode(stateSwitch, forKey: KeysUserDefaults.stateSwitch.rawValue)
    }
    
    required init?(coder: NSCoder) {
        self.whiteChecker = coder.decodeObject(forKey: KeysUserDefaults.whiteChecker.rawValue) as? String
        self.blackChecker = coder.decodeObject(forKey: KeysUserDefaults.blackChecker.rawValue) as? String
        self.stateSwitch = coder.decodeBool(forKey: KeysUserDefaults.stateSwitch.rawValue)
    }
}
