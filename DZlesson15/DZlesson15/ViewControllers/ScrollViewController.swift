//
//  ScrollViewController.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

class ScrollViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backSettings(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
