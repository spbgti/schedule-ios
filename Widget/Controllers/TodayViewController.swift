//
//  TodayViewController.swift
//  Widget
//
//  Created by vladislav on 30.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var groupNumberLabelText: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var errorLabelText: UILabel!
  
  let userDefaults = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")
  var array = [Exercise]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
        self.errorLabelText.isHidden = true
        self.activityIndicator.stopAnimating()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Hide error label befor return error
    errorLabelText.isHidden = true
    
    // Setiing tableView's delegate and dataSource
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    // Button "Show More/Less"
    self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
  }
      
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    let groupName = userDefaults?.string(forKey: "groupNameKey")
    
    // Displayed a group number
    self.groupNumberLabelText.text = self.groupNumberLabelText.text! + groupName!
    activityIndicator.startAnimating()
      
    DataManager.shared.getExercisesByGroupName(groupName: groupName!, date: "2019-09-22") { completionHandler in
      DispatchQueue.main.async {
        switch completionHandler {
        case .success(let result):
          self.array = result
        case .failure(let error):
          self.activityIndicator.stopAnimating()
          self.errorLabelText.isHidden = false
          self.errorLabelText.text = error
        }
      }
    }
    
    completionHandler(NCUpdateResult.newData)
  }
  
  // Protocol method implementation
  func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
    if activeDisplayMode == .compact {
        self.preferredContentSize = maxSize
    } else if activeDisplayMode == .expanded {
        self.preferredContentSize = CGSize(width: maxSize.width, height: 250)
    }
  }
  
  // MARK: - IBActions
  @IBAction func changeDayOfSchedule(_ sender: UIButton) {
    
    let groupName = self.userDefaults?.string(forKey: "groupNameKey")
    var date = String()
    
    activityIndicator.startAnimating()
    
    switch sender.currentTitle! {
    case "Today":
      date = "2019-09-23"
      sender.setTitle("Tomorrow", for: .normal)
    case "Tomorrow":
      date = "2019-09-22"
      sender.setTitle("Today", for: .normal)
    default:
      break
    }
    
    DataManager.shared.getExercisesByGroupName(groupName: groupName!, date: date) { completionHandler in
      DispatchQueue.main.async {
        switch completionHandler {
        case .success(let result):
          self.array = result
        case .failure(let error):
          self.activityIndicator.stopAnimating()
          self.errorLabelText.text = error
          self.errorLabelText.isHidden = false
        }
      }
    }
  }
  
}
