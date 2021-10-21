//
//  GameViewController.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

protocol ViewControllerDelegate: class {
    func delegateFunc(namePlayer1: String, namePlayer2: String)
}
class GameViewController: UIViewController, ViewControllerDelegate {
    
    enum DirectionCheckers: Int {
        case white = 0
        case black = 1
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var playersMoveLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var buttonStop: UIButton!
    
    var currentLanguage: Language = .english
    var image: UIImage!
    var board: UIView!
    var checkers: UIImageView!
    var timer: Timer?
    var countSec: Int = 0
    var countMin: Int = 0
    var isLongPress: Bool = false
    var currentDirection: DirectionCheckers = .white
    var stepCount: Int = 1
    var playerNames: [String] = []
    let dateFormatter = DateFormatter()
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let userDefaults = UserDefaults.standard
    var playerWhite: String = ""
    var playerBlack: String = ""
    var gameImage: [SaveGame] = []
    var saveCellAndChecker: [SaveGame] = []
    var saveCurrentChecker: [SaveGame] = []
    var styleStyleCheker = StyleChecker(whiteChecker: "white", blackChecker: "black", stateSwitch: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupLanguage()
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        
        let date = Date()
        dateFormatter.dateFormat = "dd.MM.yy"
        dateLabel.text = dateFormatter.string(from: date)
        
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.saveSellAndChecker.rawValue)
        let fileURL2 = documentDirectory.appendingPathComponent(KeysUserDefaults.saveCurrentCheker.rawValue)
        let fileURL3 = documentDirectory.appendingPathComponent(KeysUserDefaults.backgroundImage.rawValue)
        let fileURL4 = documentDirectory.appendingPathComponent(KeysUserDefaults.savePlayerNames.rawValue)
        if FileManager().fileExists(atPath: fileURL.path) {
        presentAlertController("Сontinue the game?", message: "", useTextField: false, preferredStyle: .alert, actions: UIAlertAction(title: "Yes", style: .default, handler: {_ in
            SaveGame.getStyleChecker()
            self.getstyle()
            self.getPlayerNames()
            self.getDataGame()
            self.getCurrentDirection()
            self.setTimerFromUserDefaults()
            self.createSaveChessboard()
            self.writeNames()
            try? FileManager.default.removeItem(at: fileURL)
            try? FileManager.default.removeItem(at: fileURL2)
            try? FileManager.default.removeItem(at: fileURL3)
            try? FileManager.default.removeItem(at: fileURL4)
//            do {
//                let fileURL = self.documentDirectory.appendingPathComponent(KeysUserDefaults.saveSellAndChecker.rawValue)
//                try FileManager.default.removeItem(at: fileURL)
//            } catch {
//                print()
//            }
            self.initTimer()
            self.saveCellAndChecker.removeAll()
            self.saveCurrentChecker.removeAll()
            self.gameImage.removeAll()
        }),
        UIAlertAction(title: "No", style: .cancel, handler: { _ in
            self.getPlayerNames()
            self.getDataGame()
            self.removeTimerFromUserDefaults()
            self.createChessboard()
            self.writeNames()
            self.initTimer()
            try? FileManager.default.removeItem(at: fileURL)
        }))
        } else {
            modalTransitionStyle = .crossDissolve
            guard let vc = getViewController(from: "PlayerNames") as? PlayerNamesViewController else { return }
            vc.currentLanguage = currentLanguage
            vc.delegate = self
            present(vc, animated: true, completion: nil)
            self.getstyle()
            createChessboard()
        }
       
        let textTimerLabel = "\(countMin):\(countSec)"
        let attributTextTimerLabel = NSMutableAttributedString(string: "\(textTimerLabel)", attributes: [
                                                                                            .font: UIFont(name: "Anton-Regular", size: 40)
                                                                                            ?? UIFont.systemFont(ofSize: 20.0),
                                                                                            .foregroundColor: UIColor.orange])
        var attributes: [NSMutableAttributedString.Key: Any] = [.font: UIFont(name: "Anton-Regular", size: 40)
                                                                ?? UIFont.systemFont(ofSize: 20.0),
                                                                .foregroundColor: UIColor.orange]
        let attributesStop = NSMutableAttributedString(string: "Stop")
        attributes[.font] = UIFont(name: "Anton-Regular", size: 30)
        attributes[.foregroundColor] = UIColor.orange
        attributesStop.addAttributes(attributes, range: NSRange(location: 0, length: 4))
    
        timerLabel.attributedText = attributTextTimerLabel
        buttonStop.setAttributedTitle(attributesStop, for: .normal)
        buttonStop.layer.cornerRadius = buttonStop.frame.size.width / 4
        buttonStop.addShadow(with: .green, opacity: 3, shadowOffset: .zero)
        setupLanguage()
    }
    
