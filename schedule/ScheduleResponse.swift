import Foundation

struct Groups: Codable {
  var group_id: Int
  var number: String
}

struct Exercise: Codable {
  var exercise_id: Int
  var schedule_id: String
  var room_id: String
  var teachers: String
  var name: String
  var typr: String
  var pair: String
  var day: String
  var parity: String
}

struct Schedule: Codable {
  var schedule_id: Int
  var group_id: Int
  var year: String
  var semester: String
  var exercises: Exercise
}
