//
//  RootViewController.swift
//  schedule
//
//  Created by vladislav on 28.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: Child ViewControllers
    
    private lazy var onboardingViewController: OnboardingViewController = {
        let viewController = OnboardingViewController()
        return viewController
    }()
    
    private lazy var scheduleViewController: ScheduleViewController = {
        let scheduleViewController = ScheduleViewController(baseDate: Date())
        return scheduleViewController
    }()
    
    // MARK: ViewController to switch between child ViewControllers
  
    private var currentViewController: UIViewController!
    
    // MARK: Initialization
  
    init() {
        super.init(nibName: nil, bundle: nil)
        
        #if !DEBUG
            let isNotFirstLaunch = UserDefaults.standard.bool(forKey: "IS_NOT_FIRST_LAUNCH")
            self.currentViewController = !isNotFirstLaunch ? onboardingViewController : mainViewController
        #elseif DEBUG
            self.currentViewController = onboardingViewController
        #endif
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    // MARK: Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(currentViewController)
        currentViewController.view.frame = view.bounds
        view.addSubview(currentViewController.view)
        currentViewController.didMove(toParent: self)
    }
    
    // MARK: Method to change displayed ViewController
  
    func switchToScheduleScreen() {
        let navigationController = UINavigationController(rootViewController: scheduleViewController)
        
        addChild(navigationController)
        navigationController.view.frame = view.bounds
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
        currentViewController.willMove(toParent: nil)
        currentViewController.view.removeFromSuperview()
        currentViewController.removeFromParent()
        currentViewController = navigationController
    }
  
}
