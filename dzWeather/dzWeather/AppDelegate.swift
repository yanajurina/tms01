//
//  AppDelegate.swift
//  dzWeather
//
//  Created by Янина on 12.09.21.
//

import UIKit
import AlamofireNetworkActivityLogger
import GoogleMaps
import Firebase
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.applicationIconBadgeNumber = 0
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ["5days"])
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { result, error in
            guard result else { return }
            let content = UNMutableNotificationContent()
            content.title = "Hello!"
            content.badge = 1
            content.sound = UNNotificationSound.default
            content.body = "Friend, you haven't come to us for 5 days! See what's new!"
            content.userInfo = ["current_vc": "WeatherStoryboard"]
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5000000.0, repeats: true)
            let request = UNNotificationRequest(identifier: "5days", content: content, trigger: trigger)
            notificationCenter.add(request) { error_ in
                print(error_?.localizedDescription ?? "")
            }
        }
        NetworkActivityLogger.shared.startLogging()
        GMSServices.provideAPIKey("AIzaSyAi692TiFbyyGUL1zsHHdvSYszVo-2-klE")
        FirebaseApp.configure()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

