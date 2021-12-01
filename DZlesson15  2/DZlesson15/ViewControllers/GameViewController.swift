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
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    var currentLanguage: Language = .english
    var image: UIImage!
    var board: UIView!
    var checkers: UIImageView!
    var timer: Timer?
    var countSec: Int = 0
    var countMin: Int = 0
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
    var arrayCells: [UIView] = []
    var arrayChekers: [Checkers] = []
    var canFight: Bool = false
    var arrayIfCanFight: [(checker: Int, cell: Int, checkerBeaten: Int)] = [] //шашка которая может бить и на какую позицию она после этого становиться и какую шашку бьет
    
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
        //        let fileURL3 = documentDirectory.appendingPathComponent(KeysUserDefaults.backgroundImage.rawValue)
        let fileURL4 = documentDirectory.appendingPathComponent(KeysUserDefaults.savePlayerNames.rawValue)
        if FileManager().fileExists(atPath: fileURL.path) {
            presentAlertController("Сontinue the game?", message: "", useTextField: false, preferredStyle: .alert, actions: UIAlertAction(title: "Yes", style: .default, handler: { _ in
                self.getBackgroundGame()
                self.getStyleOfChekers()
                self.getPlayerNames()
                self.getDataGame()
                self.getCurrentDirection()
                self.setTimerFromUserDefaults()
                self.createSaveChessboard()
                self.findFight()
                self.writeNames()
                self.saveCellAndChecker.removeAll()
                try? FileManager.default.removeItem(at: fileURL)
                try? FileManager.default.removeItem(at: fileURL2)
                //            try? FileManager.default.removeItem(at: fileURL3)
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
                self.modalTransitionStyle = .crossDissolve
                guard let vc = self.getViewController(from: "PlayerNames") as? PlayerNamesViewController else { return }
                vc.currentLanguage = self.currentLanguage
                vc.delegate = self
                self.present(vc, animated: true, completion: nil)
                self.getBackgroundGame()
                self.getStyleOfChekers()
                self.getPlayerNames()
                self.getDataGame()
                self.removeTimerFromUserDefaults()
                self.createChessboard()
                self.writeNames()
                self.initTimer()
                try? FileManager.default.removeItem(at: fileURL)
            }))
        } else {
            self.getBackgroundGame()
            self.getStyleOfChekers()
            modalTransitionStyle = .crossDissolve
            guard let vc = getViewController(from: "PlayerNames") as? PlayerNamesViewController else { return }
            vc.currentLanguage = currentLanguage
            vc.delegate = self
            present(vc, animated: true, completion: nil)
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
    override func viewWillAppear(_ animated: Bool) {  //2
        super.viewWillAppear(true)
        
        winLabel.center.y -= view.bounds.height
        winnerLabel.center.y -= view.bounds.height
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
        playersMoveLabel.text = currentDirection == .white ? "Your move, \(playerWhite)" : "Your move, \(playerBlack)"
    }
    
    func delegateFunc(namePlayer1: String, namePlayer2: String) {
        playersMoveLabel.text = currentDirection == .white ? "Your move, \(namePlayer1)" : "Your move, \(namePlayer2)"
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
    
    func getStyleOfChekers() {
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
        var j = 0 //счетчик для тагов шашки
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
                checkers.tag = j
                j += 1
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
                        checkers.image = value.checkersColorTag ?? -1 < 12 ? UIImage(named: styleStyleCheker.blackChecker!) : UIImage(named: styleStyleCheker.whiteChecker!)
                        checkers.layer.cornerRadius = checkers.frame.size.width / 2
                        checkers.tag = value.checkersColorTag ?? -1
                        check.addSubview(checkers)
                        if value.lady == true {
                            let tiaraImage = UIImageView(frame: CGRect(x: 0, y: 0, width: Int(checkers.frame.width), height: Int(checkers.frame.height)))
                            tiaraImage.image = UIImage(named: "lady")
                            checkers.addSubview(tiaraImage)
                        }
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
                    position.lady = !checker.subviews.isEmpty ? true : false
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
    
    func getBackgroundGame() {
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.backgroundImage.rawValue)
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")),
              let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [SaveGame] else { return }
        
        for value in object {
            imageView.image = image ?? value.backgroundImage
        }
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
    
    func smartBorder(for checker: UIView) {
        
        board.subviews.forEach { cell in
            cell.addBorder(with: .clear, borderWidth: 3, cornerRadius: 0)
        }
        arrayIfCanFight.forEach { tuple in
            if checker.tag == tuple.checker {
                board.subviews.forEach { cell in
                    if cell.tag == tuple.cell {
                        cell.addBorder(with: .red, borderWidth: 3, cornerRadius: 0)
                    }
                }
            }
        }
    }
    
    func returnSmartBorder() {
        arrayIfCanFight.forEach { tuple in
            board.subviews.forEach { cell in
                if cell.tag == tuple.cell, cell.subviews.isEmpty {
                    cell.addBorder(with: .red, borderWidth: 3, cornerRadius: 0)
                }
            }
        }
    }
    
    func findFight() {
        let arrayOfChecker = saveArrayChekers()
        
        if currentDirection == .white {
            findFightForWhiteChecker(arrayOfChecker)
        } else {
            findFightForBlackChecker(arrayOfChecker)
        }
        returnSmartBorder()
    }
    
    func findFightForWhiteChecker(_ arrayOfChecker: [Checkers]) {
        var startCell: Int? = nil
        var checkerForFight: Checkers? = nil //шашка которую бьем
        var fight: Bool = false
        
        arrayOfChecker.forEach { checker in
            if checker.colorTag >= 12, checker.ladyStyle == false {
                
                startCell = checker.positionTag
                fight = true
            } else {
                if checker.colorTag >= 12, checker.ladyStyle == true {
                    findFightForWhiteLady(ladyChecker: checker, arrayOfChecker: arrayOfChecker)
                }
            }
            var noRepeat: Int? = nil
            while fight {
                fight = false
                arrayOfChecker.forEach { fightChecker in
                    
                    guard let startCell1 = startCell else { return }
                    
                    if fightChecker.colorTag < 12, fightChecker.positionTag != noRepeat && (fightChecker.positionTag == startCell1 + 9 || fightChecker.positionTag == startCell1 + 7 || fightChecker.positionTag == startCell1 - 9 || fightChecker.positionTag == startCell1 - 7 ) {
                        fight = false
                        checkerForFight = fightChecker
                        board.subviews.forEach { cell in
                            guard let checkerForFight = checkerForFight else { return }
                            if cell.subviews.isEmpty, cell.backgroundColor == .black, cell.tag == startCell1 - 2 * (startCell1 - fightChecker.positionTag) {
                                cell.addBorder(with: .red, borderWidth: 3, cornerRadius: 0)
                                fight = true
                                arrayCells.append(cell)
                                canFight = true
                                arrayIfCanFight.append((checker: checker.colorTag, cell: cell.tag, checkerBeaten: checkerForFight.colorTag))
                                //                                        print(mass)
                                noRepeat = checkerForFight.positionTag
                                startCell = cell.tag
                            }
                        }
                    }
                }
            }
            //                print(mass)
        }
    }
    
    func findFightForBlackChecker(_ arrayOfChecker: [Checkers]) {
        var startCell: Int? = nil
        var checkerForFight: Checkers? = nil //шашка которую бьем
        var fight: Bool = false
        
        arrayOfChecker.forEach { checker in
            
            if checker.colorTag < 12, checker.ladyStyle == false {
                    startCell = checker.positionTag
                    fight = true
            } else {
                if checker.colorTag < 12, checker.ladyStyle == true {
                    findFightForBlackLady(ladyChecker: checker, arrayOfChecker: arrayOfChecker)
                }
            }
            var noRepeat: Int? = nil
            while fight {
                fight = false
                arrayOfChecker.forEach { fightChecker in
                    
                    guard let startCell1 = startCell else { return }
                    
                    if fightChecker.colorTag >= 12, fightChecker.positionTag != noRepeat && (fightChecker.positionTag == startCell1 + 9 || fightChecker.positionTag == startCell1 + 7 || fightChecker.positionTag == startCell1 - 9 || fightChecker.positionTag == startCell1 - 7 ) {
                        
                        fight = false
                        checkerForFight = fightChecker
                        board.subviews.forEach { cell in
                            
                            guard let checkerForFight = checkerForFight else { return }
                            if cell.subviews.isEmpty, cell.backgroundColor == .black, cell.tag == startCell1 - 2 * (startCell1 - fightChecker.positionTag) {
                                
                                cell.addBorder(with: .red, borderWidth: 3, cornerRadius: 0)
                                fight = true
                                arrayCells.append(cell)
                                canFight = true
                                
                                arrayIfCanFight.append((checker: checker.colorTag, cell: cell.tag, checkerBeaten: checkerForFight.colorTag))
                                
                                noRepeat = checkerForFight.positionTag
                                
                                startCell = cell.tag
                            }
                        }
                    }
                }
            }
        }
    }
    
    func checkerIsLady() {
        let massCheckers = saveArrayChekers()
        var number: Int? = nil
        
        massCheckers.forEach { checker in
            guard checker.ladyStyle == false else { return }
            if (checker.colorTag < 12 && (checker.positionTag == 62 || checker.positionTag == 60 || checker.positionTag == 58 || checker.positionTag == 56)) || (checker.colorTag >= 12 && (checker.positionTag == 1 || checker.positionTag == 3 || checker.positionTag == 5 || checker.positionTag == 7)) {
                number = checker.positionTag
            }
        }
        
        if let cell = board.subviews.first(where:{$0.tag == number}) {
            cell.subviews.forEach { checker in
                let tiaraImage = UIImageView(frame: CGRect(x: 0, y: 0, width: Int(checker.frame.width), height: Int(checker.frame.height)))
                tiaraImage.image = UIImage(named: "lady")
                checker.addSubview(tiaraImage)
            }
        }
    }
    
    func saveArrayChekers() -> [Checkers] {
        arrayChekers = []
        
        board.subviews.forEach { cell in
            if !cell.subviews.isEmpty {
                cell.subviews.forEach { checker in
                    if !checker.subviews.isEmpty {
                        let saveChecker = Checkers(colorTag: checker.tag, positionTag: cell.tag, ladyStyle: true)
                        arrayChekers.append(saveChecker)
                    } else {
                        let saveChecker = Checkers(colorTag: checker.tag, positionTag: cell.tag, ladyStyle: false)
                        arrayChekers.append(saveChecker)
                    }
                }
            }
        }
        return arrayChekers
    }
    
    func moveChekers( checker: UIView) {
        
        guard checker.subviews.isEmpty else { ladyMove(for: checker)
            return }
        
        board.subviews.forEach { cell in
            guard cell.subviews.isEmpty, cell.backgroundColor == .black else {return}
            let newCurrentCell0 = checker.tag >= 12 ? checker.superview!.tag - 7 : checker.superview!.tag + 7
            let newCurrentCell1 = checker.tag >= 12 ? checker.superview!.tag - 9 : checker.superview!.tag + 9
            guard cell.tag == newCurrentCell0 || cell.tag == newCurrentCell1 else { return }
            cell.addBorder(with: .red, borderWidth: 3, cornerRadius: 0)
            arrayCells.append(cell)
        }
    }
    
    func ladyMove(for checker: UIView) {
        let cell = checker.superview
        
        let step1: Int = -7
        let step2: Int = -9
        let step3: Int = 7
        let step4: Int = 9
        
        board.subviews.forEach { firstCell in
            guard firstCell.subviews.isEmpty, firstCell.backgroundColor == .black,  let startCell = cell else { return }
            if firstCell.tag == startCell.tag - step1 || firstCell.tag == startCell.tag - step2 || firstCell.tag == startCell.tag - step3 || firstCell.tag == startCell.tag - step4 {
                firstCell.addBorder(with: .red, borderWidth: 3, cornerRadius: 0)
                arrayCells.append(firstCell)
                let step: Int = startCell.tag - firstCell.tag
                var nextCell: Int = firstCell.tag - step
                
                while nextCell > -1, nextCell < 64 {
                    var findNextCell: Bool = false
                    board.subviews.forEach { cell in
                        if cell.tag == nextCell, cell.subviews.isEmpty, cell.backgroundColor == .black {
                            cell.addBorder(with: .red, borderWidth: 3, cornerRadius: 0)
                            arrayCells.append(cell)
                            findNextCell = true
                            nextCell = nextCell - step
                        }
                    }
                    if findNextCell == false {
                        nextCell = 65
                    }
                }
            }
        }
    }
    
    func findFightForWhiteLady(ladyChecker: Checkers, arrayOfChecker: [Checkers]) {
        
        //var massForLady: [(lady: Int, checkerForFight: Int, cell: Int)] = []
        
        var a = ladyChecker.positionTag - 9
        var b = ladyChecker.positionTag - 7
        var c = ladyChecker.positionTag + 7
        var d = ladyChecker.positionTag + 9
        var noRepeatA: Bool = true
        var noRepeatB: Bool = true
        var noRepeatC: Bool = true
        var noRepeatD: Bool = true
        
        while a > 0 || b > 0 || c < 63 || d < 63 {
            
            arrayOfChecker.forEach { checkerForFight in
                if checkerForFight.colorTag < 12  && (checkerForFight.positionTag == a || checkerForFight.positionTag == b || checkerForFight.positionTag == c || checkerForFight.positionTag == d) {
                    var step: Int = 0
                    if (ladyChecker.positionTag - checkerForFight.positionTag) < 0, noRepeatB == true, (ladyChecker.positionTag - checkerForFight.positionTag) % 7 == 0 {
                        step = -7
                        noRepeatB = false
                    }
                    if (ladyChecker.positionTag - checkerForFight.positionTag) > 0, noRepeatC == true, (ladyChecker.positionTag - checkerForFight.positionTag) % 7 == 0 {
                        step = 7
                        noRepeatC = false
                    }
                    if (ladyChecker.positionTag - checkerForFight.positionTag) < 0, noRepeatA == true, (ladyChecker.positionTag - checkerForFight.positionTag) % 9 == 0 {
                        step = -9
                        noRepeatA = false
                    }
                    if (ladyChecker.positionTag - checkerForFight.positionTag) > 0, noRepeatD == true, (ladyChecker.positionTag - checkerForFight.positionTag) % 9 == 0 {
                        step = 9
                        noRepeatD = false
                    }
                    
                    board.subviews.forEach { cell in
                        
                        if cell.subviews.isEmpty, cell.backgroundColor == .black, cell.tag == checkerForFight.positionTag - step {
                            
                            
                            arrayCells.append(cell)
                            canFight = true
                            arrayIfCanFight.append((checker: ladyChecker.colorTag, cell: cell.tag, checkerBeaten: checkerForFight.colorTag))
                            //                            massForLady.append((lady: ladyChecker.colorTag!, checkerForFight: checkerForFight.colorTag!, cell: cell.tag))
                            
                            var nextCell: Int = cell.tag - step
                            
                            while nextCell > -1, nextCell < 64 {
                                var findNextCell: Bool = false
                                board.subviews.forEach { cell in
                                    if cell.tag == nextCell, cell.subviews.isEmpty, cell.backgroundColor == .black {
                                        cell.addBorder(with: .red, borderWidth: 3, cornerRadius: 0)
                                        arrayCells.append(cell)
                                        arrayIfCanFight.append((checker: ladyChecker.colorTag, cell: cell.tag, checkerBeaten: checkerForFight.colorTag))
                                        //                                        massForLady.append((lady: ladyChecker.colorTag!, checkerForFight: checkerForFight.colorTag!, cell: cell.tag))
                                        findNextCell = true
                                        nextCell = nextCell - step
                                    }
                                }
                                if findNextCell == false {
                                    nextCell = 65
                                }
                            }
                        }
                    }
                }
            }
            
            a -= 9
            b -= 7
            c += 7
            d += 9
        }
    }
    
    func findFightForBlackLady(ladyChecker: Checkers, arrayOfChecker: [Checkers]) {
        
        //var massForLady: [(lady: Int, checkerForFight: Int, cell: Int)] = []
        
        var a = ladyChecker.positionTag - 9
        var b = ladyChecker.positionTag - 7
        var c = ladyChecker.positionTag + 7
        var d = ladyChecker.positionTag + 9
        var noRepeatA: Bool = true
        var noRepeatB: Bool = true
        var noRepeatC: Bool = true
        var noRepeatD: Bool = true
        
        while a > 0 || b > 0 || c < 63 || d < 63 {
            
            arrayOfChecker.forEach { checkerForFight in
                if checkerForFight.colorTag >= 12  && (checkerForFight.positionTag == a || checkerForFight.positionTag == b || checkerForFight.positionTag == c || checkerForFight.positionTag == d) {
                    
                    var step: Int = 0
                    if (ladyChecker.positionTag - checkerForFight.positionTag) < 0, noRepeatB == true, (ladyChecker.positionTag - checkerForFight.positionTag) % 7 == 0 {
                        step = -7
                        noRepeatB = false
                    }
                    if (ladyChecker.positionTag - checkerForFight.positionTag) > 0, noRepeatC == true, (ladyChecker.positionTag - checkerForFight.positionTag) % 7 == 0 {
                        step = 7
                        noRepeatC = false
                    }
                    if (ladyChecker.positionTag - checkerForFight.positionTag) < 0, noRepeatA == true, (ladyChecker.positionTag - checkerForFight.positionTag) % 9 == 0 {
                        step = -9
                        noRepeatA = false
                    }
                    if (ladyChecker.positionTag - checkerForFight.positionTag) > 0, noRepeatD == true, (ladyChecker.positionTag - checkerForFight.positionTag) % 9 == 0 {
                        step = 9
                        noRepeatD = false
                    }
                    
                    board.subviews.forEach { cell in
                        
                        if cell.subviews.isEmpty, cell.backgroundColor == .black, cell.tag == checkerForFight.positionTag - step {
                            
                            arrayCells.append(cell)
                            canFight = true
                            arrayIfCanFight.append((checker: ladyChecker.colorTag, cell: cell.tag, checkerBeaten: checkerForFight.colorTag))
//                            massForLady.append((lady: ladyChecker.colorTag, checkerForFight: checkerForFight.colorTag, cell: cell.tag))
                            
                            var nextCell: Int = cell.tag - step
                            
                            while nextCell > -1, nextCell < 64 {
                                var findNextCell: Bool = false
                                board.subviews.forEach { cell in
                                    if cell.tag == nextCell, cell.subviews.isEmpty, cell.backgroundColor == .black {
                                        cell.addBorder(with: .red, borderWidth: 3, cornerRadius: 0)
                                        arrayCells.append(cell)
                                        arrayIfCanFight.append((checker: ladyChecker.colorTag, cell: cell.tag, checkerBeaten: checkerForFight.colorTag))
//                                        massForLady.append((lady: ladyChecker.colorTag!, checkerForFight: checkerForFight.colorTag!, cell: cell.tag))
                                        findNextCell = true
                                        nextCell = nextCell - step
                                    }
                                }
                                if findNextCell == false {
                                    nextCell = 65
                                }
                            }
                        }
                    }
                }
            }
            a -= 9
            b -= 7
            c += 7
            d += 9
        }
    }
    
    func win() {
        
        let winnerPlayer = winner()
        
        if winnerPlayer != "" {
            self.view.bringSubviewToFront(winLabel)
            self.view.bringSubviewToFront(winnerLabel)
            
            timer?.invalidate()
            timer = nil
            
            //winLabel.text = "congratulationsLabel_text".localized
            winLabel.textColor = .green
            winnerLabel.textColor = .green
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
                self.winLabel.center.y += self.view.bounds.height
            }
            //winnerLabel.text = winner + "winnerLabel_text".localized
            winnerLabel.text = "\(winnerPlayer), you have won!"
            CoreDataManager.shared.addNewResults(by: ResultsModel(data_m: dateLabel.text, winner_m: "\(winnerPlayer)", playerWhite_m: playerWhite, playerBlack_m: playerBlack))
            
            UIView.animate(withDuration: 2, delay: 0.3, options: .curveEaseOut) {
                self.winnerLabel.center.y += self.view.bounds.height
            }
        }
    }
    
    func winner() -> String {
        let checkers = saveArrayChekers()
        var blackCheckers: Int = 0
        var whiteCheckers: Int = 0
        var winner: String = ""
        
        checkers.forEach { checker in
            if checker.colorTag >= 12 {
                whiteCheckers += 1
            } else {
                blackCheckers += 1
            }
        }
        
        if whiteCheckers == 0 {
            winner = playerWhite
            //            let player1 = Player(name: playerWithWhiteChecker, colorOfChecker: "white", winner: false)
            //            let player2 = Player(name: playerWithBlackChecker, colorOfChecker: "black", winner: true)
            //            players.append(player1)
            //            players.append(player2)
            //            let coreDataDate = dateFormater.date(from: dateLabel.text ?? "")
            //            let play = Play(dateOfPlay: coreDataDate ?? Date(), players: players)
            //            CoreDataManager.shared.savePlay(by: play)
        }
        
        if blackCheckers == 0 {
            winner = playerBlack
            //            let player1 = Player(name: playerWithWhiteChecker, colorOfChecker: "white", winner: true)
            //            let player2 = Player(name: playerWithBlackChecker, colorOfChecker: "black", winner: false)
            //            players.append(player1)
            //            players.append(player2)
            //            let coreDataDate = dateFormater.date(from: dateLabel.text ?? "")
            //            let play = Play(dateOfPlay: coreDataDate ?? Date(), players: players)
            //            CoreDataManager.shared.savePlay(by: play)
        }
        
        if winner == "" {
            winner = checkerInWC(arrayOfCheckers: checkers)
        }
        
        return winner
    }
    
    func checkerInWC(arrayOfCheckers: [Checkers]) -> String {
        
        var winner: String = ""
        var allWhiteCheckers: [Checkers] = []
        var allBlackCheckers:[Checkers] = []
        
        arrayOfCheckers.forEach { checker in
            
            board.subviews.forEach { cell in
                if checker.colorTag >= 12, currentDirection == .white, cell.subviews.isEmpty, cell.backgroundColor == .black, (cell.tag == checker.positionTag - 7 ||  cell.tag == checker.positionTag - 9) {
                    allWhiteCheckers.append(checker)
                    
                }
                if checker.colorTag < 12, currentDirection == .black, cell.subviews.isEmpty, cell.backgroundColor == .black, (cell.tag == checker.positionTag + 7 ||  cell.tag == checker.positionTag + 9) {
                    allBlackCheckers.append(checker)
                    
                }
            }
        }
        
        if allWhiteCheckers.isEmpty, currentDirection == .white {
            winner = playerBlack
            //            let player1 = Player(name: playerWithWhiteChecker, colorOfChecker: "white", winner: false)
            //            let player2 = Player(name: playerWithBlackChecker, colorOfChecker: "black", winner: true)
            //            players.append(player1)
            //            players.append(player2)
            //            let coreDataDate = dateFormater.date(from: dateLabel.text ?? "")
            //            let play = Play(dateOfPlay: coreDataDate ?? Date(), players: players)
            //            CoreDataManager.shared.savePlay(by: play)
        }
        
        if allBlackCheckers.isEmpty, currentDirection == .black {
            winner = playerWhite
            //            let player1 = Player(name: playerWithWhiteChecker, colorOfChecker: "white", winner: true)
            //            let player2 = Player(name: playerWithBlackChecker, colorOfChecker: "black", winner: false)
            //            players.append(player1)
            //            players.append(player2)
            //            let coreDataDate = dateFormater.date(from: dateLabel.text ?? "")
            //            let play = Play(dateOfPlay: coreDataDate ?? Date(), players: players)
            //            CoreDataManager.shared.savePlay(by: play)
        }
        return winner
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
        guard let checker = sender.view, (currentDirection == .white && checker.tag >= 12) || (currentDirection == .black && checker.tag < 12) else { return }
        let location = sender.location(in: board)
        switch sender.state {
        case .began:
            smartBorder(for: checker)
            
            if canFight == false {
                arrayCells.removeAll()
                moveChekers(checker: checker)
            }
            UIImageView.animate(withDuration: 0.3) {
                checker.transform = checker.transform.scaledBy(x: 1.3, y: 1.3)
            }
        case .ended:
            UIImageView.animate(withDuration: 0.3) {
                checker.transform = .identity
            }
            if canFight == false {
                board.subviews.forEach { cell in
                    cell.addBorder(with: .clear, borderWidth: 3, cornerRadius: 0)
                }
            }
            
            returnSmartBorder() // чтобы опять появился блюр, если нужно бить, но просто подергали шашку
            var currentCell: UIView? = nil
            var beatenChecker: Int? = nil //шашка которую будем бить
            
            arrayCells.forEach { cell in
                if canFight == true {
                    if checker.subviews.isEmpty {
                        if let needTuple = arrayIfCanFight.first(where: {$0.checker == checker.tag}) {
                            if needTuple.cell == cell.tag, cell.frame.contains(location) {
                                currentCell = cell
                                beatenChecker = needTuple.checkerBeaten
                            }
                        }
                    } else {
                        arrayIfCanFight.forEach { tuple in
                            if checker.tag == tuple.checker, cell.tag == tuple.cell, cell.frame.contains(location) {
                                currentCell = cell
                                beatenChecker = tuple.checkerBeaten
                            }
                        }
                    }
                    
                } else {
                    if cell.frame.contains(location) {
                        currentCell = cell
                    }
                }
            }
            
            sender.view?.frame.origin = CGPoint(x: 5.0, y: 5.0)
            guard let newCell = currentCell, let cheker = sender.view else {return}
            newCell.addSubview(cheker)
            
            board.subviews.forEach { cell in
                cell.subviews.first(where: {$0.tag == beatenChecker})?.removeFromSuperview()
            }
            checkerIsLady()
            
            if !cheker.subviews.isEmpty {
                if canFight == true {
                    
                    canFight = false
                    arrayCells.removeAll()
                    arrayIfCanFight.removeAll()
                    smartBorder(for: cheker)
                    findFight()
        
                    if canFight == true {
                        
                        arrayIfCanFight.removeAll(where: {$0.checker != checker.tag })
                        smartBorder(for: checker)
                        if arrayIfCanFight.isEmpty {
                            canFight = false
                        }
                    }
                }
            } else {
                arrayIfCanFight.removeAll(where: {$0.checker != checker.tag })
                arrayIfCanFight.removeAll(where: {$0.cell == currentCell?.tag })
                
                if arrayIfCanFight.isEmpty {
                    canFight = false
                    smartBorder(for: checker)
                } else {
                    smartBorder(for: checker)
                    canFight = true
                }
            }
            
            
            //arrayCells.removeAll()
            if canFight == false {
                currentDirection = currentDirection == .white ? .black : .white
                findFight()
                writeNames()
                
                guard canFight == false else { return }
                win()
            }
        //currentDirection = currentDirection == .white ? .black : .white
        //getPlayerNames()
        
        //findFight()
        default: break
        }
    }
    
    @objc func panGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        guard let cheker = sender.view, (currentDirection == .white && cheker.tag >= 12) || (currentDirection == .black && cheker.tag < 12),
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
                                                //                                                CoreDataManager.shared.addNewResults(by: ResultsModel(data_m: self.dateLabel.text , playerWhite_m: self.playerWhite, playerBlack_m: self.playerBlack))
                                                self.navigationController?.popToRootViewController(animated: true)}),
                               UIAlertAction(title: "No", style: .cancel, handler: { _ in
                                                let fileURL = self.documentDirectory.appendingPathComponent(KeysUserDefaults.saveSellAndChecker.rawValue)
                                                //                                                let fileURL1 = self.documentDirectory.appendingPathComponent(KeysUserDefaults.checkers.rawValue)
                                                let fileURL2 = self.documentDirectory.appendingPathComponent(KeysUserDefaults.savePlayerNames.rawValue)
                                                try? FileManager.default.removeItem(at: fileURL)
                                                //                                                try? FileManager.default.removeItem(at: fileURL1)
                                                try? FileManager.default.removeItem(at: fileURL2)
                                                self.removeTimerFromUserDefaults()
                                                self.saveBackgroundGame()
                                                self.navigationController?.popToRootViewController(animated: true)}))
    }
}

extension GameViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer:UIGestureRecognizer) -> Bool {return true}
}
