//
//  AppError.swift
//  schedule
//
//  Created by Vladislav Glumov on 25.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

enum AppError: Error {
    case noGroupData
    case noScheduleData
    
    case isHoliday
    
    case serverError
    case noInternetConnection
}

extension AppError {
    var localizedDescription: String {
        switch self {
        case .noGroupData:
            return "Номер группы не найден"
            
        case .noScheduleData:
            return "Расписание не найдено"
            
        case .isHoliday:
            return "Лето, солнце, жара... или нет"
            
        case .serverError:
            return "Уже устраняем проблему. Попробуйте позже"
            
        case .noInternetConnection:
            return "Отсутствует или слабое соединение с интернетом"
        }
    }
}
