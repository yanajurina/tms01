//
//  UIViewController+CoreKit.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

extension UIViewController {

    func getViewController (from nameStoryboard: String?) -> UIViewController {
        let storyboard = UIStoryboard(name: nameStoryboard!, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        return vc!
    }

@IBAction func back(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: true)
    }
    
}
