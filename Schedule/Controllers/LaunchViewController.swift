//
//  LaunchViewController.swift
//  schedule
//
//  Created by vladislav on 21.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
  
  // MARK: - IBOutlet
  @IBOutlet weak var groupNameLabel: UITextField!
  
  let userDefaults = UserDefaults(suiteName: "group.mac.schedule.sharingData")
  
  // MARK: - IBAction
  @IBAction func saveGroupName(_ sender: UIButton) {
    let groupName = groupNameLabel.text!
    let isFirstLaunchApp = true
    
    userDefaults?.set(groupName, forKey: "groupNameKey")
    userDefaults?.set(isFirstLaunchApp, forKey: "isLaunchedBefore")
  }

}
