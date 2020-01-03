//
//  Alert.swift
//  schedule
//
//  Created by vladislav on 03.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

struct Alert {
  
  static func showBasicAlert(on viewController: UIViewController, message: String, with title: String) {
    let alertController = UIAlertController(title: title, message: message
      , preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    
    alertController.addAction(action)
    DispatchQueue.main.async {
      viewController.present(alertController, animated: true)
    }
  }
  
}
