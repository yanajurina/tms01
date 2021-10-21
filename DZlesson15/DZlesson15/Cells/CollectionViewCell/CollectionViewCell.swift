//
//  CollectionViewCell.swift
//  DZlesson15
//
//  Created by Янина on 5.10.21.
//

import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func switchDidTap(_ sender: UISwitch)
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var checkerSwitch: UISwitch!
    
    weak var delegate: CollectionViewCellDelegate?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkerSwitch.onTintColor = .systemPink

    }
    func setData(with data: StyleChecker) {
        image1.image = UIImage(named: data.whiteChecker ?? "")
        image2.image = UIImage(named: data.blackChecker ?? "")
        checkerSwitch.setOn(data.stateSwitch, animated: true)
    }
    
    override func prepareForReuse() {
        image1.image = nil
        image2.image = nil
    }
   
    @IBAction func actionSwitch(_ sender: UISwitch) {
        delegate?.switchDidTap(checkerSwitch)
    }
    
}
