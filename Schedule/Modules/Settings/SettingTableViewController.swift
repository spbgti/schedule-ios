//
//  UserSettingTableViewController.swift
//  schedule
//
//  Created by vladislav on 24.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    
    private var detailsTransitioningDelegate: InteractiveModalTransitioningDelegate!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        tableView.rowHeight = 44.0
        tableView.register(SettingTVCell.self, forCellReuseIdentifier: "SettingTVCell")
    }

}

extension SettingViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupNumber = UserDefaults.standard.string(forKey: "GROUP_NUMBER") ?? "Not found"
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTVCell", for: indexPath) as! SettingTVCell
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        cell.name = "Group number"
        cell.detail = groupNumber
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "GroupSettings", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! GroupSettingsViewController
                
        detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self, to: controller)
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = detailsTransitioningDelegate
        controller.callback = { [weak self] in
            self?.tableView.reloadData()
        }
        
        present(controller, animated: true, completion: nil)
    }
}
