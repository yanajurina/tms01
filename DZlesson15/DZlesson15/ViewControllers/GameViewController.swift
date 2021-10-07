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
    
    var image: UIImage!
    var board: UIView!
    var checkers: UIImageView!
    var timer: Timer?
    var countSec: Int = 0
    var countMin: Int = 0
    var isLongPress: Bool = false
    var currentDirection: DirectionCheckers = .white
    var stepCount: Int = 1
    var saveCellAndChecker: [SaveGame] = []
    var playerNames: [SaveGame] = []
    var gameImage: [SaveGame] = []
    let dateFormatter = DateFormatter()
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        
        let date = Date()
        dateFormatter.dateFormat = "dd.MM.yy"
        dateLabel.text = dateFormatter.string(from: date)
        
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.saveSellAndChecker.rawValue)
        if FileManager().fileExists(atPath: fileURL.path) {
        presentAlertController("Сontinue the game?", message: "", useTextField: false, preferredStyle: .alert, actions: UIAlertAction(title: "Yes", style: .default, handler: {_ in
            self.writePlayerNames()
            self.getBacackgroundImage()
            self.getDataGame()
            self.setTimerFromUserDefaults()
            self.createSaveChessboard()
            try? FileManager.default.removeItem(at: fileURL)
//            do {
//                let fileURL = self.documentDirectory.appendingPathComponent(KeysUserDefaults.saveSellAndChecker.rawValue)
//                try FileManager.default.removeItem(at: fileURL)
//            } catch {
//                print()
//            }
            self.initTimer()
            self.saveCellAndChecker.removeAll()
            
        }),
        UIAlertAction(title: "No", style: .cancel, handler: { _ in
            self.writePlayerNames()
            self.getDataGame()
            self.removeTimerFromUserDefaults()
            self.createChessboard()
            self.initTimer()
            try? FileManager.default.removeItem(at: fileURL)
        }))
        } else {
            modalTransitionStyle = .crossDissolve
            guard let vc = getViewController(from: "PlayerNames") as? PlayerNamesViewController else { return }
            vc.delegate = self
            present(vc, animated: true, completion: nil)
            initTimer()
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
        guard !playerNames.isEmpty else { return }
        writePlayerNames()
    }
    
    func getBacackgroundImage() {
        for value in gameImage {
            imageView.image = value.backgroundImage
        }
    }
    
    func writePlayerNames() {
        let fileURL2 = documentDirectory.appendingPathComponent(KeysUserDefaults.savePlayerNames.rawValue)
        guard let data2 = FileManager.default.contents(atPath: fileURL2.absoluteString.replacingOccurrences(of: "file://", with: "")),
              let object2 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data2) as? [SaveGame] else { return }
        self.playerNames = object2
        
        playersMoveLabel.text = currentDirection == .white ? "Your move,\(playerNames[0] )" : "Your move,\(playerNames[1])"
    }
    
    func delegateFunc(namePlayer1: String, namePlayer2: String) {
        playersMoveLabel.text = currentDirection == .white ? "Your move,\(namePlayer1)" : "Your move,\(namePlayer2)"
        let player1: SaveGame = SaveGame()
        player1.playerName1 = namePlayer1
        let player2: SaveGame = SaveGame()
        player2.playerName2 = namePlayer2
        playerNames.append(player1)
        playerNames.append(player2)
        let data = try? NSKeyedArchiver.archivedData(withRootObject: playerNames, requiringSecureCoding: true)
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.savePlayerNames.rawValue)
        try?data?.write(to: fileURL)
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
                checkers.image = row < 3 ? UIImage(named: "black") : UIImage(named: "white")
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
                        checkers.image = value.checkersColorTag == 1 ? UIImage(named: "black") : UIImage(named: "white")
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
        
//        let fileURL2 = documentDirectory.appendingPathComponent(KeysUserDefaults.savePlayerNames.rawValue)
//        guard let data2 = FileManager.default.contents(atPath: fileURL2.absoluteString.replacingOccurrences(of: "file://", with: "")),
//              let object2 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data2) as? [SaveGame] else { return }
//        self.playerNames = object2
        
        let fileURL3 = documentDirectory.appendingPathComponent(KeysUserDefaults.backgroundImage.rawValue)
        guard let data3 = FileManager.default.contents(atPath: fileURL3.absoluteString.replacingOccurrences(of: "file://", with: "")),
              let object3 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data3) as? [SaveGame] else { return }
        self.gameImage = object3
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
            sender.view?.frame.origin = CGPoint(x: 5.0, y: 5.0)
            guard let newCell = currentCell, newCell.subviews.isEmpty, let cell = sender.view else {return}
            currentCell?.addSubview(cell)
            currentDirection = currentDirection == .white ? .black : .white
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
                                                self.saveBackgroundGame()
                                                self.saveTimerToUserDefaults()
                                                self.navigationController?.popToRootViewController(animated: true)}),
                                UIAlertAction(title: "No", style: .cancel, handler: { _ in
                                                let fileURL = self.documentDirectory.appendingPathComponent(KeysUserDefaults.saveSellAndChecker.rawValue)
                                                try? FileManager.default.removeItem(at: fileURL)
                                                self.removeTimerFromUserDefaults()
                                                self.navigationController?.popToRootViewController(animated: true)}))
    }
}
    
    extension GameViewController: UIGestureRecognizerDelegate {
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith
                                otherGestureRecognizer:UIGestureRecognizer) -> Bool {return true}
    }
