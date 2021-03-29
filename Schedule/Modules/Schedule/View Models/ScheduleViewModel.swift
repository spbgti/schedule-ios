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
    
    private let groupService: GroupRepository
    
    private let schedulesService: SchedulesService
    
    private let roomService: RoomsService
    
    private let exersiceTimeService: ExerciseTimeService
    
    private let locationService: LocationsService
    
    // MARK: Network reachability
    
    private let networkReachability: NetworkReachability
    
    // MARK: Group dispatch queue
    
    private let dispatchGroup = DispatchGroup()
    
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
    
    private var error: AppError? {
        didSet {
            if let error = error {
                errorCallback?(ErrorViewModel(error))
            } else {
                errorCallback?(nil)
            }
            
            loaderCallback?(false)
        }
    }
    
    // MARK: View
    
    var tableHeaderView: String? {
        if let semester = scheduleSemester?.name {
           return "\(semester)"
        } else {
            return nil
        }
    }
    
    // MARK: Sources
    
    private var group: Group?
    
    private var exercises: [Exercise]?
    
    private var exerciseTime: [ExerciseTime]?
    
    private var rooms: [Room]?
    
    private var locations: [Location]?
    
    // MARK: Data source
    
    private var dataSource: [ScheduleWeek : [Exercise?]] = [:]
    
    // MARK: Data binding
    
    var errorCallback: ((_ error: ErrorViewModel?) -> Void)?
    
    var loaderCallback: ((_ isLoading: Bool) -> Void)?
    
    var dataCallback: (() -> Void)?
    
    // MARK: Initializator
    
    override init() {
        schedulesService = SchedulesService()
        groupService = GroupRepository()
        exersiceTimeService = ExerciseTimeService()
        roomService = RoomsService()
        locationService = LocationsService()
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
        error = nil
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
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let schedules):
                    if let schedule = schedules.first {
                        self?.exercises = schedule.exercises
                        self?.getTime()
                        self?.getRooms()
                        self?.getLocations()
                        
                        self?.dispatchGroup.notify(queue: .main) {
                            self?.sortByWeekday(schedule.exercises)
                        }
                        
                    } else {
                        self?.error = .noScheduleData
                    }
                    
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
    
    private func getTime() {
        dispatchGroup.enter()
        
        exersiceTimeService.get { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let time):
                    self?.exerciseTime = time
                    
                case .failure(let error):
                    print(error)
                }
                
                self?.dispatchGroup.leave()
            }
        }
    }
    
    private func getRooms() {
        dispatchGroup.enter()
        
        roomService.getRooms(name: nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let rooms):
                    self?.rooms = rooms
                    
                case .failure(let error):
                    print(error)
                }
                
                self?.dispatchGroup.leave()
            }
        }
    }
    
    private func getLocations() {
        dispatchGroup.enter()
        
        locationService.getLocations(name: nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    self?.locations = locations
                    
                case .failure(let error):
                    print(error)
                }
                
                self?.dispatchGroup.leave()
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
            self?.dataSource[key] = self?.sortByParity(exercise)
        }
        
        loaderCallback?(false)
        dataCallback?()
    }

    private func sortByParity(_ exercises: [Exercise]) -> [Exercise?] {
        SchedulePair.allCases.map { pair in
            let dayExercises = exercises.filter { $0.pair == pair.rawValue }
            
            if dayExercises.count > 1 {
                let parityDays = dayExercises.filter { [weak self] in $0.parity == self?.parity.rawValue }
                
                if let parityDay = parityDays.first {
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
        let exercise = dataSource[indexPath.item]
        
        if dataSource.count > 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as? ExerciseCell else {
                fatalError("Unkonw 'ExerciseCell' type")
            }
            
            if let exercise = exercise {
                let time = exerciseTime![indexPath.item]
                let room = rooms!.first(where: { $0.roomId == exercise.roomId })!
                let location = locations!.first(where: { $0.locationId == room.locationId })
                let cellModel = ExerciseCellModel(exercise: exercise, time: time, room: room, location: location)
                
                cell.set(cellModel)
            } else {
                cell.pair = String(indexPath.item + 1)
                cell.time = "\(exerciseTime![indexPath.item].start) - \(exerciseTime![indexPath.item].end)"
                cell.set(nil)
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DayOffCell",
                                                           for: indexPath) as? DayOffCell else {
                fatalError("Unkonw 'DayOffCell' type")
            }
            
            cell.title = "Нет пар"
            
            return cell
        }
    }

}
