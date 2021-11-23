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
    var lady: Bool?
    var playerName1: String = ""
    var playerName2: String = ""
    var backgroundImage: UIImage = UIImage(named: "1")!
    var saveCurrentCheker: Int? = nil
    var styleCheckerGame: String?
    
    init (styleCheckerGame: String) {
        self.styleCheckerGame = styleCheckerGame
    }
    
    override init() {
        super.init ()
    }
   
    func encode(with coder: NSCoder) {
        coder.encode(checkersPositionTag, forKey: KeysUserDefaults.checkersPositionTag.rawValue)
        coder.encode(checkersColorTag, forKey: KeysUserDefaults.checkersColorTag.rawValue)
        coder.encode(lady, forKey: KeysUserDefaults.checkerIsLady.rawValue)
        coder.encode(playerName1, forKey: KeysUserDefaults.playerName1.rawValue)
        coder.encode(playerName2, forKey: KeysUserDefaults.playerName2.rawValue)
        coder.encode(backgroundImage, forKey: KeysUserDefaults.backgroundImage.rawValue)
        coder.encode(saveCurrentCheker, forKey: KeysUserDefaults.saveCurrentCheker.rawValue)
    }
    
    required init?(coder: NSCoder) {
        checkersPositionTag = coder.decodeObject(forKey: KeysUserDefaults.checkersPositionTag.rawValue) as? Int
        checkersColorTag = coder.decodeObject(forKey: KeysUserDefaults.checkersColorTag.rawValue) as? Int
        lady = coder.decodeObject(forKey: KeysUserDefaults.checkerIsLady.rawValue) as? Bool
        playerName1 = coder.decodeObject(forKey: KeysUserDefaults.playerName1.rawValue) as! String
        playerName1 = coder.decodeObject(forKey: KeysUserDefaults.playerName2.rawValue) as! String
        backgroundImage = coder.decodeObject(forKey: KeysUserDefaults.backgroundImage.rawValue) as! UIImage
        saveCurrentCheker = coder.decodeObject(forKey: KeysUserDefaults.saveCurrentCheker.rawValue) as? Int
    }
    
    static func saveStyleChecker(_ selectStyleChecers: [StyleChecker]) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL0 = documentDirectory.appendingPathComponent(KeysUserDefaults.checkers.rawValue)
        try? FileManager.default.removeItem(at: fileURL0)
        let checkers = selectStyleChecers
        let data = try? NSKeyedArchiver.archivedData(withRootObject: checkers, requiringSecureCoding: true)
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.checkers.rawValue)
        try?data?.write(to: fileURL)
    }
    
    static func getStyleChecker() -> [StyleChecker] {
        let test = [StyleChecker(whiteChecker: "", blackChecker: "", stateSwitch: true)]
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.checkers.rawValue)
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")) else { return test}
            let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [StyleChecker]
        
        return (object ?? test)
    }

}

