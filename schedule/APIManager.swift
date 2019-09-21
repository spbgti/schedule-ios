import Foundation

class APIManager {
  
  // MARK: - Private Constants

  private let pathToAPI = "https://spbgti-tools-schedule-staging.herokuapp.com/api/"
  
  // MARK: - Static Fields
  
  static var shared = APIManager()
  
  // MARK: - Initialization
  
  private init() {}
  
  // MARK: - Public Methods
  
  public func getGroups(completion: @escaping (String) -> Void) {
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let url = URL(string: "\(pathToAPI)groups/87")!
    
    let task = session.dataTask(with: url) { (data, response, error) in
        if error != nil {
          completion(error!.localizedDescription)
        } else {
          completion(String(decoding: data!, as: UTF8.self))
        }
    }
    task.resume()
  }
  
  public func getSchedules(completion: @escaping(String) -> Void) {
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
  
  public func getExercises() {
    // TODO: Write function
  }
  
}
