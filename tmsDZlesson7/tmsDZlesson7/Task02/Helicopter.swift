//
//  Helicopter.swift
//  tmsDZlesson7
//
//  Created by Янина on 3.07.21.
//

import Foundation

class Helicopter: Transport {
    override init(speed: Float, capacity: Float, costOfOneKilometer: Float) {
        super.init(speed: speed, capacity: capacity, costOfOneKilometer: costOfOneKilometer)
    }

    override func transportation(numberOfPeople: Int, numberOfKilo: Float) {
        let t = numberOfKilo / self.speed
        let c = numberOfKilo * self.costOfOneKilometer
        let n = Float(numberOfPeople) / self.capacity
       
        print("Transportation by Helicopter")
        print("Time for transportation - \(t)")
        print("Ttransportation cost - \(c)")
        print("Number for trans - \(n)")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}


