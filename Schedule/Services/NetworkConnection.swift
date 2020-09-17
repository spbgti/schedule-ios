import Foundation

class NetworkConnection {
  
  // MARK: Singletone Implementation
  
  static var shared = NetworkConnection()
  private init() {}
  
  // MARK: Methods
  
  func getData<T: Decodable>(url: String, completion: @escaping(Result<T>) -> Void) {
    guard let url = URL(string: "\(url)") else { return completion(.failure("Invalid URL")) }
    let request = URLRequest(url: url)
    
    createAndRetrieveURLSession().dataTask(with: request) { (data, response, error) in
      guard error == nil else {
        return completion(.failure(error!.localizedDescription))
      }
      
      guard let response = response as? HTTPURLResponse,
        (200...299).contains(response.statusCode) else {
          return completion(.failure("Response error"))
      }
      
      if let data = data {
        let resultOfJsonDecoder = JSONDecoderManager.shared.decode(from: data, type: T.self)
        switch resultOfJsonDecoder {
        case .success(let result):
          completion(.success(result))
        case .failure(let error):
          completion(.failure(error))
        }
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

