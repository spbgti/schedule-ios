//
//  AppDelegate.swift
//  schedule
//
//  Created by vladislav on 06/09/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notifications = NotificationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      // Notification setting
      notifications.notificationCenter.delegate = notifications
      notifications.notificationRequest()
      
      // RootViewController setting
      self.window = UIWindow(frame: UIScreen.main.bounds)
      self.window?.rootViewController = RootViewController()
      self.window?.makeKeyAndVisible()
      
      return true
    }
  
}
