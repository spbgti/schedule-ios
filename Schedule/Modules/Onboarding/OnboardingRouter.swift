//
//  OnboardingRouter.swift
//  schedule
//
//  Created by Vladislav Glumov on 08.12.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

final class OnboardingRouter {
    
    public func routeToMainViewController() {
        let scheduleStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let scheduleViewController = scheduleStoryboard.instantiateInitialViewController() as! MainController
        
        AppDelegate.shared.window?.rootViewController = scheduleViewController
    }
    
}
