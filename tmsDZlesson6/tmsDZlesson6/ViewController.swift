//
//  ViewController.swift
//  tmsDZlesson6
//
//  Created by Янина on 30.06.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let student1: Student = Student (firstName: "Irina",
                                         lastName: "Ivanova",
                                         yearOfBirth: "05.10.1993",
                                         averageScore: 8)
        
        let student2: Student = Student (firstName: "Sergey",
                                         lastName: "Petrov",
                                         yearOfBirth: "10.02.1992",
                                         averageScore: 10)
        
        let student3: Student = Student (firstName: "Katya",
                                         lastName: "Ivanova",
                                         yearOfBirth: "06.05.1993",
                                         averageScore: 5)
        
        let groupOfStudent = Group (nameOfGroup: "Group 1", students: [student1, student2, student3])
        
        
        print ("Metoth1")
        groupOfStudent.studOfGr()
        
        print ("Metoth2")
        groupOfStudent.studOfGrBest()
        
        
         
        
        
        
        
        
        
        
        
        
        
    }


}

