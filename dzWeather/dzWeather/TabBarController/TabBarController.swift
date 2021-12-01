//
//  TabBarController.swift
//  dzWeather
//
//  Created by Янина on 30.10.21.
//

import UIKit
import NVActivityIndicatorView

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: Int(view.center.x - 50.0), y: Int(view.center.y - 100.0), width: 100, height: 80))
        label.text = "Wait, please"
        label.textColor = .gray
        view.addSubview(label)
        let activ = NVActivityIndicatorView(frame: CGRect(x: view.center.x - 30.0, y: view.center.y - 30.0, width: 60.0, height: 60.0), type: .ballSpinFadeLoader, color: .gray, padding: 0.0)
        view.addSubview(activ)
        activ.startAnimating()
        
        RCManager.shared.remoteConfigConnected = {
            DispatchQueue.main.async {
                guard let vsFirstScreen = self.getViewController(from: "FirstScreen") as? FirstViewController,
                      let vsAppleMap = self.getViewController(from: "AppleMap") as? AppleMapViewController,
                      let vsGoogleMap = self.getViewController(from: "GoogleMap") as? GoogleMapViewController,
                      let vsNewsScreen = self.getViewController(from: "NewsViewController") as? NewsViewController else { return }
               
                let item1 = UITabBarItem(title: "Search", image: UIImage(named: "magnifyingglass"), tag: 0)
                vsFirstScreen.tabBarItem = item1
                let item2 = UITabBarItem(title: "Map", image: UIImage(named: "magnifyingglass"), selectedImage: UIImage(named: "alarm"))
                let item3 = UITabBarItem(title: "News", image: UIImage(named: "magnifyingglass"), selectedImage: UIImage(named: "alarm"))
                vsAppleMap.tabBarItem = item2
                vsGoogleMap.tabBarItem = item2
                vsNewsScreen.tabBarItem = item3
            
                if RCManager.shared.getBoolValue(from: .appleMap) {
                    label.text = ""
                    activ.stopAnimating()
                    self.viewControllers = [vsFirstScreen, vsAppleMap, vsNewsScreen]
                    self.selectedViewController = vsFirstScreen
                } else {
                    label.text = ""
                    activ.stopAnimating()
                    self.viewControllers = [vsFirstScreen, vsGoogleMap, vsNewsScreen]
                    self.selectedViewController = vsFirstScreen
                }
            }
        }
        RCManager.shared.connected()
    }
   
    func getViewController (from nameStoryboard: String?) -> UIViewController {
        let storyboard = UIStoryboard(name: nameStoryboard!, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        return vc!
    }
}

