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
    
    func addBorder(with borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}
