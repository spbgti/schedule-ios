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
  
  private var pickerDataSource: [String]
  private let pickerCell = PickerTableViewCell()
  private let activityCell = SwitchTableViewCell()
  
  // MARK: Life cycle
  
  init(pickerDataSource: [String]) {
    self.pickerDataSource = pickerDataSource
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Edit reminder"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(close))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
    
    pickerCell.pickerView.delegate = self
    pickerCell.pickerView.dataSource = self
    
    tableView = UITableView.init(frame: .zero, style: .grouped)
    tableView.estimatedRowHeight = 64
    tableView.rowHeight = UITableView.automaticDimension
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
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
      return 1
    default: fatalError("Unknown number of section")
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      return pickerCell
    case 1:
      switch indexPath.row {
      case 0:
        activityCell.textLabel?.text = "Turn off/on"
        return activityCell
      default: fatalError("Unknown row")
      }
    default: fatalError("Unknown section")
    }
  }
  
  // MARK: @objc methods

  @objc func close() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func save() {
    // TODO: add or update notification
    close()
  }

}

extension ReminderOptionsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerDataSource.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerDataSource[row]
  }
  
}
