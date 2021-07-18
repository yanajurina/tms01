//
//  ViewController.swift
//  tmsDZlesson11
//
//  Created by Янина on 18.07.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for value in buttons {
            value.layer.cornerRadius = value.frame.size.width / 2.0
        }
        button.layer.cornerRadius = button.frame.size.width / 4.5
        
        
        
        
    }


}

