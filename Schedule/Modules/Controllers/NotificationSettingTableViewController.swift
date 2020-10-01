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
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Notification"
    
    tableView = UITableView.init(frame: .zero, style: .grouped)
    tableView.register(NotificationSettingTableViewCell.self, forCellReuseIdentifier: "NotificationCell")
    tableView.estimatedRowHeight = 64
    tableView.rowHeight = UITableView.automaticDimension
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  // MARK: Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "Day reminders"
    default: fatalError("Unknown number of section")
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 2
    default: fatalError("Unknown section")
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationSettingTableViewCell
    cell.accessoryType = .disclosureIndicator
    
    switch indexPath.section {
    case 0:
      switch indexPath.row {
      case 0:
        guard let time = UserDefaultsManager.shared.getObject(forKey: "TIME_MORNING"),
          let switchValue = UserDefaultsManager.shared.getObject(forKey: "SWITCH_MORNING")
        else {
          cell.timeLabel.text = "Unknown time"
          cell.conditionLabel.text = "off"
          return cell
        }
        
        cell.timeLabel.text = "Morning at \(time)"
        cell.conditionLabel.text = "\(switchValue)"
      case 1:
       guard let time = UserDefaultsManager.shared.getObject(forKey: "TIME_EVENING"),
         let switchValue = UserDefaultsManager.shared.getObject(forKey: "SWITCH_EVENING")
       else {
         cell.timeLabel.text = "Unknown time"
         cell.conditionLabel.text = "off"
         return cell
       }
        
        cell.timeLabel.text = "Evening at \(time)"
        cell.conditionLabel.text = "\(switchValue)"
      default: fatalError("Unknown row")
      }
    default: fatalError("Unknown section")
    }
    
    return cell
  }
  
  // MARK: Table view delegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    switch indexPath.row {
    case 0:
      let reminderViewController = ReminderOptionsViewController(pickerDataSource: ["07:00", "08:00", "09:00"])
      showModalView(reminderViewController)
    case 1:
      let reminderViewController = ReminderOptionsViewController(pickerDataSource: ["20:00", "21:00", "22:00"])
      showModalView(reminderViewController)
    default: fatalError("")
    }
  }
  
  // MARK: Methods
  
  func showModalView(_ viewController: UIViewController) {
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.modalTransitionStyle   = .coverVertical
    navigationController.modalPresentationStyle = .pageSheet
    self.present(navigationController, animated: true)
  }
  
}
