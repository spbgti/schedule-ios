//
//  DataSettingTableViewController.swift
//  schedule
//
//  Created by vladislav on 29.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class DataSettingTableViewController: UITableViewController, UITextFieldDelegate {

  // MARK: - IBOutlets
  @IBOutlet weak var groupNumberTextField: UITextField!
  
  // MARK: - Properties
  let userDefaults = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    groupNumberTextField.delegate = self
    
    // Tap Gesture
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
    self.view.addGestureRecognizer(tapGesture)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    if let groupNumber = userDefaults?.string(forKey: "groupNameKey") {
      groupNumberTextField.text = groupNumber
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    
    if let groupNumber = groupNumberTextField.text {
      userDefaults?.set(groupNumber, forKey: "groupNameKey")
    }
  }
  
  // MARK: - Helpers
  @objc func closeKeyboard() {
    groupNumberTextField.resignFirstResponder()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    groupNumberTextField.resignFirstResponder()
    return true
  }

}
