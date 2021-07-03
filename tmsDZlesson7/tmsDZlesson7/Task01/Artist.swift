//
//  Artist.swift
//  tmsDZlesson7
//
//  Created by Янина on 3.07.21.
//

import Foundation

class Artist {
    
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String ) {
        self.firstName = firstName
        self.lastName = lastName
        
    }

    func performance() {
        print("ARTIST \(self.firstName) \(self.lastName)")
        print("PERFORMANCE")
    }



}

















