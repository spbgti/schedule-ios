//
//  Alert.swift
//  schedule
//
//  Created by vladislav on 03.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

struct Alert {
  
    static func showError(on viewController: UIViewController, with errorType: Errors) {
        let title: String
        let message: String
        
        switch errorType {
        case .dataNotFound:
            title = "error_title-data_not_found".localized
            message = "error_message-data_not_found".localized
         
        case .internalServer:
            title = "error_title-internal_server".localized
            message = "error_message-internal_server".localized
        
        case .localBug:
            title = "error_title-local_bug".localized
            message = "error_message-local_bug".localized
        
        case .networkConnection:
            title = "error_title-network_connection".localized
            message = "error_message-network_connection".localized
        }
            
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)

        alertController.addAction(action)
        viewController.present(alertController, animated: true)
    }
  
}
