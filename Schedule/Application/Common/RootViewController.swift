//
//  RootViewController.swift
//  schedule
//
//  Created by vladislav on 28.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
  
    private var currentViewController: UIViewController
  
    init() {
//        let isFirstLaunch = UserDefaults.standard.bool(forKey: "IS_FIRST_LAUNCH")

        let onboardingViewController = OnboardingViewController()

//        let scheduleStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let scheduleViewController = scheduleStoryboard.instantiateInitialViewController() as! MainController

//        if isFirstLaunch {
//            self.currentViewController = onboardingViewController
//        } else {
//            self.currentViewController = scheduleViewController
//        }
        
        self.currentViewController = onboardingViewController
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(currentViewController)
        currentViewController.view.frame = view.bounds
        view.addSubview(currentViewController.view)
        currentViewController.didMove(toParent: self)
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
