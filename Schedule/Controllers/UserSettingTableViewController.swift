//
//  UserSettingTableViewController.swift
//  schedule
//
//  Created by vladislav on 24.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class UserSettingTableViewController: UITableViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var groupNameTextField: UITextField!
  
  let userDefault = UserDefaults.standard
  
  // MARK: - Life Cicle
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  override func viewWillAppear(_ animated: Bool) {
    if let groupName = userDefault.string(forKey: "groupNameKey") {
      self.groupNameTextField.text = groupName
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    if let groupNumber = groupNameTextField.text {
      userDefault.set(groupNumber, forKey: "groupNameKey")
    }
  }

}
