//
//  ViewController.swift
//  tmsDZlesson3
//
//  Created by Янина on 19.06.21.
//

import UIKit

class ViewController: UIViewController {
    
    typealias FirstType = (maxOtjim: Int, maxPodt: Int, maxPris: Int)

    override func viewDidLoad() {
        super.viewDidLoad()
        
//      Task 1
        
        
        let tupleOne: FirstType = (15, 3, 100)
        print("Максимальное количество отжиманий \(tupleOne.maxOtjim),максимальное количество подтягиваний \(tupleOne.maxPodt), максимальное количество приседаний \(tupleOne.maxPris).")
        
        
//      Task 2
        
        
        let (_, _, maxPris) = tupleOne
        print ("Максимальное количество отжиманий - \(tupleOne.0)")
        print ("Максимальное количество подтягиваний - \(tupleOne.1)")
        print ("Максимальное количество приседаний - \(maxPris)")
        
        
//      Task 3
        
        
        let tupleTwo: FirstType = (5, 1, 30)
        let _ = (tupleOne.maxOtjim == tupleTwo.maxOtjim, tupleOne.maxPodt == tupleTwo.maxPodt, tupleOne.maxPris == tupleTwo.maxPris)
        
        
//      Task 4
        

        let tupleThree: FirstType = ((tupleOne.0 - tupleTwo.maxOtjim), (tupleOne.1 - tupleTwo.maxPodt), (tupleOne.2 - tupleTwo.maxPris))
        print("Максимальное количество отжиманий \(tupleThree.maxOtjim),максимальное количество подтягиваний \(tupleThree.maxPodt), максимальное количество приседаний \(tupleThree.maxPris).")
        
        
//       Task 5
        
        
        let str1: String = "866r"
        let str2: String = "90"
        let str3: String = "e44"
        let str4: String = "7"
        let str5: String = "13"
        
        var sum = 0
        
        if Int(str1) != nil {
            sum += Int(str1)!
        }
        if let str2 = Int(str2) {
            sum  += str2
        }
        if let str3 = Int(str3){
            sum += str3
        }
        sum += (Int(str4) ?? 0) + (Int(str5) ?? 0)
        
        var strSum = ""
        strSum = Int(str1) != nil ? str1: "nil"
        strSum += " + "
        strSum += Int(str2) != nil ? str2: "nil"
        strSum += " + "
        strSum += Int(str3) != nil ? str3: "nil"
        strSum += " + "
        strSum += Int(str4) != nil ? str4: "nil"
        strSum += " + "
        strSum += Int(str5) != nil ? str5: "nil"
        
        print ("\(strSum) = \(sum)")
        
        
        
//      Task 6
        
        
        let tuple01: (code: Int, message: String?, errorMessage: String?) = (Int.random (in: 200..<300), "message", nil)

        if tuple01.code >= 200 && tuple01.code < 300 {
            print(tuple01.message ?? "error")
        }
        
        
        let tuple02: (message: String?, errorMessage: String?) = (nil, "error")
        print (tuple02.message ?? "error")
        
        
//      Task 7
        
        
        let student1: (name: String, numberCar: Int?, grade: Int?)
        let student2: (name: String, numberCar: Int?, grade: Int?)
        let student3: (name: String, numberCar: Int?, grade: Int?)
        let student4: (name: String, numberCar: Int?, grade: Int?)
        let student5: (name: String, numberCar: Int?, grade: Int?)
        
        student1 = ("Игорь", nil, nil)
        student2 = ("Владимир", 9999, nil)
        student3 = ("Павел", 6767, nil)
        student4 = ("Сергей", nil, 5)
        student5 = ("Антон", 8888, 2)
        

        if student1.numberCar != nil || student1.grade != nil{
            if student1.numberCar != nil && student1.grade != nil {
                print ("Студент \(student1.name), машина есть номер \(student1.numberCar!), на контрольной присутствовал результат \(student1.grade!)")
            }else {
            if  student1.numberCar != nil {
                print ("Студент \(student1.name), машина есть номер \(student1.numberCar!), на контрольной отсутствовал")
            }else {
                print ("Студент \(student1.name), машины нет, на контрольной присутствовал результат \(student1.grade!) ")
            }
          }
        }else {
            print ("Студент \(student1.name), машины нет, на контрольной отсутствовал")
        }
        
            
        if student2.numberCar != nil || student2.grade != nil{
            if student2.numberCar != nil && student2.grade != nil {
                print ("Студент \(student2.name), машина есть номер \(student2.numberCar!), на контрольной присутствовал результат \(student2.grade!)")
            }else{
            if  student2.numberCar != nil {
                print ("Студент \(student2.name), машина есть номер \(student2.numberCar!), на контрольной отсутствовал")
            }else {
                print ("Студент \(student2.name), машины нет, на контрольной присутствовал результат \(student2.grade!) ")
            }
          }
        }else {
            print ("Студент \(student2.name), машины нет, на контрольной отсутствовал")
        }
        
        
        if student3.numberCar != nil || student3.grade != nil{
            if student3.numberCar != nil && student3.grade != nil {
                print ("Студент \(student3.name), машина есть номер \(student3.numberCar!), на контрольной присутствовал результат \(student3.grade!)")
            }else{
            if  student3.numberCar != nil {
                print ("Студент \(student3.name), машина есть номер \(student3.numberCar!), на контрольной отсутствовал")
            }else {
                print ("Студент \(student3.name), машины нет, на контрольной присутствовал результат \(student3.grade!) ")
            }
          }
        }else {
            print ("Студент \(student3.name), машины нет, на контрольной отсутствовал")
        }
        
        
        if student4.numberCar != nil || student4.grade != nil{
            if student4.numberCar != nil && student4.grade != nil {
                print ("Студент \(student4.name), машина есть номер \(student4.numberCar!), на контрольной присутствовал результат \(student4.grade!)")
            }else{
            if  student4.numberCar != nil {
                print ("Студент \(student4.name), машина есть номер \(student4.numberCar!), на контрольной отсутствовал")
            }else {
                print ("Студент \(student4.name), машины нет, на контрольной присутствовал результат \(student4.grade!) ")
            }
          }
        }else {
            print ("Студент \(student4.name), машины нет, на контрольной отсутствовал")
        }
        
        
        if student5.numberCar != nil || student5.grade != nil{
            if student5.numberCar != nil && student5.grade != nil {
                print ("Студент \(student5.name), машина есть номер \(student5.numberCar!), на контрольной присутствовал результат \(student5.grade!)")
            }else{
            if  student5.numberCar != nil {
                print ("Студент \(student5.name), машина есть номер \(student5.numberCar!), на контрольной отсутствовал")
            }else {
                print ("Студент \(student5.name), машины нет, на контрольной присутствовал результат \(student5.grade!) ")
            }
          }
        }else {
            print ("Студент \(student5.name), машины нет, на контрольной отсутствовал")
        }
        
        
//        Task 8
        
        
        let tupleOfFive: (num1: Int?, num2: Int?, num3: Int?, num4: Int?, num5: Int?) = (34, 4, nil, 29, nil)
        
        
        var sumTupleOfFive1 = (tupleOfFive.num1 ?? 0) + (tupleOfFive.num2 ?? 0) + (tupleOfFive.num3 ?? 0)
        sumTupleOfFive1 = sumTupleOfFive1 + (tupleOfFive.num4 ?? 0) + (tupleOfFive.num5 ?? 0)
        print("sum - \(sumTupleOfFive1)")
        
        
        
        var sumTupleOfFive2 = 0
        
        if tupleOfFive.num1 != nil {
            sumTupleOfFive2 += tupleOfFive.num1!
        }
        if tupleOfFive.num2 != nil {
            sumTupleOfFive2 += tupleOfFive.num2!
        }
        if tupleOfFive.num3 != nil {
            sumTupleOfFive2 += tupleOfFive.num3!
        }
        if tupleOfFive.num4 != nil {
            sumTupleOfFive2 += tupleOfFive.num4!
        }
        if tupleOfFive.num5 != nil {
            sumTupleOfFive2 += tupleOfFive.num5!
        }
        print("sum - \(sumTupleOfFive2)")
        
        
        
        var sumTupleOfFive3 = 0
        
        if let num1 = tupleOfFive.num1 {
            sumTupleOfFive3 += num1
        }
        if let num2 = tupleOfFive.num2 {
            sumTupleOfFive3 += num2
        }
        if let num3 = tupleOfFive.num3 {
            sumTupleOfFive3 += num3
        }
        if let num4 = tupleOfFive.num4 {
            sumTupleOfFive3 += num4
        }
        if let num5 = tupleOfFive.num5 {
            sumTupleOfFive3 += num5
        }
        print("sum - \(sumTupleOfFive3)")
        
        
        
        
    

    }
}

