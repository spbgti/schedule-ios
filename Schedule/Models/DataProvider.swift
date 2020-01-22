import Foundation

class DataProvider {
  
  // MARK: Singletone implementation
  
  static let shared = DataProvider()
  private init() {}
  
  // MARK: Properties
  
  private let dataManager = DataManager()
  private let pathToAPI = "https://spbgti-tools-schedule-staging.herokuapp.com/api/"
  
  // MARK: Methods
  
  func getGroups(groupName: String, completionHandler: @escaping(Result<[Group]>) -> Void) {
    let urlRequest = "\(pathToAPI)groups?number=\(groupName)"

    APIManager.shared.getData(url: urlRequest) { completion in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          if result.count != 0 {
            JSONDecoderManager.shared.decode(from: result) { (jsonCompletion: Result<[Exercise]>) in
              switch jsonCompletion {
              case .success(let jsonResult):
                self.dataManager.overwrite(jsonResult)
              case .failure(let errorFromDecoder):
                completionHandler(errorFromDecoder)
              }
            }
          } else {
            completionHandler(.failure("Invalid group number. Check your setting"))
          }
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
  func getExercises(groupId: String, date: String, completionHandler: @escaping(String?) -> Void) {
    let urlRequest = "\(pathToAPI)exercises?group_id=\(groupId)&date=\(date)"

    APIManager.shared.getData(url: urlRequest) { completion in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          JSONDecoderManager.shared.decode(from: result) { (jsonCompletion: Result<[Exercise]>) in
            switch jsonCompletion {
            case .success(let jsonResult):
              self.dataManager.overwrite(jsonResult)
            case .failure(let errorFromDecoder):
              completionHandler(errorFromDecoder)
            }
          }
        case .failure(let error):
          completionHandler(error)
        }
      }
    }
  }

  func getSchedules(groupNumber: String, completionHandler: @escaping(String?) -> Void) {
    let urlRequest = "\(pathToAPI)schedules?year=\(Date.year)&group_number=\(groupNumber)"

    APIManager.shared.getData(url: urlRequest) { completion in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          JSONDecoderManager.shared.decode(from: result) { (jsonCompletion: Result<[Schedule]>) in
            switch jsonCompletion {
            case .success(let jsonResult):
              self.dataManager.overwrite(jsonResult)
            case .failure(let errorFromDecoder):
              completionHandler(errorFromDecoder)
            }
          }
        case .failure(let error):
          completionHandler(error)
        }
      }
    }
  }
  
}
