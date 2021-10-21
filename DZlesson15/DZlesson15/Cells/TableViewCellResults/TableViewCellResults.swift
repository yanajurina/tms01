//
//  TableViewCellResults.swift
//  DZlesson15
//
//  Created by Янина on 18.10.21.
//

import UIKit

class TableViewCellResults: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var whiteLabel: UILabel!
    @IBOutlet weak var blackLabel: UILabel!
    @IBOutlet weak var whitePlayer: UILabel!
    @IBOutlet weak var blackPlayer: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    override func prepareForReuse() {
        dataLabel.text = ""
        whiteLabel.text = "White"
        blackLabel.text = "Black"
        whitePlayer.text = ""
        blackPlayer.text = ""
        winnerLabel.text = ""
    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
}
