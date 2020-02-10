//
//  Notifications.swift
//  schedule
//
//  Created by vladislav on 21.11.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
  
  // MARK: Properties
  
  let notificationCenter = UNUserNotificationCenter.current()
  
  // MARK: Methods
  
  func addNotification(identifier: String,
                       time: Date,
                       title: String,
                       subtitle: String,
                       body: String,
                       repeats: Bool = false) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.body = body
    content.sound = UNNotificationSound.default
    
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.hour, .minute], from: time)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: repeats)
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
    notificationCenter.add(request, withCompletionHandler: nil)
  }
  
  func removeNotification(by identifier: String) {
    notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
  }
  
  func removeAllNotifications() {
    notificationCenter.removeAllPendingNotificationRequests()
  }
  
  func notificationRequest() {
    let options: UNAuthorizationOptions = [.alert, .sound]
    notificationCenter.requestAuthorization(options: options) { (granted, error) in
      guard error == nil else { return }
      
      if granted {
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent willPresentnotification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
  }
  
}
