//
//  ViewController.swift
//  tmsDZlesson7
//
//  Created by Янина on 2.07.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Task01")
        
        let dancer: Dancer = Dancer.init(firstName: "Pol", lastName: "Petersen")
        let singer: Singer = Singer.init(firstName: "Joze", lastName: "Dyala")
        let painter: Paiter = Paiter.init(artisticName: "Big Boss", firstName: "Stive", lastName: "Stivens")
        
        let allArtists: [Artist] = [dancer, singer, painter]
        
        for artist in allArtists {
            artist.performance()
        }
        
        
        
        print("Task02")
        
        
        let car: Car = Car.init(speed: 120, capacity: 3, costOfOneKilometer: 5)
        let plane: Plane = Plane.init(speed: 1000, capacity: 500, costOfOneKilometer: 2000)
        let ship: Ship = Ship.init(speed: 3000, capacity: 2000, costOfOneKilometer: 5000)
        let helicopter: Helicopter = Helicopter.init(speed: 350, capacity: 6, costOfOneKilometer: 500)
        
        let trans: [Transport] = [car, plane, ship, helicopter]
        
        for value in trans {
            value.transportation(numberOfPeople: 160, numberOfKilo: 870)
            
        }
        
        
        print("Task03")
        
        
        let human01: People = People.init(activeOrganism: true, numbOfLegs: 1)
        let human02: People = People.init(activeOrganism: true, numbOfLegs: 2)
        let crocodile01: Crocodiles = Crocodiles.init(activeOrganism: true, numbOfLegs: 4)
        let monkey01: Monkeys = Monkeys.init(activeOrganism: true, numbOfLegs: 2)
        let monkey02: Monkeys = Monkeys.init(activeOrganism: true, numbOfLegs: 2)
        let dog01: Dogs = Dogs.init(activeOrganism: true, numbOfLegs: 4)
        let dog02: Dogs = Dogs.init(activeOrganism: true, numbOfLegs: 4)
        let giraffe: Giraffes = Giraffes.init(activeOrganism: true, numbOfLegs: 4)
        
        let organismsOfPlanet: [InhabitantsOfThePlanet] = [human01, human02, crocodile01, monkey01, monkey02, dog01, dog02, giraffe]
        
        var countFourLegs = 0
        var countAnimal = 0
        var countActiveOrganism = 0
        
        for organism in organismsOfPlanet {
            if organism.numbOfLegs == 4 {
                countFourLegs += 1
            }
            if let _ = organism as? Animals {
                countAnimal += 1
            }
            if organism.activeOrganism == true {
                countActiveOrganism += 1
            }
            
        }
        
        print("Number of tetrapods is \(countFourLegs)")
        print("Number of animal is \(countAnimal)")
        print("Number of living organisms is \(countActiveOrganism)")
            
            
            
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
            
      }
        
        
        
    }


