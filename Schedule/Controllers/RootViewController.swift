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
  let userDefault = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")
  
  // MARK: Initializer
  
  init() {
    let launchedBefore = userDefault?.bool(forKey: "IS_LAUNCHED_BEFORE")
    
    if !launchedBefore! {
      self.currentViewController = WelcomeViewController()
    } else {
      self.currentViewController = ScheduleViewController()
    }
    
    super.init(nibName: nil, bundle: nil)
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
  
  // MARK: Navigation Methods
  
  func switchToScheduleScreen() {
    let newViewController = UINavigationController(rootViewController: ScheduleViewController())
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
