//
//  FirstViewController.swift
//  dzWeather
//
//  Created by Янина on 12.09.21.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.applicationIconBadgeNumber = 0
        
        cityTextField.delegate = self
    
        guard let newVC = SettingManager.shared.pushNewVC,
              let presentVC = UIViewController.getViewController(by: newVC) else { return }
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            presentVC.modalPresentationStyle = .currentContext
            presentVC.modalTransitionStyle = .crossDissolve
            present(presentVC, animated: true, completion: nil)
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .denied, .restricted:
            showAlertForUseLocation()
        default: break
        }
    }
    
//    func setupLocation() {
//        switch locationManager.authorizationStatus {
//        case .notDetermined:
//            locationManager.requestAlwaysAuthorization()
//        case .denied, .restricted:
//            showAlertForUseLocation()
//        default: break
//        }
//    }
    
    func showAlertForUseLocation() {
        let alert = UIAlertController(title: nil, message: "Allow use location in app settings", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let setting = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(setting)
        
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func goButton(_ sender: UIButton) {
        guard let textField = cityTextField.text, !textField.isEmpty else { return }
        let storyboard = UIStoryboard.init(name: "WeatherStoryboard", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? WeatherViewController {
            vc.cityName = textField
            vc.modalPresentationStyle = .currentContext
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func goToHistoryButton(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "History", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? HistoryViewController {
            vc.modalPresentationStyle = .currentContext
            vc.modalTransitionStyle = .crossDissolve
          
            present(vc, animated: true, completion: nil)
        }
    }
}
