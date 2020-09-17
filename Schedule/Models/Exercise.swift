import Foundation

struct Exercise: Codable {
    let exerciseId: Int
    let scheduleId: Int
    let roomId: Int
    let teachers: [String]
    let name: String
    let type: String
    let pair: String
    let day: String
    let parity: String?
  
    subscript() -> String {
        return day
    }
}
