//
//  ViewController.swift
//  tmsDZlesson8.3
//
//  Created by Янина on 8.07.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let textField1 = UITextField(frame: CGRect(x: 100.0, y: 200.0, width: 200.0, height: 50.0))
        textField1.backgroundColor = .white
        view.addSubview(textField1)
        
        let textField2 = UITextField(frame: CGRect(x: 100.0, y: 300.0, width: 200.0, height: 50.0))
        textField2.backgroundColor = .white
        view.addSubview(textField2)
        
        let label1 = UILabel(frame: CGRect(x: 200.0, y: 225.0, width: 100.0, height: 100.0))
        label1.text = "+"
        view.addSubview(label1)
  
        let button = UIButton(frame: CGRect(x: 200.0, y: 350.0, width: 50.0, height: 50.0))
        let label2 = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        label2.text = "="
        button.addSubview(label2)
        view.addSubview(button)
        
        let label3 = UILabel(frame:CGRect(x: 150, y: 450, width: 100.0, height: 50.0))
        label3.backgroundColor = .white
        view.addSubview(label3)
        
        
//        var sum = 0
//        if let text1 = myTextField1.text, !text1.isEmpty {
//            if let text2 = myTextField2.text, !text2.isEmpty {
//                if Int(text1) != nil && Int(text2) != nil {
//                    sum = Int(text1)! + Int(text2)!
//                    myLabel.text?.removeAll()
//                    myLabel.text?.append("\(sum)")
//                } else {
//                    myLabel.text?.removeAll()
//                    myLabel.text?.append("error")
//                }
//            } else {
//                myLabel.text?.removeAll()
//                myLabel.text?.append("error")
//            }
//        } else {
//            myLabel.text?.removeAll()
//            myLabel.text?.append("error")
//        }
//    }
        
        
        
        
        
        
        
        
    }


}

