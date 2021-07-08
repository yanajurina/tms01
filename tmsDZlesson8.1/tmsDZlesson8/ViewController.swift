//
//  ViewController.swift
//  tmsDZlesson8
//
//  Created by Янина on 7.07.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myTextField1: UITextField!
    @IBOutlet weak var myTextField2: UITextField!
 
    @IBAction func myButtonAction(_ sender: UIButton) {
        var sum = 0
        if let text1 = myTextField1.text, !text1.isEmpty {
            if let text2 = myTextField2.text, !text2.isEmpty {
                if Int(text1) != nil && Int(text2) != nil {
                    sum = Int(text1)! + Int(text2)!
                    myLabel.text?.removeAll()
                    myLabel.text?.append("\(sum)")
                } else {
                    myLabel.text?.removeAll()
                    myLabel.text?.append("error")
                }
            } else {
                myLabel.text?.removeAll()
                myLabel.text?.append("error")
            }
        } else {
            myLabel.text?.removeAll()
            myLabel.text?.append("error")
        }
    }
    
    @IBOutlet weak var myLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        
        
    }


}

