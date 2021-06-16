//
//  ViewController.swift
//  tmsDZlesson2
//
//  Created by Янина on 16.06.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//      Task 1
               
 let a: Double = 2.3
 let b: Double = 3.6
 let c: Double = 1.9
 let d: Double = 5.2
                
 let result01 = Int(a) + Int(b) + Int(c) + Int(d)
 print(" Сумма целых чисел - \(result01)")

 let result02 = Int(a) * Int(b) * Int(c) * Int(d)
 print(" Произведение целых чисел - \(result02)")
                
                
 var a1 = Int(a)
 var b1 = Int(b)
 var c1 = Int(c)
 var d1 = Int(d)
                
 var a2: Double = a - Double(a1)
 var b2: Double = b - Double(b1)
 var c2: Double = c - Double(c1)
 var d2: Double = d - Double(d1)
                
                
 let result03 = (a2 + b2 + c2 + d2) * 10
 print (" Сумма дробных частей - \(Int (result03))")
                
 let result04 = (a2 * b2 * c2 * d2) * 10000
 print (" Произведение дробных частей - \(Int (result04))")
                
                
//      Task 2
                
 var numb = 7
 if numb % 2 == 0 {
 print(" Число \(numb) является четным")
      } else {
 print(" Число \(numb) является нечетным")
 }
                
        
    }


}

