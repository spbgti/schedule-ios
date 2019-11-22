//
//  Notifications.swift
//  schedule
//
//  Created by vladislav on 21.11.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
  
  let notificationCenter = UNUserNotificationCenter.current()
  
  func notificationRequest() {
    let options: UNAuthorizationOptions = [.alert, .sound]
    
    notificationCenter.requestAuthorization(options: options) { (granted, error) in 
      
    }
  }
  
  func scheduleNotification(time: Date, completion: (Bool) -> ()) {
    removeNotifications(withIdentifiers: ["Identifier"])
    
    let content = UNMutableNotificationContent()
    content.title = "Schedule for tomorrow"
    content.body = "You have four exercise tomorrow. Click to watch!"
    content.sound = UNNotificationSound.default
    
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.hour, .minute], from: time)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
    let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
    
    notificationCenter.add(request, withCompletionHandler: nil)
  }
  
  func removeNotifications(withIdentifiers identifiers: [String]) {
    notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent willPresentnotification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
  }
  
}
