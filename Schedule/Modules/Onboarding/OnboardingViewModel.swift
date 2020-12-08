//
//  OnboardingViewModel.swift
//  schedule
//
//  Created by Vladislav Glumov on 27.11.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

final class OnboardingViewModel {
    
    private var service: GroupsService
    
    public var callback: ((_ error: String?) -> Void)?
    
    init() {
        self.service = GroupsService()
    }
    
    public func fetchGroup(by numberOfGroup: String) {
        service.getGroups(number: numberOfGroup) { [weak self] result in
            switch result {
            case .success(let groups):
                if groups.count > 0 {
//  TODO: Save a group object to local persistent storage
                    debugPrint(groups[0])
                    
                    DispatchQueue.main.async {
                        self?.callback?(nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.callback?("error_message-data_not_found".localized)
                    }
                }
                
            case .failure(let error):
                let errorMessage: String
                
                switch error {
                case .dataNotFound:
                    errorMessage = "error_message-data_not_found".localized
                case .internalServer:
                    errorMessage = "error_message-internal_server".localized
                case .localBug:
                    errorMessage = "error_message-local_bug".localized
                case .networkConnection:
                    errorMessage = "error_message-network_connection".localized
                }
                
                DispatchQueue.main.async {
                    self?.callback?(errorMessage)
                }
            }
        }
    }
    
}
