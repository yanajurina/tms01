//
//  GameViewController.swift
//  tmsDZlesson12
//
//  Created by Янина on 21.07.21.
//

import UIKit

class GameViewController: UIViewController {
    
    enum DirectionCheckers {
        case white, black
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var buttonStop: UIButton!
    
    var board: UIView!
    var checkers: UIImageView!
    var timer: Timer?
    var countTickSekonds1: Int = 0
    var countTickSekonds2: Int = 0
    var countTickMinutes1: Int = 0
    var countTickMinutes2: Int = 0
    var labelTimer: UILabel!
    var isLongPress: Bool = false
    var currentDirection: DirectionCheckers = .white
    var stepCount: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTimer()
        
        let textTimerLabel = "\(countTickMinutes2)\(countTickMinutes1):\(countTickSekonds2)\(countTickSekonds1)"
        let attribut = NSMutableAttributedString(string: "\(textTimerLabel)", attributes: [
                                                                               .font: UIFont(name: "Anton-Regular", size: 40)
                                                                                ?? UIFont.systemFont(ofSize: 20.0),
                                                                               .foregroundColor: UIColor.orange
        ])
        var attr: [NSMutableAttributedString.Key: Any] = [.font: UIFont(name: "Anton-Regular", size: 40)
                                                    ?? UIFont.systemFont(ofSize: 20.0),
                                                   .foregroundColor: UIColor.orange]
        let attributesStop = NSMutableAttributedString(string: "Stop")
        attributesStop.addAttributes(attr, range: NSRange(location: 0, length: 3))
        attr[.font] = UIFont(name: "Anton-Regular", size: 10)
        attr[.foregroundColor] = UIColor.orange
        attributesStop.addAttributes(attr, range: NSRange(location: 0, length: 3))
    
        timerLabel.attributedText = attribut
          
        buttonStop.setAttributedTitle(NSAttributedString(string: "Stop"), for: .application)
        buttonStop.layer.cornerRadius = buttonStop.frame.size.width / 4
        buttonStop.addShadow(with: .green, opacity: 3, shadowOffset: .zero)
        buttonStop.titleLabel?.attributedText = attributesStop
    
        


        let size = view.bounds.size.width - 32
        board = UIView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        board.backgroundColor = .white
        board.center = view.center
        board.addShadow(with: .black, opacity: 0.8, shadowOffset: CGSize(width: 10, height: 10))
        view.addSubview(board)

        let sizeCheck = size / 8
        
        for row in 0...7 {
            for column in 0...7 {
                let check = UIView(frame: CGRect(x: CGFloat(sizeCheck) * CGFloat(column), y: CGFloat(sizeCheck) * CGFloat(row), width: CGFloat(sizeCheck), height: CGFloat(sizeCheck)))
                check.backgroundColor = ((row + column) % 2 == 0) ? .white : .black
                board.addSubview(check)
                
                guard check.backgroundColor == .black, row < 3 || row > 4 else {continue}
                
                checkers = UIImageView(frame: CGRect(x: 5, y: 5, width: sizeCheck - 10, height: sizeCheck - 10))
                checkers.image = UIImage(named: "red")
                if row < 3 {
                    check.addSubview(checkers)
                } else {
                    checkers.image = UIImage(named: "white")
                    check.addSubview(checkers)
                }
                checkers.layer.cornerRadius = checkers.frame.size.width / 2
                checkers.tag = row < 3 ? 0 : 1
                checkers.isUserInteractionEnabled = true
                
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
    
    
    func initTimer() {
        countTickSekonds1 = 0
        countTickSekonds2 = 0
        countTickMinutes1 = 0
        countTickMinutes2 = 0
        timer = Timer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    @objc func timerFunc() {
        countTickSekonds1 += 1
        if countTickSekonds1 > 9 {
            countTickSekonds1 = 0
            countTickSekonds2 += 1
        }
         if countTickMinutes1 > 9 {
            countTickMinutes1 = 0
            countTickMinutes2 += 1
        }
        if countTickSekonds2 == 6 && countTickSekonds1 == 0 {
            countTickSekonds1 = 0
            countTickSekonds2 = 0
            countTickMinutes1 += 1
        }
        if countTickSekonds2 == 6 && countTickSekonds1 == 0 && countTickMinutes1 > 9 {
            countTickSekonds1 = 0
            countTickSekonds2 = 0
            countTickMinutes1 = 0
            countTickMinutes2 += 1
        }

        timerLabel.text = "\(countTickMinutes2)\(countTickMinutes1):\(countTickSekonds2)\(countTickSekonds1)"
    }
    
    @objc func longPressRecognizer(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            UIImageView.animate(withDuration: 0.3) {
                sender.view?.transform = self.checkers.transform.scaledBy(x: 1.3, y: 1.3)
                }
        case .ended:
            UIImageView.animate(withDuration: 0.3) {
                sender.view?.transform = .identity
            }
        default: break
        }
    }
    
    
   @objc func panGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: board)
        let translation = sender.translation(in: board)

        switch sender.state {
        case .changed:
            guard let column = sender.view?.superview, let cellOrigin = sender.view?.frame.origin else { return }
            board.bringSubviewToFront(column)
            sender.view?.frame.origin = CGPoint(x: cellOrigin.x + translation.x,
                                                y: cellOrigin.y + translation.y)
            sender.setTranslation(.zero, in: board)
        case .ended:
            UIImageView.animate(withDuration: 0.3) {
                sender.view?.transform = .identity
            }
            let currentCell = board.subviews.first(where: {$0.frame.contains(location) && $0.backgroundColor == .black })
            
            sender.view?.frame.origin = CGPoint(x: 5.0, y: 5.0)
            guard let newCell = currentCell, newCell.subviews.isEmpty, let cell = sender.view else {return}
            currentCell?.addSubview(cell)
            
        default: break
        }
    }
    
    @IBAction func stopButton(_ sender: Any) {
        timer?.invalidate()
        initTimer()
    }
}
    
    extension GameViewController: UIGestureRecognizerDelegate {
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith
                                otherGestureRecognizer:UIGestureRecognizer) -> Bool {return true}
    }

