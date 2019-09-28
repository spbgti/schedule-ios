import Foundation

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

struct Exercises: Codable {
  var listOfExercises: [Exercise]
}

struct Group: Codable {
  var group_id: Int
  var number: String
}

struct Groups: Codable {
  var listOfGroups: [Group]
}

struct Schedule: Codable {
  var schedule_id: Int
  var group_id: Int
  var year: String
  var semester: String
  var exercises: [Exercise] 
}

struct Schedules: Codable {
  var listOfSchedules : [Schedule]
}
