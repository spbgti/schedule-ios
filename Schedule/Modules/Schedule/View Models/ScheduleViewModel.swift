//
//  ScheduleViewModel.swift
//  schedule
//
//  Created by Vladislav Glumov on 21.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import Alamofire

final class ScheduleViewModel: NSObject {
    
    // MARK: Services
    
    private let schedulesService: SchedulesService
    
    private let groupService: GroupRepository
    
    private let networkReachability: NetworkReachability
    
    // MARK: View state
    
    private var parity: ScheduleParity = .odd
    
    private var baseDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm"
        return dateFormatter.date(from: "2019-03")!
    }
    
    private var scheduleSemester: ScheduleSemester? {
        ScheduleSemester.semester(baseDate)
    }
    
    private var group: Group?
    
    private var error: AppError! {
        didSet {
            loaderCallback?(false)
            errorCallback?(ErrorViewModel(error))
        }
    }
    
    // MARK: View
    
    var tableHeaderView: String? {
        if let semester = scheduleSemester?.name {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            let year = dateFormatter.string(from: baseDate)
           return "\(year), \(semester)"
        } else {
            return nil
        }
    }
    
    // MARK: Sources
    
    private var exercises: [Exercise]?
    
    // MARK: Data source
    
    private var dataSource: [ScheduleWeek : [Exercise?]] = [:]
    
    // MARK: Data binding
    
    var errorCallback: ((_ error: ErrorViewModel?) -> Void)?
    
    var loaderCallback: ((_ isLoading: Bool) -> Void)?
    
    // MARK: Initializator
    
    override init() {
        schedulesService = SchedulesService()
        groupService = GroupRepository()
        networkReachability = NetworkReachability(with: "Schedule_Module")
        
        super.init()
        networkReachability.delegate = self
    }
    
    // MARK: Deinitializator
    
    deinit {
        networkReachability.stopListenNetworkReachability()
    }
    
    // MARK: Service methods
    
    private func getGroup() {
        loaderCallback?(true)
        
        groupService.getGroup { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let group):
                    self?.group = group
                    self?.getSchedule()
                    
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
    
    private func getSchedule() {
        guard let groupNumber = group?.number else {
            error = .noGroupData
            return
        }
        
        guard let semester = scheduleSemester else {
            error = .isHoliday
            return
        }
        
        schedulesService.getSchedules(year: baseDate, semester: semester, groupNumber: groupNumber) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let schedules):
                    if let schedule = schedules.first {
                        self?.exercises = schedule.exercises
                        self?.sortByWeekday(schedule.exercises)
                    } else {
                        self?.error = .noScheduleData
                    }
                    
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
    
    // MARK: Interface methods
    
    func viewDidLoad() {
        networkReachability.listenNetworkReachability()
    }
    
    func switchParity(_ parity: ScheduleParity) {
        self.parity = parity
        
        if let exercises = exercises {
            sortByWeekday(exercises)
        }
    }
    
    // MARK: Sorting methods
    
    private func sortByWeekday(_ exercises: [Exercise]) {
        ScheduleWeek.allCases.forEach { [weak self] key in
            let exercise = exercises.filter { $0.day == String(key.rawValue) }
            self?.dataSource[key] =  self?.sortByParity(exercise)
        }
        
        loaderCallback?(false)
    }

    private func sortByParity(_ exercises: [Exercise]) -> [Exercise?] {
        SchedulePair.allCases.map { pair in
            let dayExercises = exercises.filter { $0.pair == pair.rawValue }
            
            if dayExercises.count > 1 {
                let parityDays = dayExercises.filter { [weak self] in $0.parity == self?.parity.rawValue }
                
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

// MARK: NetworkReachabilityDelegate implementation

extension ScheduleViewModel: NetworkReachabilityDelegate {
    func networkReachability(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        if dataSource.count == 0 {
            getGroup()
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
