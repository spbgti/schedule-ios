import Foundation

// MARK: - Class APIManager
class APIManager {
  
  // MARK: - Cache Setting
  private let allowedDiskSize = 100 * 1024 * 1024
  private lazy var cache: URLCache = {
    return URLCache(memoryCapacity: 0, diskCapacity: allowedDiskSize, diskPath: "scheduleCache")
  }()
  
  // MARK: - Path to API Server
  private let pathToAPI = "https://spbgti-tools-schedule-staging.herokuapp.com/api/"
  
  // MARK: - Singletone Implementation
  static var shared = APIManager()
  private init() {}
  
  // MARK: - 'GET' Request
  func getData<T: Decodable>(url: String, isCache: Bool, completion: @escaping(Result<T>) -> Void) {
    guard let url = URL(string: "\(pathToAPI + url)") else { return completion(.failure("Invalid URL")) }
    
    let cache = URLCache.shared
    let request = URLRequest(url: url)
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    
    if let data = self.cache.cachedResponse(for: request)?.data {
      do {
        let objectFromJSON = try jsonDecoder.decode(T.self, from: data)
        completion(.success(objectFromJSON))
      } catch let error {
        completion(.failure(error.localizedDescription))
      }
      
    } else {
      createAndRetrieveURLSession().dataTask(with: request) { (data, response, error) in
        guard error == nil else { return completion(.failure(error!.localizedDescription)) }
        
        guard let response = response as? HTTPURLResponse,
          (200...299).contains(response.statusCode) else {
            return completion(.failure("Response error"))
        }
        
        guard let data = data else { return completion(.failure(error!.localizedDescription)) }
        
        if isCache {
          let cacheData = CachedURLResponse(response: response, data: data)
          cache.storeCachedResponse(cacheData, for: request)
        }
        
        do {
          let objectFromJSON = try jsonDecoder.decode(T.self, from: data)
          completion(.success(objectFromJSON))
          
        } catch let error {
          completion(.failure(error.localizedDescription))
        }
      }.resume()
    }
  }
  
  // MARK: - URLSession Configuration
  private func createAndRetrieveURLSession() -> URLSession {
    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
    sessionConfiguration.urlCache = cache
    return URLSession(configuration: sessionConfiguration)
  }
  
}
