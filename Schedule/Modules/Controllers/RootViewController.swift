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
    let launchedBefore = UserDefaultsManager.shared.getObject(forKey: "IS_LAUNCHED_BEFORE") as? Bool
    let welcomeViewController = WelcomeViewController()
    let scheduleViewController = UINavigationController(rootViewController: ScheduleViewController())
    
    if launchedBefore == nil {
      self.currentViewController = welcomeViewController
    } else {
      self.currentViewController = scheduleViewController
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
  
  // MARK: Methods
  
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
