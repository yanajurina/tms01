//
//  Painter.swift
//  tmsDZlesson7
//
//  Created by Янина on 3.07.21.
//

import Foundation

class Paiter: Artist {
    
    var artisticName: String
    
    init(artisticName: String, firstName: String, lastName: String) {
          self.artisticName = artisticName
          super.init(firstName: firstName, lastName: lastName)
    }
    
    
    override func performance() {
        print("ARTIST \(self.artisticName)")
    }
    

}

