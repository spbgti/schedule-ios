//
//  LaunchViewController.swift
//  schedule
//
//  Created by vladislav on 21.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class FirstLaunchViewController: UIViewController {
  
  // MARK: Properties
  
  let userDefaults = UserDefaults(suiteName: "group.mac.schedule.sharingData")
  
  // MARK: Life cycle
  
  override func loadView() {
    self.view = 
  }
 
  
//  @IBAction func saveGroupName(_ sender: UIButton) {
//    let groupName = groupNameLabel.text!
//    let isFirstLaunchApp = true
//
//    userDefaults?.set(groupName, forKey: "groupNameKey")
//    userDefaults?.set(isFirstLaunchApp, forKey: "isLaunchedBefore")
//  }

}
