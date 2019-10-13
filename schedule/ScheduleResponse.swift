import Foundation

struct Exercise: Codable {
  var exerciseId: Int
  var scheduleId: Int
  var roomId: Int
  var teachers: [String]
  var name: String
  var type: String
  var pair: String
  var day: String
  var parity: String?
}

struct Group: Codable {
  var groupId: Int
  var number: String
}

struct Schedule: Codable {
  var scheduleId: Int
  var groupId: Int
  var year: String
  var semester: String
  var exercises: [Exercise] 
}
