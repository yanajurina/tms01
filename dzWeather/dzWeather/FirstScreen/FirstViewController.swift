//
//  ViewController.swift
//  dzWeather
//
//  Created by Янина on 12.09.21.
//

import UIKit
import NVActivityIndicatorView

class FirstViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextField.delegate = self
        
        let activity = NVActivityIndicatorView(frame: CGRect(x: 170, y: 280, width: 50, height: 50), type: .orbit, color: .lightGray, padding: 0)
        self.view.addSubview(activity)
        activity.startAnimating()
    
        setupNotification()
    }
    
    func setupNotification() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { result, error in
            guard result else { return }
            let content = UNMutableNotificationContent()
            content.title = "Hello!"
            content.badge = 1
            content.sound = UNNotificationSound.default
            content.body = "Friend, you have not come to us for 5 days! See what's new!"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 432000.0, repeats: true)
            let request = UNNotificationRequest(identifier: "5days", content: content, trigger: trigger)
            notificationCenter.add(request) { error_ in
                print(error_?.localizedDescription ?? "")
            }
        }
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
        let vc = getViewController()
        vc.modalPresentationStyle = .currentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
//        let storyboard = UIStoryboard.init(name: "GoogleMap", bundle: nil)
//        guard let vc = storyboard.instantiateInitialViewController() as? GoogleMapViewController else {return}
//        vc.modalPresentationStyle = .currentContext
//        vc.modalTransitionStyle = .crossDissolve
//        present(vc, animated: true, completion: nil)
//    }
        
}
extension FirstViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    }
}
