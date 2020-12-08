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
    private var router = OnboardingRouter()
    
    public var callback: ((_ error: Errors?) -> Void)?
    
    init() {
        self.service = GroupsService()
    }
    
    public func fetchGroup(by numberOfGroup: String) {
        service.getGroups(number: numberOfGroup) { [weak self] result in
            switch result {
            case .success(let groups):
                if groups.count > 0 {
                    self?.save(group: groups[0])
                    
                    DispatchQueue.main.async {
                        self?.callback?(nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.callback?(.dataNotFound)
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.callback?(error)
                }
            }
        }
    }
    
    private func save(group: Group) {
        let key: String = UserDefaults.Key.group
        let encoder = JSONEncoder()
        
        do {
            let json = try encoder.encode(group)
            NSLog("Onboarding module: group saved successfuly")
            
            UserDefaults.standard.set(json, forKey: key)
            router.routeToMainViewController()
        } catch {
            NSLog("Onboarding module: error to try save a group")
            self.callback?(.localBug)
        }
    }
    
}
