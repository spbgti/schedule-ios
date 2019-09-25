import Foundation

// TODO: FIX THIS CODE
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
    
    URLSession.shared.dataTask(with: url) { data, _, _ in
      do {
        let groupResponse = try JSONDecoder().decode(Groups.self, from: data!)
        completion(.success(groupResponse))
      } catch {
        completion(.failure(.noDataAvailable))
      }
    }.resume()
  }
  
  func getSchedules(completion: @escaping(Result<Schedule, APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)schedules?year=2019&semester=1&group_number=446")!
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
      do {
        let scheduleResponse = try JSONDecoder().decode(Schedule.self, from: data!)
        completion(.success(scheduleResponse))
      } catch {
        completion(.failure(.noDataAvailable))
      }
    }.resume()
  }
  
  func getExercises(completion: @escaping(Result<Exercise, APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)exercises?schedule=147")!
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
      do {
        let exerciseResponse = try JSONDecoder().decode(Exercise.self, from: data!)
        completion(.success(exerciseResponse))
      } catch {
        completion(.failure(.noDataAvailable))
      }
    }.resume()
  }
  
}
