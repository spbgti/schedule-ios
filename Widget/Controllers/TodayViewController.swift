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
  
  var array = [Exercise]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Button "Show More/Less"
    self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
  }
      
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
      
    ScheduleRequest.shared.getGroups(groupName: "446") { completion in
      let groupId = String(completion[0].groupId)
      DispatchQueue.main.async {
        ScheduleRequest.shared.getExercises(groupId: groupId, date: "2019-09-23") { completionHandler in
          self.array = completionHandler
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
        self.preferredContentSize = CGSize(width: maxSize.width, height: 300)
    }
  }
    
}

