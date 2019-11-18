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
  
  let userDefaults = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")
  var array = [Exercise]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
        self.activityIndicator.stopAnimating()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
      
    if groupName == "446" {
      ScheduleRequest.shared.getGroups(groupName: groupName!) { completion in
        let groupId = String(completion[0].groupId)
        DispatchQueue.main.async {
          ScheduleRequest.shared.getExercises(groupId: groupId, date: "2019-09-22") { completionHandler in
            self.array = completionHandler
          }
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
    
    ScheduleRequest.shared.getGroups(groupName: groupName!) { completion in
      DispatchQueue.main.async {
        ScheduleRequest.shared.getExercises(groupId: String(completion[0].groupId), date: date) { completionHandler in
          self.array = completionHandler
        }
      }
    }
  }
  
}


