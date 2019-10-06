import Foundation

// MARK: - Enum of errors
enum APIError: Error {
  case noDataAvailable
  case canNotProccessData
}

class APIManager {
  
  // MARK: - Private Constants
  private let pathToAPI = "https://spbgti-tools-schedule-staging.herokuapp.com/api/"
  
  // MARK: - Static Properties
  static var shared = APIManager()
  
  // MARK: - Private Initialization
  private init() {}
  
  // MARK: - Public Methods
  func getGroupById(completion: @escaping (Result<Group, APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)groups/87")!
    
    URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure(.noDataAvailable))
        return
      }
      
      do {
        let groupResponse = try JSONDecoder().decode(Group.self, from: jsonData)
        completion(.success(groupResponse))
      } catch {
        completion(.failure(.noDataAvailable))
      }
    }.resume()
  }
  
  func getScheduleById(completion: @escaping(Result<Schedule, APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)schedules/147")!
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
      guard let jsonData = data else {
        completion(.failure(.noDataAvailable))
        return
      }
      
      do {
        let scheduleResponse = try JSONDecoder().decode(Schedule.self, from: jsonData)
        completion(.success(scheduleResponse))
      } catch {
        completion(.failure(.canNotProccessData))
      }
    }.resume()
  }
  
  func getExerciseById(completion: @escaping(Result<Exercise, APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)exercises/2656")!
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
      guard let jsonData = data else {
        completion(.failure(.noDataAvailable))
        return
      }
      
      do {
        let exerciseResponse = try JSONDecoder().decode(Exercise.self, from: jsonData)
        completion(.success(exerciseResponse))
      } catch {
        completion(.failure(.noDataAvailable))
      }
    }.resume()
  }
  
  func getGroups(groupName: String, completion: @escaping (Result<[Group], APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)groups?number=\(groupName)")!
    
    URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure(.noDataAvailable))
        return
      }
      
      do {
        let groupResponse = try JSONDecoder().decode([Group].self, from: jsonData)
        completion(.success(groupResponse))
      } catch {
        completion(.failure(.canNotProccessData))
      }
    }.resume()
  }
  
  func getSchedules(completion: @escaping(Result<[Schedule], APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)schedules?year=2019&group_number=446")!
  
    URLSession.shared.dataTask(with: url) { (data, _, _) in
      guard let jsonData = data else {
        completion(.failure(.noDataAvailable))
        return
      }
      
      do {
        let scheduleResponse = try JSONDecoder().decode([Schedule].self, from: jsonData)
        completion(.success(scheduleResponse))
      } catch {
        completion(.failure(.noDataAvailable))
      }
    }.resume()
  }
  
  func getExercises(groupId: String, date: String, completion: @escaping(Result<[Exercise], APIError>) -> Void) {
    let url = URL(string: "\(pathToAPI)exercises?group_id=\(groupId)&date=\(date)")!
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
      guard let jsonData = data else {
        completion(.failure(.noDataAvailable))
        return
      }
      
      do {
        let exerciseResponse = try JSONDecoder().decode([Exercise].self, from: jsonData)
        completion(.success(exerciseResponse))
      } catch {
        completion(.failure(.noDataAvailable))
      }
      }.resume()
  }
  
}
