//
//  ViewController.swift
//  tmsDZlesson9
//
//  Created by Янина on 10.07.21.
//

import UIKit

protocol ViewControllerDelegate: class {
    
    func delegateFunc (valueAge: Int, valueGender: String)
}

class ViewController: UIViewController, ViewControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func clickButton(_ sender: UIButton) {
        if let nameTf = nameTextField.text, !nameTf.isEmpty {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerTwo") as? ViewControllerTwo{
            vc.nameString = nameTextField.text!
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            vc.delegate = self
            present(vc, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    func delegateFunc (valueAge: Int, valueGender: String) {
        if valueGender == "m" && valueAge > 50 {
            view.backgroundColor = .red
        } else if valueGender == "f" {
            view.backgroundColor = .yellow
        } else {
            view.backgroundColor = .green
        }
    }


}

