//
//  ErrorViewModel.swift
//  schedule
//
//  Created by Vladislav Glumov on 25.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

struct ErrorViewModel {
    let title: String?
    let description: String
    
    init(_ error: AppError) {
        description = error.localizedDescription
        
        switch error {
        case .noGroupData, .noScheduleData, .isHoliday:
            title = nil
            
        case .serverError:
            title = "Что-то пошло не так"
            
        case .noInternetConnection:
            title = "Ошибка сети"
        }
    }
}
