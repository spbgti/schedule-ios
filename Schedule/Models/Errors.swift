//
//  Errors.swift
//  schedule
//
//  Created by Vladislav Glumov on 03.12.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum Errors: Error {
    case localBug
    case internalServer
    case networkConnection
    case dataNotFound
}

extension Errors {
    var localizedDescription: String {
        switch self {
        case .localBug:
            return "error_message-local_bug".localized
            
        case .internalServer:
            return "error_message-internal_server".localized
            
        case .networkConnection:
            return "error_message-network_connection".localized
            
        case .dataNotFound:
            return "error_message-data_not_found".localized
        }
    }
}
