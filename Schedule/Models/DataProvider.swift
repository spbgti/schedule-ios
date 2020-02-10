import Foundation

class DataProvider: NSObject {
  
  // MARK: Singletone implementation
  
  static let shared = DataProvider()
  private override init() {}
  
  // MARK: Properties
  
  let dataManager = DataManager()
  
  // MARK: Methods
  
  func uploadDataByDay(by day: String, completionHandler: @escaping(String?) -> Void) {
    APIManager.shared.getExercises(date: day) { completion in
      switch completion {
      case .success(let result):
        self.dataManager.overwrite(result)
        completionHandler(nil)
      case .failure(let error):
        completionHandler(error)
      }
    }
  }
  
  func uploadDataByYear(by year: String, completionHandler: @escaping(String?) -> Void) {
    APIManager.shared.getSchedules(year: year) { completion in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          self.dataManager.overwrite(result)
          completionHandler(nil)
        case .failure(let error):
          completionHandler(error)
        }
      }
    }
  }
  
}
