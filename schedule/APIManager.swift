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
  
  func getGroup(completion: @escaping (Result<Group, APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)groups/87")!
    
    URLSession.shared.dataTask(with: url) { data, _, _ in
      do {
        let groupResponse = try JSONDecoder().decode(Group.self, from: data!)
        completion(.success(groupResponse))
      } catch {
        completion(.failure(.noDataAvailable))
      }
    }.resume()
  }
  
  func getSchedule(completion: @escaping(Result<Schedule, APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)schedules/147")!
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
      do {
        let scheduleResponse = try JSONDecoder().decode(Schedule.self, from: data!)
        completion(.success(scheduleResponse))
      } catch {
        completion(.failure(.noDataAvailable))
      }
    }.resume()
  }
  
  func getExercise(completion: @escaping(Result<Exercise, APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)exercises/2656")!
    
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
