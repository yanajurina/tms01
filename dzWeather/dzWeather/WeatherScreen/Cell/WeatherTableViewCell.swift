//
//  WeatherTableViewCell.swift
//  dzWeather
//
//  Created by Янина on 12.09.21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var propertiesLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        propertiesLabel.text = ""
        valueLabel.text = ""
    }
    
}
