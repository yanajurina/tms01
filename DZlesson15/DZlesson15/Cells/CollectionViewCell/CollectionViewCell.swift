//
//  CollectionViewCell.swift
//  DZlesson15
//
//  Created by Янина on 5.10.21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var selectLabel: UILabel!
    
    var isClick = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setupSelectLabel()
    }
    
    func setupSelectLabel() {
        guard isClick else { return }
        selectLabel.text = selectLabel.text == "Selected" ? "Select" : "Selected"
    }
    
    @IBAction func selectButton(_ sender: UIButton) {
        isClick = true
        selectLabel.text = "Selected"
    }
    
}
