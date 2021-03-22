//
//  ScheduleViewModel.swift
//  schedule
//
//  Created by Vladislav Glumov on 21.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

final class ScheduleViewModel: NSObject {
    
    // MARK: Services
    
    private var schedulesService: SchedulesService
    
    private var groupService: GroupRepository
    
    
    // MARK: View state
    
// FIXME: create a parity model
    private var parity = "1"
    
    private var baseDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.date(from: "2019")!
    }
    
    private var group: Group?
    
    private var error: String?
    
    
    // MARK: Sources
    
    private var exercises: [Exercise]?
    
    
    // MARK: Data source
    
    private var dataSource: [ScheduleWeek : [Exercise?]] = [:]
    
    
    // MARK: Data binding
    
// FIXME: create callback with error parameter
    
    var callback: (() -> Void)?
    
    
    // MARK: Initializator
    
    override init() {
        schedulesService = SchedulesService()
        groupService = GroupRepository()
    }
    
    
    // MARK: Methods interface
    
    func getGroup() {
        groupService.getGroup { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let group):
                    self?.group = group
                    self?.getSchedule()
                    
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
    
    func getSchedule() {
        guard let groupNumber = group?.number else {
            error = "Номер группы не определен"
            return
        }
        
// FIXME: define a semester by base date
        schedulesService.getSchedules(year: baseDate, semester: .spring, groupNumber: groupNumber) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let schedules):
                    if let schedule = schedules.first {
                        self?.exercises = schedule.exercises
                        self?.sortByWeekday(schedule.exercises)
                    } else {
                        self?.error = "Расписание не найдено"
                    }
                    
                case .failure(_):
                    self?.error = "Расписание не найдено"
                }
            }
        }
    }
    
    func switchParity(_ index: Int) {
        parity = String(index + 1)
// FIXME: Unwrap optional type
        sortByWeekday(exercises!)
    }
    
    // MARK: Sorting methods
    
    private func sortByWeekday(_ exercises: [Exercise]) {
        ScheduleWeek.allCases.forEach { [weak self] key in
            let exercise = exercises.filter { $0.day == String(key.rawValue) }
            self?.dataSource[key] =  self?.sortByParity(exercise)
        }
        
        callback?()
    }
    
// FIXME: create pair model instead of sequence (1...5)
    
    private func sortByParity(_ exercises: [Exercise]) -> [Exercise?] {
        (1...5).map { index in
            let dayExercises = exercises.filter { $0.pair == String(index) }
            
            if dayExercises.count > 1 {
                let parityDays = dayExercises.filter { [weak self] in $0.parity == self?.parity }
                
                if let parityDay =  parityDays.first {
                    return parityDay
                } else {
                    let parityDay = dayExercises.filter { $0.parity == nil }
                    return parityDay.first
                }
            } else  {
                return dayExercises.first
            }
        }
    }
    
}


// MARK: UITableViewDataSource methods implementation

extension ScheduleViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = ScheduleWeek.allCases[section]
        let numberOfExercise = dataSource[sectionKey]!.count
        return numberOfExercise > 0 ? numberOfExercise : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionKey = ScheduleWeek.allCases[indexPath.section]
        let dataSource = self.dataSource[sectionKey]!
        
        if dataSource.count > 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTVCell", for: indexPath) as? ExerciseTVCell else {
                fatalError()
            }
            
            let model = dataSource[indexPath.item]
            
            cell.selectionStyle = .none
            cell.pair = String(indexPath.item + 1)
            cell.set(model)
            cell.layoutIfNeeded()
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DayOffTVCell", for: indexPath) as? DayOffTVCell else {
                fatalError()
            }
            
            cell.selectionStyle = .none
            cell.title = "Нет пар"
            cell.layoutIfNeeded()
            
            return cell
        }
    }

}
