//
//  LaunchViewController.swift
//  schedule
//
//  Created by vladislav on 21.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
  
  // MARK: Life cycle
  
  override func loadView() {
    self.view = WelcomeView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .gray
    
    view().welcomeLabel.text = "Welcome to SPbGTI schedule app"
    view().saveButton.addTarget(self, action: #selector(saveGroupNumber), for: .touchUpInside)
  }
  
  // MARK: Methods
  
  func view() -> WelcomeView {
    return self.view as! WelcomeView
  }
 
  @objc func saveGroupNumber() {
    if let groupNumber = view().groupNumberTextField.text {
      APIManager.shared.getGroups(groupNumber: groupNumber) { completion in
        DispatchQueue.main.async {
          switch completion{
          case .success(let result):
            UserDefaultsManager.shared.setObject(result[0].groupId, forKey: "GROUP_ID")
            UserDefaultsManager.shared.setObject(result[0].number, forKey: "GROUP_NUMBER")
            UserDefaultsManager.shared.setObject(true, forKey: "IS_LAUNCHED_BEFORE")
            AppDelegate.shared.rootViewController.switchToScheduleScreen()
          case .failure(let error):
            Alert.showMessageAlert(on: self, message: "\(error)", title: "Group not found")
          }
        }
      }
    } else {
      DispatchQueue.main.async {
        Alert.showMessageAlert(on: self, message: "Error", title: "Text field is empty. Enter your group number")
      }
    }
  }

}
