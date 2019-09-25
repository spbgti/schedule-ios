import Foundation

struct Group: Codable {
  var group_id: Int
  var number: String
}

struct Exercise: Codable {
  var exercise_id: Int
  var schedule_id: Int
  var room_id: Int
  var teachers: [String]
  var name: String
  var type: String
  var pair: String
  var day: String
  var parity: String?
}

struct Schedule: Codable {
  var schedule_id: Int
  var group_id: Int
  var year: String
  var semester: String
  var exercises: [Exercise]
}
