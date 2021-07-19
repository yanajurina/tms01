//
//  ViewController.swift
//  tmsDZlesson10
//
//  Created by Янина on 17.07.21.
//

import UIKit

class ViewController: UIViewController {
    
    var viewSquareBlack: [UIView] = []
    var viewSquareWhite: [UIView] = []
    var viewChessAll: [UIView] = []
    var chessMove: UIView? = nil
    var dafaultOrignl: CGPoint = .zero
    var selecField: CGPoint = .zero
    var count: Int = 0
    
     override func viewDidLoad() {
          super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        let view320: UIView = UIView(frame: CGRect(x: 40.0, y: 40.0, width: 320.0, height: 320.0))
        view320.backgroundColor = .yellow
        view.addSubview(view320)
     
        for i in 0...7 {
            for j in 0...7 {
                let viewSquare: UIView = UIView(frame: CGRect(x: (40.0 * Double(i)) + 40, y: (40.0 * Double(j)) + 40, width: 40.0, height: 40.0))
                view.addSubview(viewSquare)
                let chess: UIView = UIView(frame: CGRect(x: (40.0 * Double(i)) + 50, y: (40.0 * Double(j)) + 50, width: 20.0, height: 20.0))
                 if (i + j) % 2 != 0 {
                    viewSquare.backgroundColor = .black
                    viewSquareBlack.append(viewSquare)
                    switch  j {
                    case 0...2 :
                        chess.backgroundColor = .gray
                        view.addSubview(chess)
                        viewChessAll.append(chess)
                        addPanGesture(chess)
                    case 5...7 :
                        chess.backgroundColor = .white
                        view.addSubview(chess)
                        viewChessAll.append(chess)
                        addPanGesture(chess)
                    default:
                        break
                    }
                } else {
                    viewSquare.backgroundColor = .white
                    viewSquareWhite.append(viewSquare)
                }
            }
         }
     }
     
    func addPanGesture(_ chess: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer(_ :)))
        chess.addGestureRecognizer(panGesture)
     }
    
     @objc func panGestureRecognizer (_ sender: UIPanGestureRecognizer) {
       
          let translation = sender.translation(in: view)
        
          switch sender.state {
          case .began:
               guard let senderView  = sender.view else {return}
               chessMove = senderView
               dafaultOrignl = senderView.frame.origin
          case .changed:
               guard chessMove  != nil else { return}
               chessMove?.frame.origin = CGPoint(x: dafaultOrignl.x + translation.x , y:  dafaultOrignl.y + translation.y)
               view.bringSubviewToFront(chessMove!)
          case .ended:
               for value in viewSquareBlack {
                    if value.frame.contains(chessMove!.frame.origin) {
                         chessMove!.center.x = value.center.x
                         chessMove!.center.y  = value.center.y
                         count = 0
                         viewChessAll.forEach { value in
                              if chessMove!.frame == value.frame {
                                   count += 1
                              }
                              if count == 2 {
                                   chessMove!.frame.origin = dafaultOrignl
                              }
                         }
                    }
                    viewSquareWhite.forEach { value in
                         if value.frame.contains(chessMove!.frame.origin) {
                              chessMove!.frame.origin = dafaultOrignl
                         }
                    }
               }
            sender.setTranslation(.zero, in: view)
              default:
                break
          }
     }
     
     
    
}




