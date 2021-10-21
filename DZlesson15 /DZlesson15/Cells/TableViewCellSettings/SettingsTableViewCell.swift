//
//  SettingsTableViewCell.swift
//  DZlesson15
//
//  Created by Янина on 29.08.21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var labelSettings: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        labelSettings.text = ""
    }
}
