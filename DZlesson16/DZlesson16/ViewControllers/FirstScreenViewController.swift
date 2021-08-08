//
//  FirstScreenViewController.swift
//  DZlesson16
//
//  Created by Янина on 8.08.21.
//

import UIKit

class FirstScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonRGB(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "RGB", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func buttonStudents(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Students", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        navigationController?.pushViewController(vc!, animated: true)
    }
}
