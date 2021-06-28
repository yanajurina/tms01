//
//  ViewController.swift
//  tmsDZlesson5
//
//  Created by Янина on 25.06.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
//Task 1
        print("Task 1")
        
        let englishAlph = "abcdefghigklmnopqrstuvwxyz"
        let oneLett = "f"
        
        for (index, value) in englishAlph.enumerated() {
            print ("индекс \(index), значение \(value)")
            if index == 5 {
                print ("значение \(oneLett) находится под индексом \(index)")
                break
            }
        }
        
//Task 2
        print("Task 2")
        
        let massDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        var numMonth = 1
        
        for value in massDaysInMonth {
            print("month \(numMonth) - \(value) days")
            numMonth += 1
        }
    
        
        let massNameOfMonth = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        var massDaysInMonth0 = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        for value in massNameOfMonth {
            print("\(value) \(massDaysInMonth0[0])")
            massDaysInMonth0.remove(at: 0)
        }
       
        let _:[Any] = [("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"), (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)]
        
        
        
     
//Task 3
        print("Task 3")
        
        let str = "abcdefghigklmnopqrstuvwxyz"
        var massStr: [String] = []
        for lett in str {
            massStr.insert(String(lett), at: 0)
        }
        print(massStr)
        
        
//Task 4
        print("Task 4")
        
        let strChar: String = "hj00y?y\\8bj@889hvfdhj00y?y\\8bj@889hvfdhj00y?y\\8bj@889hv+fdhj00y?y\\8bj@88**9hvfdhj00y?y\\8bj@889hvfdvy\\8bj@889hvfdhj00y?y\\8bj@889hvfdhj00y?y\\8bj@889hvfdhj00y?y\\8bj@889hvfdhj00y?y\\8bj@889hvfdhj00y?y\\ds77&fgh%%%000pfdhj00y?"
        
        var sum01 = 0
        var sum02 = 0
        var sum03 = 0
        
        for value in strChar {
            switch value {
            case "a"..."z":
                sum01 += 1
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                sum02 += 1
            default:
                sum03 += 1
            }
        }
        print("Число букв в строке = \(sum01)")
        print("Число цифр в строке = \(sum02)")
        print("Число символов в строке = \(sum03)")

//Task 5
        print("Task 5")
        
        func arrayToReverseArray ( array:[Int] = []) -> [Int]  {
            var index1 = array.count - 1
            var emptyArray:[Int] = []
            while index1 > -1 {
                emptyArray.append(array[index1])
                index1 -= 1
            }
            return emptyArray
        }
        
        let mass = [1,2,3,4,9,0]
        print (arrayToReverseArray(array:mass))
        
//Task 6
            
     
//Task 7
        print("Task 7")
        
        let massOfNumb = [5, 55, 780000, 34566, 800, 190]
        
        func maxOfmassOfNumb (mass: [Int] = []) -> Int {
            var numb = mass[0]
            for value in mass {
                if value >= numb {
                    numb = value
            }
          }
            return numb
        }
        print (maxOfmassOfNumb(mass: massOfNumb))
        
        
        
//Task 8
        
   
        
    }


}

