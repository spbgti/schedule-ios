//
//  UserSettingTableViewController.swift
//  schedule
//
//  Created by vladislav on 24.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import PureLayout

class SettingTableViewController: UITableViewController {
  
  // MARK: - Life Cicle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Setting"
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingCell")
  }
  
  // MARK: TableView Setting
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return SettingSection.arrayOfCases.count
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let vw = UIView()
    vw.backgroundColor = UIColor.lightGray

    return vw
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0: return 1
    case 1: return 1
    default: return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
    
    switch indexPath.section {
    case 0:
      cell.textLabel?.text = "Group"
      cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    case 1:
      cell.textLabel?.text = "Notification"
      cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    default:
      break
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0:
      switch indexPath.row {
      case 0:
        navigationController?.pushViewController(GroupSettingTableViewController(), animated: true)
      default: break
      }
    case 1:
      switch indexPath.row {
      case 0:
        navigationController?.pushViewController(NotificationSettingTableViewController(), animated: true)
      default: break
      }
    default: break
    }
  }

}
