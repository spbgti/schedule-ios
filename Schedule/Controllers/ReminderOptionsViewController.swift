//
//  NotificationSettingViewController.swift
//  schedule
//
//  Created by vladislav on 11.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import PureLayout

class ReminderOptionsViewController: UITableViewController {
  
  // MARK: TableViewCell
  
  lazy var datePickerCell: UITableViewCell = {
    let cell = UITableViewCell()
    cell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    return cell
  }()
  
  lazy var repeatCell: UITableViewCell = {
    let cell = UITableViewCell()
    cell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    cell.textLabel?.text = "Repeat"
    return cell
  }()
  
  lazy var switchCell: UITableViewCell = {
    let cell = UITableViewCell()
    cell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    cell.textLabel?.text = "Tern on/off"
    return cell
  }()
  
  // MARK: Table view content
  
  lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.timeZone = NSTimeZone.local
    datePicker.backgroundColor = .white
    return datePicker
  }()
  
  lazy var switchView: UISwitch = {
    let switchView = UISwitch()
    return switchView
  }()
  
  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView = UITableView.init(frame: .zero, style: .grouped)
    
    datePickerCell.addSubview(datePicker)
    repeatCell.addSubview(switchView)
    switchCell.addSubview(switchView)
  }

  // MARK: Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
      return 2
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return 2
    default: fatalError("Unknown number of section")
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      return self.datePickerCell
    case 1:
      switch indexPath.row {
      case 0:
        return self.repeatCell
      case 1:
        return self.switchCell
      default: fatalError("Unknown row")
      }
    default: fatalError("Unknown section")
    }
  }

}
