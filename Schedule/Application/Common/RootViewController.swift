//
//  RootViewController.swift
//  schedule
//
//  Created by vladislav on 28.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
  
  // MARK: Properties
  
  private var currentViewController: UIViewController
  
  // MARK: Initializer
  
  init() {
    let launchedBefore = UserDefaultsManager.shared.getObject(forKey: "IS_FIRST_LAUNCH") as? Bool
    let welcomeViewController = WelcomeViewController()
    
    let scheduleStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let scheduleViewController = scheduleStoryboard.instantiateInitialViewController() as! MainController
    
    if launchedBefore == nil {
      self.currentViewController = welcomeViewController
    } else {
      self.currentViewController = scheduleViewController
    }
    
    super.init(nibName: nil, bundle: nil)
    
    if launchedBefore == nil {
        self.createDefaultReminders()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
     super.viewDidLoad()
     
     addChild(currentViewController)
     currentViewController.view.frame = view.bounds
     view.addSubview(currentViewController.view)
     currentViewController.didMove(toParent: self)
  }
  
  // MARK: Methods
    
    private func createDefaultReminders() {
        let morningReminder = Reminder(name: "Morning reminder",
                                       description: "Hey! Check the schedule now.",
                                       hour: "--",
                                       minute: "--",
                                       isRepeate: true,
                                       isActive: false)
        
        let eveningReminder = Reminder(name: "Evening reminder",
                                       description: "Hey! Check the schedule now.",
                                       hour: "--",
                                       minute: "--",
                                       isRepeate: true,
                                       isActive: false)
        let jsonDecoder = JSONEncoder()
        
        var reminderData = try! jsonDecoder.encode(morningReminder)
        UserDefaults.standard.setValue(reminderData, forKey: "\(morningReminder.name)")
        
        reminderData = try! jsonDecoder.encode(eveningReminder)
        UserDefaults.standard.setValue(reminderData, forKey: "\(eveningReminder.name)")
    }
  
  func switchToScheduleScreen() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let newViewController = storyboard.instantiateInitialViewController() as! MainController
        
    addChild(newViewController)
    newViewController.view.frame = view.bounds
    view.addSubview(newViewController.view)
    newViewController.didMove(toParent: self)
    currentViewController.willMove(toParent: nil)
    currentViewController.view.removeFromSuperview()
    currentViewController.removeFromParent()
    currentViewController = newViewController
  }
  
}
