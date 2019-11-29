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
    
    // Create a toolbar
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeDatePicker))
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbar.setItems([flexSpace, doneButton], animated: true)
    eveningReminderTextField.inputAccessoryView = toolbar
  
    // Change value by Date Picker
    datePicker?.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    
    // Tap Gesture
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeDatePicker))
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
    
    let time = eveningReminderTextField.text!
    if time != "None"
    {
      notifications.scheduleNotification(time: dateFormatter(string: time)) { completionHandler in
        // to do something
      }
    }
  }
  
  @IBAction func allowNotification(_ sender: UISwitch) {
    // TODO: - Allow and unallow local notification
    
  }
  
  @objc func dateChange() {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    
    if let time = datePicker?.date {
      eveningReminderTextField.text = formatter.string(from: time)
    } else {
      eveningReminderTextField.text = "None"
    }
    
  }
  
  @objc func closeDatePicker() {
    view.endEditing(true)
  }
  
  func dateFormatter(string: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    return dateFormatter.date(from: string)!
  }
  
}
