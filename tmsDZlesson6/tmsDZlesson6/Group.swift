//
//  Group.swift
//  tmsDZlesson6
//
//  Created by Янина on 30.06.21.
//

import Foundation

class Group {
    
    var nameOfGroup: String
    var students: [Student]
    
    init(nameOfGroup: String, students: [Student]) {
        self.nameOfGroup = nameOfGroup
        self.students = students
    }
    
    
    func studOfGr () {
        for student in self.students {
            print("\(nameOfGroup): Student \(student.firstName) \(student.lastName), date of birth \(student.yearOfBirth), average score \(student.averageScore)")
        }
        return
    }
    
    
    
    func studOfGrBest () {
        var index = students.count - 1
        while index > -1 {
            if self.students[index].averageScore < 9 {
                self.students.remove(at: index)
            }
            index -= 1
        }
        studOfGr()
        return
    }
    


            
            
            
            
            
            
            


}
