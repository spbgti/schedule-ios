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
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var eveningReminderTextField: UITextField!
  @IBOutlet weak var reminderSwitch: UISwitch!
  
  // MARK: - Properties
  
  private let notifications = Notifications()
  private let userDefaults = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")
  
  // MARK: - Views
  
  lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .time
    datePicker.minuteInterval = 5
    
    return datePicker
  }()
  
  lazy var toolBar: UIToolbar = {
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeDatePicker))
    toolBar.setItems([flexSpace, doneButton], animated: true)
    
    return toolBar
  }()
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Add DatePicker and ToolBar
    eveningReminderTextField.inputView = datePicker
    eveningReminderTextField.inputAccessoryView = toolBar
  
    // Change value by Date Picker
    datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    
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
      eveningReminderTextField.text = "00:00"
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
  
  // MARK: - IBActions
  
  @IBAction func switchReminder(_ sender: UISwitch) {
    let eveningReminderTime = eveningReminderTextField.text!
    
    switch sender.isOn {
    case true:
      notifications.scheduleNotification(time: Date.dateFormatter(date: eveningReminderTime, dateFormat: "HH:mm")) { completionHandler in
        // to do something
      }
      self.userDefaults?.set(eveningReminderTime, forKey: "eveningReminderTime")
      self.userDefaults?.set(true, forKey: "reminderSwitch")
      
    case false:
      notifications.removeNotifications(withIdentifiers: ["Identifier"])
      self.userDefaults?.set(false, forKey: "reminderSwitch")
    }
  }
  
  // MARK: - Functions
  
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
  
  // MARK: - @objc functions
  
  @objc func dateChange() {
    let time = datePicker.date
    eveningReminderTextField.text = Date.dateFormatter(date: time, dateFormat: "HH:mm")
  }
  
  @objc func closeDatePicker() {
    let eveningReminderTime = eveningReminderTextField.text!
    
    self.userDefaults?.set(eveningReminderTime, forKey: "eveningReminderTime")
    if reminderSwitch.isOn {
      notifications.scheduleNotification(time: Date.dateFormatter(date: eveningReminderTime, dateFormat: "HH:mm")) { completionHandler in
        // to do something
      }
    }
    
    view.endEditing(true)
  }
  
}
