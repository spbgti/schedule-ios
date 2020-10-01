//
//  DataSettingTableViewController.swift
//  schedule
//
//  Created by vladislav on 29.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class GroupSettingTableViewController: UITableViewController {
    
  let groupsService = GroupsService()
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Group"
    
    tableView.register(GroupSettingTableViewCell.self, forCellReuseIdentifier: "groupSettingCell")
  }
  
  // MARK: TableView Setting
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "groupSettingCell", for: indexPath) as! GroupSettingTableViewCell
    
    switch indexPath.row {
    case 0:
      if let groupNumber = UserDefaultsManager.shared.getObject(forKey: "GROUP_NUMBER") {
        cell.groupNumberLabel?.text = "Your group number: \(groupNumber)"
      } else {
        cell.groupNumberLabel?.text = "Group not found"
      }
    case 1:
      cell.changeGroupButton.setTitle("Change group number", for: .normal)
      cell.changeGroupButton.addTarget(self, action: #selector(showSettingModalView), for: .touchUpInside)
    default: break
    }
    
    return cell
  }
  
  // TODO: Create modal view and reload data in this controllerview
  @objc func showSettingModalView() {
    let alert = UIAlertController(title: "Alert", message: "Input group number", preferredStyle: .alert)
    alert.addTextField { (textField) in
      textField.text = "example: 446"
    }
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
        
        if let groupNumber = alert?.textFields!.first {
            self.groupsService.getGroups(number: groupNumber.text ?? "446") { result in
                switch result {
                case .success(let groups):
                    if let group = groups.first {
                        UserDefaultsManager.shared.setObject(group.groupId, forKey: "GROUP_ID")
                        UserDefaultsManager.shared.setObject(group.number, forKey: "GROUP_NUMBER")
                    }
                case .failure(let error):
                  Alert.showMessageAlert(on: self, message: "\(error)", title: "Group not found")
                }
            }
        } else {
            Alert.showMessageAlert(on: self, message: "Error", title: "Text field is empty. Enter your group number")
        }
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
}
