import Foundation

class APIManager {
  
  // MARK: Singletone Implementation
  
  static var shared = APIManager()
  private init() {}
  
  // MARK: Methods
  
  func getData(url: String, completion: @escaping(Result<Data>) -> Void) {
    guard let url = URL(string: "\(url)") else { return completion(.failure("Invalid URL")) }
    
    let request = URLRequest(url: url)
    
    createAndRetrieveURLSession().dataTask(with: request) { (data, response, error) in
      guard error == nil else { return completion(.failure(error!.localizedDescription)) }
      
      guard let response = response as? HTTPURLResponse,
        (200...299).contains(response.statusCode) else {
          return completion(.failure("Response error"))
      }
      
      if let data = data {
        completion(.success(data))
      } else {
        completion(.failure(error!.localizedDescription))
      }
    }.resume()
  }
  
  // URLSession Configuration
  private func createAndRetrieveURLSession() -> URLSession {
    let sessionConfiguration = URLSessionConfiguration.default
    
    return URLSession(configuration: sessionConfiguration)
  }
  
}
