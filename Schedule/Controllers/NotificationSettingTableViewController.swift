//
//  NotificationSettingTableViewController.swift
//  schedule
//
//  Created by vladislav on 19.11.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationSettingTableViewController: UITableViewController {
  
  @IBOutlet weak var allowNotificationSwitch: UISwitch!
  @IBOutlet weak var eveningReminderTextField: UITextField!
  private var datePicker: UIDatePicker?
  
  let notifications = Notifications()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setting of Data Picker
    datePicker = UIDatePicker()
    datePicker?.datePickerMode = .time
    eveningReminderTextField.inputView = datePicker
    
    // Change value by Date Picker
    datePicker?.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    
    // Tap Gesture
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
    self.view.addGestureRecognizer(tapGesture)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    notifications.notificationCenter.getNotificationSettings { (setting) in
      DispatchQueue.main.async {
        if setting.authorizationStatus == .authorized {
          self.allowNotificationSwitch.isOn = true
        } else {
          self.allowNotificationSwitch.isOn = false
        }
        
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    
    if let time = eveningReminderTextField.text
    {
      notifications.scheduleNotification(time: dateFormatter(string: time)) { completionHandler in
        
      }
    }
  }
  
  @IBAction func allowNotification(_ sender: UISwitch) {
    // TODO: - Allow and unallow local notification
  }
  
  @objc func dateChange() {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    eveningReminderTextField.text = formatter.string(from: datePicker!.date)
  }
  
  @objc func tapGestureDone() {
    view.endEditing(true)
  }
  
  func dateFormatter(string: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    return dateFormatter.date(from: string)!
  }
  
}
