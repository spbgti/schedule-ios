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
  
  // MARK: Properties
  
  private let notifications = NotificationManager()
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Notification"
    
    tableView.register(NotificationSettingTableViewCell.self, forCellReuseIdentifier: "NotificationCell")
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Reminder"
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationSettingTableViewCell
    
    // FIXME: Delete prototype and create working cell
    switch indexPath.row {
    case 0:
      cell.nameLabel.text = "In morning"
      cell.timeLabel.text = "00:00"
      cell.switchControl.isOn = false
    case 1:
      cell.nameLabel.text = "In evening"
      cell.timeLabel.text = "00:00"
      cell.switchControl.isOn = false
    default:
      break
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    showModalView(ReminderOptionsViewController())
  }
  
  // MARK: Methods
  
  func showModalView(_ viewController: UIViewController) {
    viewController.modalTransitionStyle   = .coverVertical
    viewController.modalPresentationStyle = .currentContext
    self.present(viewController, animated: true, completion: nil)
  }
  
}
