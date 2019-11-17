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
  @IBOutlet weak var selectedControl: UISegmentedControl!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  let userDefaults = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")
  var array = [Exercise]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
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
    
    // Selected index of selectedControl
    self.selectedControl.selectedSegmentIndex = 0
    activityIndicator.startAnimating()
      
    if groupName == "446" {
      ScheduleRequest.shared.getGroups(groupName: groupName!) { completion in
        let groupId = String(completion[0].groupId)
        DispatchQueue.main.async {
          ScheduleRequest.shared.getExercises(groupId: groupId, date: "2019-09-22") { completionHandler in
            self.array = completionHandler
            self.activityIndicator.stopAnimating()
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
  @IBAction func selectSchedule(_ sender: Any) {
    let groupName = self.userDefaults?.string(forKey: "groupNameKey")
    
    activityIndicator.startAnimating()
    
    switch selectedControl.selectedSegmentIndex {
    case 0:
      ScheduleRequest.shared.getGroups(groupName: groupName!) { completion in
        DispatchQueue.main.async {
          ScheduleRequest.shared.getExercises(groupId: String(completion[0].groupId), date: "2019-09-22") { completionHandler in
            self.activityIndicator.stopAnimating()
            self.array = completionHandler
          }
        }
      }
    case 1:
      ScheduleRequest.shared.getGroups(groupName: groupName!) { completion in
        DispatchQueue.main.async {
          ScheduleRequest.shared.getExercises(groupId: String(completion[0].groupId), date: "2019-09-23") { completionHandler in
            self.activityIndicator.stopAnimating()
            self.array = completionHandler
          }
        }
      }
    default:
      break
    }
  }
    
}


