//
//  UIView+CoreKit.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

extension UIView {
    func addShadow(with color: UIColor, opacity: Float, shadowOffset: CGSize = .zero) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = self.layer.cornerRadius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = shadowOffset
    }
}
