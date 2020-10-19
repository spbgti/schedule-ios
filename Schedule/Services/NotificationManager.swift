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
  
    func addNotification(_ reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = reminder.name
        content.subtitle = ""
        content.body = reminder.description ?? ""
        content.sound = UNNotificationSound.default
        
        let time = dateFormatter("\(reminder.hour):\(reminder.minute)")
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.hour, .minute], from: time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: reminder.isRepeate)
        let request = UNNotificationRequest(identifier: reminder.name, content: content, trigger: trigger)
        
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
    
    private func dateFormatter(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.date(from:string)!
    }
  
}
