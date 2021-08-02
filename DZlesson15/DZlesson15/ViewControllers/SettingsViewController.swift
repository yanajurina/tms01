//
//  SettingsViewController.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad() 
    }

    @IBAction func aboutButton(_ sender: Any) {
        self.navigationController?.pushViewController(getViewController(from: "Scroll"), animated: true)
    }
}
