//
//  UIViewController + Storyboard.swift
//  dzWeather
//
//  Created by Янина on 28.11.21.
//

import UIKit

extension UIViewController {
    static func getViewController(by identifier: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        return storyboard.instantiateInitialViewController()
    }
}
