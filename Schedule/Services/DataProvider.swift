import Foundation

class DataProvider {
  
  // MARK: Singletone implementation
  
  static let shared = DataProvider()
  private init() {}
  
  // MARK: Properties
  
  private let pathToAPI = "https://spbgti-tools-schedule-staging.herokuapp.com/api/"
  
  // MARK: Methods
  
  func getGroups(groupName: String) {
    let urlRequest = "\(pathToAPI)groups?number=\(groupName)"
    
    APIManager.shared.getData(url: urlRequest) { (completion: Result<Data>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          if result.count != 0 {
            let object = JSONDecoderManager.shared.decode(from: result, type: [Group])
//            completionHandler(.success(object))
          } else {
//            completionHandler(.failure("Invalid group number. Check your setting"))
          }
        case .failure(let error):
          // Show message
        }
      }
    }
  }
  
  func getExercises(groupId: String, date: String, completionHandler: @escaping(Result<[Exercise]>) -> Void) {
    let urlRequest = "\(pathToAPI)exercises?group_id=\(groupId)&date=\(date)"

    APIManager.shared.getData(url: urlRequest) { (completion: Result<[Exercise]>) in
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
    let urlRequest = "\(pathToAPI)schedules?year=\(year)&group_number=\(groupNumber)"

    getGroups(groupName: groupNumber) { groupCompletion in
      DispatchQueue.main.async{
        switch groupCompletion {
        case .success( _):
          APIManager.shared.getData(url: urlRequest) { (scheduleCompletion: Result<[Schedule]>) in
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
