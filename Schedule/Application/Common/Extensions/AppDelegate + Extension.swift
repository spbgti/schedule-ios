//
//  AppDelegate + Extension.swift
//  schedule
//
//  Created by vladislav on 28.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension AppDelegate {
  static var shared: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
  
  var rootViewController: RootViewController {
    return window!.rootViewController as! RootViewController
  }
  
}
