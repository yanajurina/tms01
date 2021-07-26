//
//  UIView+CoreKit.swift
//  tmsDZlesson12
//
//  Created by Янина on 26.07.21.
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
