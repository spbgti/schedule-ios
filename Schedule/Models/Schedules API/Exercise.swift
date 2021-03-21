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
    
    enum CodingKeys: String, CodingKey {
        case exerciseId = "exercise_id"
        case scheduleId = "schedule_id"
        case roomId = "room_id"
        case teachers
        case name
        case type
        case pair
        case day
        case parity
    }
}
