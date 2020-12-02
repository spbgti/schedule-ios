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
    
    public var callback: ((_ error: Errors?) -> Void)?
    
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
                }
                self?.callback?(nil)
                
            case .failure(let error):
                self?.callback?(error)
            }
        }
    }
    
}
