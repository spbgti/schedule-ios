//
//  LaunchViewController.swift
//  schedule
//
//  Created by vladislav on 21.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet private var button: Button!
    @IBOutlet private var validatingLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var loader: UIActivityIndicatorView!
    
    let groupsService = GroupsService()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        validatingLabel.isHidden = true
    }
    
    @IBAction private func saveGroupNumber() {
        self.validatingLabel.isHidden = true
        self.loader.startAnimating()
        
        guard let groupNumberText = textField.text, groupNumberText != "" else {
            self.loader.stopAnimating()
            self.validatingLabel.text = "Text field is empty"
            self.validatingLabel.isHidden = false
            return
        }
        
        groupsService.getGroups(number: groupNumberText) { [weak self] result in
            switch result {
            case .success(let groups):
                self?.loader.stopAnimating()
                
                if groups.count > 0, let group = groups.first {
                    UserDefaults.standard.set(group.groupId, forKey: "GROUP_ID")
                    UserDefaults.standard.set(group.number, forKey: "GROUP_NUMBER")
                    UserDefaults.standard.set(false, forKey: "IS_FIRST_LAUNCH")
                    AppDelegate.shared.rootViewController.switchToScheduleScreen()
                } else {
                    self?.validatingLabel.text = "Group not found"
                    self?.validatingLabel.isHidden = false
                }
            case .failure( _):
                self?.loader.stopAnimating()
                self?.validatingLabel.text = "Group not found"
                self?.validatingLabel.isHidden = false
            }
        }
    }

}
