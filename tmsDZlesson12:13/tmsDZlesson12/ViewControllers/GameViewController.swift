//
//  GameViewController.swift
//  tmsDZlesson12
//
//  Created by Янина on 21.07.21.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var buttonStop: UIButton!
    
    var board: UIView!
    var checkers: UIImageView!
    var timer: Timer?
    var countTick: Int = 0
    var labelTimer: UILabel!
    var isLongPress: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonStop.layer.cornerRadius = buttonStop.frame.size.width / 4
    
        initTimer()
        timerLabel.text = "\(countTick)"

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
                checkers.isUserInteractionEnabled = true
                
                let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressRecognizer(_:)))
                longPress.minimumPressDuration = 0.1
                longPress.delegate = self
                checkers.addGestureRecognizer(longPress)
                
                let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer(_:)))
                pan.delegate = self
                checkers.addGestureRecognizer(pan)
            }
        }
    }
    
    
    func initTimer() {
        countTick = 0
        timer = Timer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    @objc func timerFunc() {
        countTick += 1
        timerLabel.text = "\(countTick)"
    }
    
    @objc func longPressRecognizer(_ sender: UILongPressGestureRecognizer) {
        guard !isLongPress else {return}
        isLongPress = true
        UIImageView.animate(withDuration: 0.3) {
            sender.view?.transform = self.checkers.transform.scaledBy(x: 1.3, y: 1.3)
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
            isLongPress = false
            let currentCell = board.subviews.first(where: {$0.frame.contains(location) && $0.backgroundColor == .black })
            
            sender.view?.frame.origin = CGPoint(x: 5.0, y: 5.0)
            guard let newCell = currentCell, newCell.subviews.isEmpty, let cell = sender.view else {return}
            currentCell?.addSubview(cell)
        default: break
        }
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        timer?.invalidate()
        initTimer()
    }
}

extension GameViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
