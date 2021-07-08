//
//  ViewController.swift
//  tmsDZlesson8.2
//
//  Created by Янина on 8.07.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        
        let colors:[UIColor] = [UIColor.white, UIColor.black,UIColor.white, UIColor.black,UIColor.white, UIColor.black,UIColor.white, UIColor.black]
        
        for value in 0..<colors.count {
            let newView = UIView (frame: CGRect(x: 35.0,
                                                y: 40.0 * Double(value + 5),
                                                width: 40, height: 40))
            newView.backgroundColor = colors[value]
            view.addSubview(newView)
        }
        for value in 0..<colors.count {
            let newView = UIView (frame: CGRect(x: 75.0,
                                                y: 40.0 * Double(value + 5),
                                                width: 40, height: 40))
            let a = (colors.count - 1) - value
            newView.backgroundColor = colors[a]
            view.addSubview(newView)
        }
        
        for value in 0..<colors.count {
            let newView = UIView (frame: CGRect(x: 115.0,
                                                y: 40.0 * Double(value + 5),
                                                width: 40, height: 40))
            newView.backgroundColor = colors[value]
            view.addSubview(newView)
        }
        
        for value in 0..<colors.count {
            let newView = UIView (frame: CGRect(x: 155.0,
                                                y: 40.0 * Double(value + 5),
                                                width: 40, height: 40))
            let a = (colors.count - 1) - value
            newView.backgroundColor = colors[a]
            view.addSubview(newView)
        }
        for value in 0..<colors.count {
            let newView = UIView (frame: CGRect(x: 195.0,
                                                y: 40.0 * Double(value + 5),
                                                width: 40, height: 40))
            newView.backgroundColor = colors[value]
            view.addSubview(newView)
        }
        for value in 0..<colors.count {
            let newView = UIView (frame: CGRect(x: 235.0,
                                                y: 40.0 * Double(value + 5),
                                                width: 40, height: 40))
            let a = (colors.count - 1) - value
            newView.backgroundColor = colors[a]
            view.addSubview(newView)
        }
        for value in 0..<colors.count {
            let newView = UIView (frame: CGRect(x: 275.0,
                                                y: 40.0 * Double(value + 5),
                                                width: 40, height: 40))
            newView.backgroundColor = colors[value]
            view.addSubview(newView)
        }
        for value in 0..<colors.count {
            let newView = UIView (frame: CGRect(x: 315.0,
                                                y: 40.0 * Double(value + 5),
                                                width: 40, height: 40))
            let a = (colors.count - 1) - value
            newView.backgroundColor = colors[a]
            view.addSubview(newView)
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }


}

