//
//  CustomButton.swift
//  DZlesson15
//
//  Created by Янина on 12.10.21.
//

import UIKit

protocol CustomBattonDelegate: AnyObject {
    func buttonDidTap(_ sender: CustomButton)
}

@IBDesignable
class CustomButton: UIView {

    @IBOutlet weak var imageViewBack: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    @IBInspectable var cornerRadius: CGFloat {
        set { self.layer.cornerRadius = newValue }
        get { return self.layer.cornerRadius }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set { self.layer.borderWidth = newValue }
        get { return self.layer.borderWidth }
    }
    
    @IBInspectable var borderColor: UIColor {
        set { self.layer.borderColor = newValue.cgColor }
        get {
            if let cgColor = self.layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            
            return .clear
        }
    }
    
    @IBInspectable var text: String {
        set { self.backLabel.text = newValue }
        get { return self.backLabel.text ?? "" }
    }
    
    weak var delegate: CustomBattonDelegate?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setup()
    }
    private func setup() {
        Bundle.init(for: CustomButton.self).loadNibNamed("CustomButton", owner: self, options: nil)
        contentView.frame = self.bounds
        self.addSubview(contentView)
    }
    @IBAction func backButton(_ sender: UIButton) {
        delegate?.buttonDidTap(self)
    }
}
