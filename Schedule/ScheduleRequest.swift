import Foundation

class ScheduleRequest {
  
  private let pathToAPI = "https://spbgti-tools-schedule-staging.herokuapp.com/api/"
  
  static var shared = ScheduleRequest()
  
  private init() {}
  
  func getGroups(groupName: String, completionHandler: @escaping([Group]) -> Void) {
    let urlString = URL(string: "\(pathToAPI)groups?number=\(groupName)")!
    
    APIManager.shared.urlSession(url: urlString) { completion in
      DispatchQueue.main.async {
        switch completion {
        case .failure(let error):
          if error == .noDataAvailable {
            print("noDataAvailable")
          } else {
            print("canNotProccessData")
          }
        case .success(let result):
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          
          let objectData = try? decoder.decode([Group].self, from: result)
          completionHandler(objectData!)
        }
      }
    }
  }
  
  func getExercises(groupId: String, date: String, completionHandler: @escaping([Exercise]) -> Void) {
    let urlString = URL(string: "\(pathToAPI)exercises?group_id=\(groupId)&date=\(date)")!

    APIManager.shared.urlSession(url: urlString) { completion in
      DispatchQueue.main.async {
        switch completion {
        case .failure(let error):
          if error == .noDataAvailable {
            print("noDataAvailable")
          } else {
            print("canNotProccessData")
          }
        case .success(let result):
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          
          let objectData = try? decoder.decode([Exercise].self, from: result)
          completionHandler(objectData!)
        }
      }
    }
  }
  
  func getSchedules(year: String, groupNumber: String, completionHandler: @escaping([Schedule]) -> Void) {
    let urlString = URL(string: "\(pathToAPI)schedules?year=\(year)&group_number=\(groupNumber)")!

    APIManager.shared.urlSession(url: urlString) { completion in
      DispatchQueue.main.async {
        switch completion {
        case .failure(let error):
          if error == .noDataAvailable {
            print("noDataAvailable")
          } else {
            print("canNotProccessData")
          }
        case .success(let result):
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          
          let objectData = try? decoder.decode([Schedule].self, from: result)
          completionHandler(objectData!)
        }
      }
    }
  }
  
}
