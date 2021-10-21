//
//  Chekers.swift
//  DZlesson15
//
//  Created by Янина on 28.08.21.
//

import UIKit
class Chekers: UIView, UIGestureRecognizerDelegate {
    
    var board: UIView!
    var cell: UIView!
    var checkers: UIImageView!
    
    func createChessboard(_ view: UIView, selector1: Selector, selector2: Selector ) {
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
                cell = UIView(frame: CGRect(x: CGFloat(sizeCheck) * CGFloat(column), y: CGFloat(sizeCheck) * CGFloat(row), width: CGFloat(sizeCheck), height: CGFloat(sizeCheck)))
                cell.backgroundColor = ((row + column) % 2 == 0) ? .white : .black
                cell.tag = count
                count += 1
                board.addSubview(cell)
            
                guard cell.backgroundColor == .black, row < 3 || row > 4 else {continue}
                
                checkers = UIImageView(frame: CGRect(x: 5, y: 5, width: sizeCheck - 10, height: sizeCheck - 10))
                checkers.clipsToBounds = true
                checkers.isUserInteractionEnabled = true
                checkers.tag = row < 3 ? 1 : 0
                checkers.image = row < 3 ? UIImage(named: "black") : UIImage(named: "white")
                checkers.layer.cornerRadius = checkers.frame.size.width / 2
                cell.addSubview(checkers)
                let longPress = UILongPressGestureRecognizer(target: self, action: selector1)
                longPress.minimumPressDuration = 0.2
                longPress.delegate = self
                checkers.addGestureRecognizer(longPress)
                let pan = UIPanGestureRecognizer(target: self, action: selector2)
                pan.delegate = self
                checkers.addGestureRecognizer(pan)
                
            }
        }
    }
}
    
    
    
    
    


