import Foundation

class APIManager {
  
  // MARK: - Private Constants

  private let pathToAPI = "https://spbgti-tools-schedule-staging.herokuapp.com/api/"
  
  // MARK: - Public Properties
  
  static var shared = APIManager()
  
  // MARK: - Public Methods
  
  public func getGroup(completion: @escaping (String) -> Void) {
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let url = URL(string: "\(pathToAPI)groups/87")!
    
    let task = session.dataTask(with: url) { (data, response, error) in
        if error != nil {
          completion(error!.localizedDescription)
        } else {
          completion(self.convertJSON(jsonData: String(decoding: data!, as: UTF8.self)))
        }
    }
    task.resume()
  }
  
  // MARK: - Private Methods
  
  private func convertJSON(jsonData str: String) -> String {
    let data = Data(str.utf8)
    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    
    return json?["number"] as! String
  }
  
}
