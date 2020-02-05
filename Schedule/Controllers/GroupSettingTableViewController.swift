//
//  DataSettingTableViewController.swift
//  schedule
//
//  Created by vladislav on 29.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class GroupSettingTableViewController: UITableViewController {
  
  // MARK: Properties
  
  let userDefaults = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Group"
    
    tableView.register(GroupSettingCell.self, forCellReuseIdentifier: "groupSettingCell")
  }
  
  // MARK: TableView Setting
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let vw = UIView()
    vw.backgroundColor = UIColor.lightGray

    return vw
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "groupSettingCell", for: indexPath) as! GroupSettingCell
    
    cell.describeLabel?.text = "Your group number"
    cell.groupTextField?.text = userDefaults?.string(forKey: "GROUP_NUMBER")
    
    return cell
  }
  
  // MARK: Methods
  
  @objc func saveGroupNumber() {
    let cell = GroupSettingCell()
    // TODO: take a value from textField
    if let groupNumber = cell.describeLabel?.text {
      APIManager.shared.getGroups(groupNumber: groupNumber) { completion in
        DispatchQueue.main.async {
          switch completion{
          case .success(let result):
            self.userDefaults?.set(result[0].groupId, forKey: "GROUP_ID")
            self.userDefaults?.set(result[0].number, forKey: "GROUP_NUMBER")
            self.userDefaults?.set(true, forKey: "IS_LAUNCHED_BEFORE")
            AppDelegate.shared.rootViewController.switchToScheduleScreen()
          case .failure(let error):
            Alert.showBasicAlert(on: self, message: "\(error)", with: "Group not found")
          }
        }
      }
    } else {
      DispatchQueue.main.async {
        Alert.showBasicAlert(on: self, message: "Error", with: "Text field is empty. Enter your group number")
      }
    }
  }
  
}
