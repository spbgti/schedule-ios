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
  
  // MARK: - Life circle
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }
  
  // MARK: - IBAction
  @IBAction func saveGroupName(_ sender: UIButton) {
    let userDefaults = UserDefaults.standard
    let groupName = groupNameLabel.text!
    let isFirstLaunchApp = true
    
    userDefaults.set(groupName, forKey: "groupNameKey")
    userDefaults.set(isFirstLaunchApp, forKey: "isLaunchedBefore")
  }
  

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
  */

}
