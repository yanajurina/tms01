//
//  ViewControllerTwo.swift
//  tmsDZlesson9
//
//  Created by Янина on 10.07.21.
//

import UIKit

class ViewControllerTwo: UIViewController, UITextFieldDelegate {

    var nameString: String = ""
    
    weak var delegate: ViewControllerDelegate?
    
    @IBOutlet weak var welcomTextLabel: UILabel!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBAction func doneButton(_ sender: UIButton) {
        if let tf1 = ageTextField.text, !tf1.isEmpty {
            if let tf2 = genderTextField.text, !tf2.isEmpty {
                let ageValue = Int(ageTextField.text!)!
                let genderValue = genderTextField.text!
                delegate?.delegateFunc(valueAge: ageValue, valueGender: genderValue)
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        ageTextField.delegate = self
        genderTextField.delegate = self
        
        welcomTextLabel.text = " Привет, \(nameString)! Введи свои данные: возраст и пол."

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ageTextField {
            genderTextField.becomeFirstResponder()
        } else {
            genderTextField.resignFirstResponder()
        }
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else {return true}
        if textField == ageTextField {
            if Int(string) != nil {
                return true
            }
        }
        if textField == genderTextField {
            if (textField.text?.count ?? 0) + string.count < 2 && (string == "m" || string == "f") {
                return true
            }
        }
        if let tf = textField.text, tf.isEmpty {
            return false
        }
        
      return false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
