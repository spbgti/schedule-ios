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
  
  // MARK: - Public Method
  func urlSession<T: Codable>(url: URL, type: T.Type,
    completion: @escaping (Result<T, APIError>) -> Void) {
    
    URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure(.noDataAvailable))
        return
      }

      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      
      do {
        let groupResponse = try decoder.decode(type, from: jsonData)
        completion(.success(groupResponse))
      } catch {
        completion(.failure(.noDataAvailable))
      }
    }.resume()
  }
  
}
