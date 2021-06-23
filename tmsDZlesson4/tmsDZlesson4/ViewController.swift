//
//  ViewController.swift
//  tmsDZlesson4
//
//  Created by Янина on 23.06.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
      // Task 1
                
                
               var tupleOne: (name: String, age: Int, sallary: Float)
               var tupleTwo: (name: String, age: Int, sallary: Float)
               var tupleThree: (name: String, age: Int, sallary: Float)
                
               tupleOne = ("Cергей", 19, 1300.5)
               tupleTwo = ("Владимир", 63, 2500)
               tupleThree = ("Евгений", 36, 3000)
                      
               func sallaryForAge (name: String, age: Int, sallary: Float) {
      //            if age >= 18 && age <= 70 {
                    switch age {
                    case 18...30:
                        print ("\(name), возраст \(age), повышенная з/п составила \(sallary * 1.5)")
                    case 31...40:
                        print ("\(name), возраст \(age), повышенная з/п составила \(sallary * 2)")
                    default:
                        print ("\(name), возраст \(age), повышенная з/п составила \(sallary * 3)")
                      }
                    }
        //            else {
        //              print ("несовершеннолетний")
        //           }
                
                sallaryForAge (name: tupleOne.name, age: tupleOne.age, sallary: tupleOne.sallary)
                sallaryForAge (name: tupleTwo.name, age: tupleTwo.age, sallary: tupleTwo.sallary)
                sallaryForAge (name: tupleThree.name, age: tupleThree.age, sallary: tupleThree.sallary)
                
                
        // Task 2
                
        
                func arithmeticMeanThreeNumb (numberO1: Int, numberO2: Int, numberO3: Int) {
                  var sum = 0
                  sum = (numberO1 + numberO2 + numberO3) / 3
                  print ("Среднее арифметическое чисел \(numberO1), \(numberO2), \(numberO3) равно \(sum)")
                }
                
                arithmeticMeanThreeNumb(numberO1: 45, numberO2: 1, numberO3: 0)
                
                
        // Task 3
                
                
                func calculatioCredit (sum: Float, period: Float, percent: Float) {
                
                    var month: Float = 0
                    var sumAll: Float = 0
                    let p: Float = (percent / Float(100))
                    
                    month = (sum * p * Float(pow((Double(1) + Double(p)), Double(period)))) / (Float(12) *
                        (Float(pow((Double(1) + Double(p)), Double(period))) - Float(1)))
                    sumAll = (month * Float(12)) * period
                    
                    print ("Сумма кредита (руб.): \(Int(sum))")
                    print ("Период (количество лет): \(Int(period))")
                    print ("Процент: \(Int(percent))")
                    print ("Ежемесячно: \(Int(month)) руб.")
                    print ("Общая сумма: \(Int(sumAll)) руб.")
                }
                
                calculatioCredit(sum: 20000, period: 3, percent: 7)
        
    }


}

