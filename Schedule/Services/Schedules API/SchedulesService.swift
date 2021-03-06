//
//  SchedulesService.swift
//  schedule
//
//  Created by vladislav on 30.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum AcademicSemester: String {
    case fall = "1"
    case spring = "2"
}

class SchedulesService {
    
    private let provider = NetworkProvider<SchedulesEndpoint>()
    
    func getSchedules(year: Date, semester: AcademicSemester, groupNumber: String, completion: @escaping (Result<[Schedule]>) -> Void) {
        let yearString = dateFormatter(year)
        let semesterString = semester.rawValue
        
        provider.request(.get(year: yearString, semester: semesterString, groupNumber: groupNumber)) { (result: Result<[Schedule]>) in
            switch result {
            case .success(let schedules):
                completion(.success(schedules))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
    func getSchedule(id: Int, completion: @escaping (Result<Schedule>) -> Void) {
        provider.request(.getBy(id: id)) { (result: Result<Schedule>) in
            switch result {
            case .success(let schedule):
                completion(.success(schedule))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
    private func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }
    
}
