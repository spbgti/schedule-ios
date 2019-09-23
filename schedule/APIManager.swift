import Foundation

enum APIError: Error {
  case noDataAvailable
}

class APIManager {
  
  // MARK: - Private Constants

  private let pathToAPI = "https://spbgti-tools-schedule-staging.herokuapp.com/api/"
  
  // MARK: - Static Properties 
  
  static var shared = APIManager()
  
  // MARK: - Private Initialization
  
  private init() {}
  
  // MARK: - Public Methods
  
  func getGroups(completion: @escaping (Result<Groups, APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)groups/87")!
    let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
      
      do {
        let groupResponse = try JSONDecoder().decode(Groups.self, from: data!)
        completion(.success(groupResponse))
      } catch {
        completion(.failure(.noDataAvailable))
      }
    }
    dataTask.resume()
  }
  
  // TODO: Return Data like the function "getGroup"
  
  func getSchedules(completion: @escaping(String) -> Void) {
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let url = URL(string: "\(pathToAPI)schedules?year=2019&semester=1&group_number=446")!
    
    let task = session.dataTask(with: url) { (data, response, error) in
      if error != nil {
        completion(error!.localizedDescription)
      } else {
        completion(String(decoding: data!, as: UTF8.self))
      }
    }
    task.resume()
  }
  
  func getExercises(completion: @escaping(String) -> Void) {
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let url = URL(string: "\(pathToAPI)exercises?schedule=147")!
    
    let task = session.dataTask(with: url) { (data, response, error) in
      if error != nil {
        completion(error!.localizedDescription)
      } else {
        completion(String(decoding: data!, as: UTF8.self))
      }
    }
    task.resume()
  }
  
}
