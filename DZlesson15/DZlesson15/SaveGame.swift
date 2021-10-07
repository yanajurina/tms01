//
//  SaveGame.swift
//  DZlesson15
//
//  Created by Янина on 17.08.21.
//

import UIKit

//let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

class SaveGame: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    var checkersPositionTag: Int? = nil
    var checkersColorTag: Int? = nil
    var playerName1: String = ""
    var playerName2: String = ""
    var backgroundImage: UIImage = UIImage(named: "1")!
    var currentCheker: Int? = nil
    
    override init() {
        super.init ()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(checkersPositionTag, forKey: KeysUserDefaults.checkersPositionTag.rawValue)
        coder.encode(checkersColorTag, forKey: KeysUserDefaults.checkersColorTag.rawValue)
        coder.encode(playerName1, forKey: KeysUserDefaults.playerName1.rawValue)
        coder.encode(playerName2, forKey: KeysUserDefaults.playerName2.rawValue)
        coder.encode(backgroundImage, forKey: KeysUserDefaults.backgroundImage.rawValue)
        coder.encode(currentCheker, forKey: KeysUserDefaults.currentCheker.rawValue)
    }
    
    required init?(coder: NSCoder) {
        checkersPositionTag = coder.decodeObject(forKey: KeysUserDefaults.checkersPositionTag.rawValue) as? Int
        checkersColorTag = coder.decodeObject(forKey: KeysUserDefaults.checkersColorTag.rawValue) as? Int
        playerName1 = coder.decodeObject(forKey: KeysUserDefaults.playerName1.rawValue) as! String
        playerName1 = coder.decodeObject(forKey: KeysUserDefaults.playerName2.rawValue) as! String
        backgroundImage = coder.decodeObject(forKey: KeysUserDefaults.backgroundImage.rawValue) as! UIImage
        currentCheker = coder.decodeObject(forKey: KeysUserDefaults.currentCheker.rawValue) as? Int
    }
    
//    static func saveplayerNames(_ player1: String, player2: String) {
//        let playerNames = [player1, player2]
//        let data = try? NSKeyedArchiver.archivedData(withRootObject: playerNames, requiringSecureCoding: true)
//        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.saveNames.rawValue)
//        try?data?.write(to: fileURL)
//    }
}

