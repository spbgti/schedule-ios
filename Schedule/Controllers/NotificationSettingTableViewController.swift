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
  
  @IBOutlet weak var eveningReminderTextField: UITextField!
  @IBOutlet weak var reminderSwitch: UISwitch!
  
  private var datePicker: UIDatePicker?
  private let notifications = Notifications()
  private let userDefaults = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setting of Data Picker
    datePicker = UIDatePicker()
    datePicker?.datePickerMode = .time
    eveningReminderTextField.inputView = datePicker
    
    // Create a toolbar
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeDatePicker))
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
    
    // Set up time value to textField
    if let eveningReminderTime = userDefaults?.string(forKey: "eveningReminderTime") {
      eveningReminderTextField.text = eveningReminderTime
    } else {
      eveningReminderTextField.text = "20:00"
    }
    
    // Switch on/off reminder
    if let reminderSwitch = userDefaults?.bool(forKey: "reminderSwitch") {
      self.reminderSwitch.isOn = reminderSwitch
    } else {
      self.reminderSwitch.isOn = false
    }
    
    // Go to setting to allow notification
    notifications.notificationCenter.getNotificationSettings { (setting) in
      DispatchQueue.main.async {
        if setting.authorizationStatus != .authorized {
          self.goToSetting()
        }
      }
    }
    
  }
  
  @IBAction func switchReminder(_ sender: UISwitch) {
    let eveningReminderTime = eveningReminderTextField.text!
    
    switch sender.isOn {
    case true:
      eveningReminderTextField.isUserInteractionEnabled = true
      notifications.scheduleNotification(time: dateFormatter(string: eveningReminderTime)) { completionHandler in
        // to do something
      }
      self.userDefaults?.set(eveningReminderTime, forKey: "eveningReminderTime")
      self.userDefaults?.set(true, forKey: "reminderSwitch")
      
    case false:
      eveningReminderTextField.isUserInteractionEnabled = false
      notifications.removeNotifications(withIdentifiers: ["Identifier"])
      self.userDefaults?.set(false, forKey: "reminderSwitch")
    }
  }
  
  //
  // MARK: - Helpers
  //
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
    let eveningReminderTime = eveningReminderTextField.text!
    
    notifications.scheduleNotification(time: dateFormatter(string: eveningReminderTime)) { completionHandler in
      // to do something
    }
    self.userDefaults?.set(eveningReminderTime, forKey: "eveningReminderTime")
    
    view.endEditing(true)
  }
  
  func dateFormatter(string: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    return dateFormatter.date(from: string)!
  }
  
  func goToSetting() {
    let alertController = UIAlertController (title: "Do you want go to the setting app to allow notification", message: "", preferredStyle: .alert)

    let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in

      guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
          return
      }

      if UIApplication.shared.canOpenURL(settingsURL) {
        UIApplication.shared.open(settingsURL)
      }
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    
    alertController.addAction(settingsAction)
    alertController.addAction(cancelAction)

    self.present(alertController, animated: true)
  }
  
}
