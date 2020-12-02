import Foundation

class DataProvider: NSObject {
  
    // MARK: Singletone implementation

    static let shared = DataProvider()
    private override init() {}
  
    // MARK: Properties
    
    let dataManager = DataManager()
    let exerciseService = ExercisesService()
    let scheduleService = SchedulesService()
  
    // MARK: Methods
  
    func uploadDataByDay(by day: String, completionHandler: @escaping(Errors?) -> Void) {
        let date = formatToDate(day)
        let groupId = UserDefaults.standard.integer(forKey: "GROUP_ID")

        exerciseService.getExercises(groupId: groupId, date: date) { result in
            switch result {
            case .success(let result):
                self.dataManager.overwrite(result)
                completionHandler(nil)
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
  
    func uploadDataByYear(by year: String, completionHandler: @escaping(Errors?) -> Void) {
        let year = formatToYear(year)
        let groupNumber = UserDefaults.standard.string(forKey: "GROUP_NUMBER")!
        
        scheduleService.getSchedules(year: year, semester: .fall, groupNumber: groupNumber) { result in
            switch result {
            case .success(let result):
                self.dataManager.overwrite(result.first?.exercises ?? Array<Exercise>())
                completionHandler(nil)
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
    
    private func formatToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: string)!
    }
    
    private func formatToYear(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.date(from: string)!
    }
  
}
