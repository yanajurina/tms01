//
//  UIViewController+CoreKit.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

extension UIViewController {
    
    func getViewController (from nameStoryboard: String?) -> UIViewController {
        let storyboard = UIStoryboard.init(name: nameStoryboard!, bundle: nil)
        let currentViewController = storyboard.instantiateInitialViewController()
        return currentViewController!
    }

@IBAction func back(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: true)
    }
    
}
