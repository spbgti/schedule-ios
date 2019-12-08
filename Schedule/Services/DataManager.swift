import Foundation

class DataManager {
  
  static var shared = DataManager()
  private init() {}
  
  func getGroups(groupName: String, completionHandler: @escaping(Result<[Group]>) -> Void) {
    let urlRequest = "groups?number=\(groupName)"
    
    APIManager.shared.getData(url: urlRequest, isCache: false) { (completion: Result<[Group]>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          if result.count != 0 {
            completionHandler(.success(result))
          } else {
            completionHandler(.failure("Invalid group number. Check your setting"))
          }
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
  func getExercises(groupId: String, date: String, completionHandler: @escaping(Result<[Exercise]>) -> Void) {
    let urlRequest = "exercises?group_id=\(groupId)&date=\(date)"

    APIManager.shared.getData(url: urlRequest, isCache: true) { (completion: Result<[Exercise]>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          completionHandler(.success(result))
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
  func getExercisesByGroupName(groupName: String, date: String,
   completionHandler: @escaping(Result<[Exercise]>) -> Void) {
    
    getGroups(groupName: groupName) { groupCompletion in
      DispatchQueue.main.async {
        switch groupCompletion {
        case .success(let result):
          self.getExercises(groupId: String(result[0].groupId), date: date) { exercisesCompletion in
            switch exercisesCompletion {
            case .success(let result):
              completionHandler(.success(result))
            case .failure(let error):
              completionHandler(.failure(error))
            }
          }
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
  func getSchedules(year: String, groupNumber: String, completionHandler: @escaping(Result<[Schedule]>) -> Void) {
    let urlRequest = "schedules?year=\(year)&group_number=\(groupNumber)"

    getGroups(groupName: groupNumber) { groupCompletion in
      DispatchQueue.main.async{
        switch groupCompletion {
        case .success( _):
          APIManager.shared.getData(url: urlRequest, isCache: true) { (scheduleCompletion: Result<[Schedule]>) in
            switch scheduleCompletion {
            case .success(let result):
              completionHandler(.success(result))
            case .failure(let error):
              completionHandler(.failure(error))
            }
          }
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
}
