//
//  CellTableView.swift
//  DZlesson16
//
//  Created by Янина on 7.08.21.
//

import UIKit

class CellTableView: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setData (whith colorName: ColorNameClass) {
        label.text = colorName.name
        label.textColor = colorName.color
    }
    
    func setDataStudents (whith students: Students) {
        namelabel.text = students.name
        label.text = "\(students.range)"
    }
    
    override func prepareForReuse() {
        label.text = ""
        label.textColor = nil
        namelabel.text = ""
    }
    
}
