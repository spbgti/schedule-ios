//
//  LaunchViewController.swift
//  schedule
//
//  Created by vladislav on 21.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let groupsService = GroupsService()
  
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
        groupsService.getGroups(number: groupNumber) { result in
            switch result {
            case .success(let groups):
                if let group = groups.first {
                    UserDefaultsManager.shared.setObject(group.groupId, forKey: "GROUP_ID")
                    UserDefaultsManager.shared.setObject(group.number, forKey: "GROUP_NUMBER")
                    UserDefaultsManager.shared.setObject(true, forKey: "IS_LAUNCHED_BEFORE")
                    AppDelegate.shared.rootViewController.switchToScheduleScreen()
                }
            case .failure(let error):
              Alert.showMessageAlert(on: self, message: "\(error)", title: "Group not found")
            }
        }
    } else {
        Alert.showMessageAlert(on: self, message: "Error", title: "Text field is empty. Enter your group number")
    }
  }

}
