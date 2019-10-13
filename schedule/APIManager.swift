import Foundation

// MARK: - Enum of errors
enum APIError: Error {
  case noDataAvailable
  case canNotProccessData
}

// MARK: - Class APIManager
class APIManager {
  
  // MARK: - Static Properties
  static var shared = APIManager()
  
  // MARK: - Private Initialization
  private init() {}
  
  // MARK: - Public Method
  func urlSession(url: URL, completion: @escaping(Result<Data, APIError>) -> Void) {
    
    URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure(.noDataAvailable))
        return
      }
      completion(.success(jsonData))
    }.resume()
  }
  
}