    func saveCurrentDirection() {
        let saveDirection: SaveGame = SaveGame()
        saveDirection.saveCurrentCheker = currentDirection.rawValue
        saveCurrentChecker.append(saveDirection)
        let data = try? NSKeyedArchiver.archivedData(withRootObject: saveCurrentChecker, requiringSecureCoding: true)
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.saveCurrentCheker.rawValue)
        try?data?.write(to: fileURL)
    }
    
    func setupLanguage() {
        switch currentLanguage {
        case .english: localized(by: "en")
        case .russian: localized(by: "ru")
        }
    }
    
    func localized(by languageCode: String) {
        guard let languagePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let languageBundle = Bundle(path: languagePath) else { return }
        buttonStop.titleLabel?.text = NSLocalizedString("button_stop_text", bundle: languageBundle, value: "", comment: "")
    }
    
    func getPlayerNames() {
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.savePlayerNames.rawValue)
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")),
              let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] else { return }
        self.playerNames = object
        playerWhite = playerNames[0]
        playerBlack = playerNames[1]
    }
    
    func writeNames() {
        playersMoveLabel.text = currentDirection == .white ? "Your move,\(playerWhite)" : "Your move,\(playerBlack)"
    }
    
    func delegateFunc(namePlayer1: String, namePlayer2: String) {
        playersMoveLabel.text = currentDirection == .white ? "Your move,\(namePlayer1)" : "Your move,\(namePlayer2)"
        playerWhite = namePlayer1
        playerBlack = namePlayer2
        playerNames.append(playerWhite)
        playerNames.append(playerBlack)
        initTimer()
    }
    
    func saveNames() {
        let data = try? NSKeyedArchiver.archivedData(withRootObject: playerNames, requiringSecureCoding: true)
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.savePlayerNames.rawValue)
        try?data?.write(to: fileURL)
    }
    
    func getstyle() {
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.checkers.rawValue)
        if FileManager().fileExists(atPath: fileURL.path) {
            let styleChecker = SaveGame.getStyleChecker()
            styleChecker.forEach { style in
                if style.stateSwitch == true {
                    styleStyleCheker = style
                }
            }
        }
    }
    
    func createChessboard() {
        let size = view.bounds.size.width - 32
        let sizeCheck = size / 8
        
        board = UIView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        board.backgroundColor = .white
        board.center = view.center
        board.addShadow(with: .black, opacity: 0.6, shadowOffset: CGSize(width: 10, height: 10))
        view.addSubview(board)
        
        var count = 0
        for row in 0...7 {
            for column in 0...7 {
                let check = UIView(frame: CGRect(x: CGFloat(sizeCheck) * CGFloat(column), y: CGFloat(sizeCheck) * CGFloat(row), width: CGFloat(sizeCheck), height: CGFloat(sizeCheck)))
                check.backgroundColor = ((row + column) % 2 == 0) ? .white : .black
                check.tag = count
                count += 1
                board.addSubview(check)
                
                guard check.backgroundColor == .black, row < 3 || row > 4 else {continue}
                checkers = UIImageView(frame: CGRect(x: 5, y: 5, width: sizeCheck - 10, height: sizeCheck - 10))
                checkers.clipsToBounds = true
                checkers.isUserInteractionEnabled = true
                checkers.tag = row < 3 ? 1 : 0
                checkers.image = row < 3 ? UIImage(named: styleStyleCheker.blackChecker!) : UIImage(named: styleStyleCheker.whiteChecker!)
                checkers.layer.cornerRadius = checkers.frame.size.width / 2
                check.addSubview(checkers)
                let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressRecognizer(_:)))
                longPress.minimumPressDuration = 0.2
                longPress.delegate = self
                checkers.addGestureRecognizer(longPress)
                let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer(_:)))
                pan.delegate = self
                checkers.addGestureRecognizer(pan)
            }
        }
    }
    
    func createSaveChessboard() {
        let size = view.bounds.size.width - 32
        let sizeCheck = size / 8
        
        board = UIView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        board.backgroundColor = .white
        board.center = view.center
        board.addShadow(with: .black, opacity: 0.8, shadowOffset: CGSize(width: 10, height: 10))
        view.addSubview(board)
        
        var count = 0
        for row in 0...7 {
            for column in 0...7 {
                let check = UIView(frame: CGRect(x: CGFloat(sizeCheck) * CGFloat(column), y: CGFloat(sizeCheck) * CGFloat(row), width: CGFloat(sizeCheck), height: CGFloat(sizeCheck)))
                check.backgroundColor = ((row + column) % 2 == 0) ? .white : .black
                check.tag = count
                count += 1
                board.addSubview(check)
                
                for value in saveCellAndChecker {
                    if check.tag == value.checkersPositionTag {
                        checkers = UIImageView(frame: CGRect(x: 5, y: 5, width: sizeCheck - 10, height: sizeCheck - 10))
                        checkers.clipsToBounds = true
                        checkers.isUserInteractionEnabled = true
                        checkers.image = row < 3 ? UIImage(named: styleStyleCheker.blackChecker!) : UIImage(named: styleStyleCheker.whiteChecker!)
                        checkers.tag = value.checkersColorTag == 1 ? DirectionCheckers.black.rawValue : DirectionCheckers.white.rawValue
                        checkers.layer.cornerRadius = checkers.frame.size.width / 2
                        check.addSubview(checkers)
                        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressRecognizer(_:)))
                        longPress.minimumPressDuration = 0.2
                        longPress.delegate = self
                        checkers.addGestureRecognizer(longPress)
                        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer(_:)))
                        pan.delegate = self
                        checkers.addGestureRecognizer(pan)
                    }
                }
            }
        }
    }
    
    func saveDataGame() {
        board.subviews.forEach {cell in
            if !cell.subviews.isEmpty {
                let position: SaveGame = SaveGame()
                position.checkersPositionTag = cell.tag
                cell.subviews.forEach {checker in
                    position.checkersColorTag = checker.tag
                }
                saveCellAndChecker.append(position)
            }
        }
        
        let data = try? NSKeyedArchiver.archivedData(withRootObject: saveCellAndChecker, requiringSecureCoding: true)
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.saveSellAndChecker.rawValue)
        try?data?.write(to: fileURL)
    }
    
    func saveBackgroundGame() {
        let imageGame: SaveGame = SaveGame()
        imageGame.backgroundImage = image ?? UIImage()
        gameImage.append(imageGame)
        let data = try? NSKeyedArchiver.archivedData(withRootObject: gameImage, requiringSecureCoding: true)
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.backgroundImage.rawValue)
        try?data?.write(to: fileURL)
    }
    
    func getDataGame() {
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.saveSellAndChecker.rawValue)
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")),
              let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [SaveGame] else { return }
        self.saveCellAndChecker = object
        
        let fileURL2 = documentDirectory.appendingPathComponent(KeysUserDefaults.savePlayerNames.rawValue)
        guard let data2 = FileManager.default.contents(atPath: fileURL2.absoluteString.replacingOccurrences(of: "file://", with: "")),
              let object2 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data2) as? [String] else { return }
        self.playerNames = object2
        
        let fileURL3 = documentDirectory.appendingPathComponent(KeysUserDefaults.backgroundImage.rawValue)
        guard let data3 = FileManager.default.contents(atPath: fileURL3.absoluteString.replacingOccurrences(of: "file://", with: "")),
              let object3 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data3) as? [SaveGame] else { return }
    
        for value in object3 {
            imageView.image = image ?? value.backgroundImage
        }
        
        let fileURL4 = documentDirectory.appendingPathComponent(KeysUserDefaults.saveCurrentCheker.rawValue)
        guard let data4 = FileManager.default.contents(atPath: fileURL4.absoluteString.replacingOccurrences(of: "file://", with: "")),
              let object4 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data4) as? [SaveGame] else { return }
        self.saveCurrentChecker = object4
    }
    
    func getCurrentDirection() {
        for value in saveCurrentChecker {
            currentDirection = value.saveCurrentCheker == 0 ? .white : .black
        }
    }
    
    func saveTimerToUserDefaults() {
        userDefaults.setValue(countSec, forKey: KeysUserDefaults.timerSec.rawValue)
        userDefaults.setValue(countMin, forKey: KeysUserDefaults.timerMin.rawValue)
    }

    func removeTimerFromUserDefaults() {
        userDefaults.removeObject(forKey: KeysUserDefaults.timerSec.rawValue)
        userDefaults.removeObject(forKey: KeysUserDefaults.timerMin.rawValue)
    }

    func setTimerFromUserDefaults() {
        self.countSec = userDefaults.integer(forKey: KeysUserDefaults.timerSec.rawValue)
        self.countMin = userDefaults.integer(forKey: KeysUserDefaults.timerMin.rawValue)
    }
    
    func initTimer() {
        timer = Timer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        UIView.animate(withDuration: 2) { [self] in
            self.timerLabel.transform = timerLabel.transform.scaledBy(x: 1.1, y: 1.1)
        }
    }
    
    func checkersMove() {
        
    }
    
    @objc func timerFunc() {
        countSec += 1
        if countSec > 59 {
            countMin += 1
            countSec = 0
        }
        let sec = countSec < 10 ? ": 0\(countSec)" : ": \(countSec)"
        let min = countMin < 10 ? "0\(countMin) " : "\(countMin) "
        timerLabel.text = min + sec
    }
    
    @objc func longPressRecognizer(_ sender: UILongPressGestureRecognizer) {
        guard let cheker = sender.view, cheker.tag == currentDirection.rawValue else { return }
        let location = sender.location(in: board)
        switch sender.state {
        case .began:
            UIImageView.animate(withDuration: 0.3) {
                cheker.transform = cheker.transform.scaledBy(x: 1.3, y: 1.3)
                }
        case .ended:
            UIImageView.animate(withDuration: 0.3) {
                cheker.transform = .identity
            }
            let currentCell = board.subviews.first(where: {$0.frame.contains(location) && $0.backgroundColor == .black })
            cheker.frame.origin = CGPoint(x: 5.0, y: 5.0)
            
//            if let newCell = currentCell?.subviews, !newCell.isEmpty {
//
//                let newCurrentCell0 = currentCell?.tag == cheker.superview!.tag + 7 ? cheker.superview!.tag + 14 : cheker.superview!.tag + 9
//                let newCurrentCell1 = currentCell?.tag == cheker.superview!.tag + 9 ? cheker.superview!.tag + 18 : cheker.superview!.tag + 7
//                guard currentCell?.tag == newCurrentCell0 || currentCell?.tag == newCurrentCell1 else { return }
//                    currentCell?.addSubview(cheker)
//            }
//            if cheker.tag == 0 {
//                    let newCurrentCell0 = currentCell?.tag == cheker.superview!.tag - 7 ? cheker.superview!.tag - 14 : cheker.superview!.tag - 9
//                    let newCurrentCell1 = currentCell?.tag == cheker.superview!.tag - 9 ? cheker.superview!.tag - 18 : cheker.superview!.tag - 7
//                    guard currentCell?.tag == newCurrentCell0 || currentCell?.tag == newCurrentCell1 else { return }
//                    currentCell?.addSubview(cheker)
//
//            }

            guard let newCell = currentCell, newCell.subviews.isEmpty, let cell = sender.view else {return}
            let newCurrentCell0 = cheker.tag == 0 ? cell.superview!.tag - 7 : cell.superview!.tag + 7
            let newCurrentCell1 = cheker.tag == 0 ? cell.superview!.tag - 9 : cell.superview!.tag + 9
            
            guard newCell.tag == newCurrentCell0 || newCell.tag == newCurrentCell1 else { return }
          
            currentCell?.addSubview(cell)
            currentDirection = currentDirection == .white ? .black : .white
            getPlayerNames()
            writeNames()
        default: break
        }
    }
    
   @objc func panGestureRecognizer(_ sender: UIPanGestureRecognizer) {
    guard let cheker = sender.view, cheker.tag == currentDirection.rawValue,
              cheker.transform != .identity else { return }
        let translation = sender.translation(in: board)

        switch sender.state {
        case .changed:
            guard let column = sender.view?.superview, let cellOrigin = sender.view?.frame.origin else { return }
            board.bringSubviewToFront(column)
            sender.view?.frame.origin = CGPoint(x: cellOrigin.x + translation.x,
                                                y: cellOrigin.y + translation.y)
            sender.setTranslation(.zero, in: board)
        default: break
        }
    }
    
    @IBAction func stopButton(_ sender: Any) {
        timer?.invalidate()
        presentAlertController("Save the game?", message: "", useTextField: false, preferredStyle: .alert, actions:
                                UIAlertAction(title: "Yes", style: .default, handler: {_ in
                                                self.saveDataGame()
                                                self.saveNames()
                                                self.saveBackgroundGame()
                                                self.saveTimerToUserDefaults()
                                                self.saveCurrentDirection()
                                                CoreDataManager.shared.addNewResults(by: ResultsModel(data_m: self.dateLabel.text , playerWhite_m: self.playerWhite, playerBlack_m: self.playerBlack))
                                                self.navigationController?.popToRootViewController(animated: true)}),
                                UIAlertAction(title: "No", style: .cancel, handler: { _ in
                                                let fileURL = self.documentDirectory.appendingPathComponent(KeysUserDefaults.saveSellAndChecker.rawValue)
//                                                let fileURL1 = self.documentDirectory.appendingPathComponent(KeysUserDefaults.checkers.rawValue)
                                                let fileURL2 = self.documentDirectory.appendingPathComponent(KeysUserDefaults.savePlayerNames.rawValue)
                                                try? FileManager.default.removeItem(at: fileURL)
//                                                try? FileManager.default.removeItem(at: fileURL1)
                                                try? FileManager.default.removeItem(at: fileURL2)
                                                self.removeTimerFromUserDefaults()
                                                self.navigationController?.popToRootViewController(animated: true)}))
    }
}

extension GameViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer:UIGestureRecognizer) -> Bool {return true}
}
