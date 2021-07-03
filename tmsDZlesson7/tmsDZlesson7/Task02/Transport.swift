//
//  Vehicle.swift
//  tmsDZlesson7
//
//  Created by Янина on 3.07.21.
//

import Foundation

class Transport {
    
    var speed: Float
    var capacity: Float
    var costOfOneKilometer: Float
    
    init(speed: Float, capacity: Float, costOfOneKilometer: Float) {
        self.speed = speed
        self.capacity = capacity
        self.costOfOneKilometer = costOfOneKilometer
    }
    
    
    func transportation (numberOfPeople: Int, numberOfKilo: Float) {
//        как быстро
        let t = numberOfKilo / self.speed
//        стоимость перевозки
        let c = numberOfKilo * self.costOfOneKilometer
//        количество трансп средств
        let n = Float(numberOfPeople) / self.capacity
       
        print("Transportation by Transport")
        print("Time for transportation - \(t)")
        print("Ttransportation cost - \(c)")
        print("Number for trans - \(n)")
    }
    
    
    
    
    
    
    
    
    
}









