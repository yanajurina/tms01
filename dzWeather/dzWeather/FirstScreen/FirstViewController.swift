//
//  ViewController.swift
//  dzWeather
//
//  Created by Янина on 12.09.21.
//

import UIKit
import NVActivityIndicatorView

class FirstViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var cityTextField: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextField.delegate = self
        
        let activity = NVActivityIndicatorView(frame: CGRect(x: 150, y: 230, width: 100, height: 100), type: .orbit, color: .blue, padding: 0)
        self.view.addSubview(activity)
        activity.startAnimating()
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.resignFirstResponder()
        return true
    }
    
    func getViewController() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "WeatherStoryboard", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        return vc!
    }
    @IBAction func goButton(_ sender: UIButton) {
        guard let textField = cityTextField.text, !textField.isEmpty else { return }
        let storyboard = UIStoryboard.init(name: "WeatherStoryboard", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? WeatherViewController {
            vc.cityName = "\(cityTextField.text ?? "")"
        }
        self.navigationController?.pushViewController(getViewController(), animated: true)
    }
    
}

