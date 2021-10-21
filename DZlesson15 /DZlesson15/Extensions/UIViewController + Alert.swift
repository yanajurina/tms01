//
//  UIViewController+Alert.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

extension UIViewController {
    @discardableResult
    func presentAlertController ( _ title: String?, message: String?, useTextField: Bool = false, preferredStyle: UIAlertController.Style = .alert, actions: UIAlertAction...) -> UIAlertController {
        
        let alert = UIAlertController (title: title, message: message, preferredStyle: preferredStyle)
//        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        if useTextField, preferredStyle == .alert { alert.addTextField { _ in } }
        
        actions.forEach {alert.addAction($0)}
//        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
        return alert
    }
}
