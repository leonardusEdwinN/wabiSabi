//
//  TimerReminderModel.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 01/12/21.
//

import Foundation

import Foundation

struct TimerReminderModel: Identifiable, Codable {
  var id = UUID().uuidString
  var name: String
  var completed = false
  var reminderEnabled = false
  var reminder: ReminderModel
}

enum ReminderType: Int, CaseIterable, Identifiable, Codable {
  case time
  case calendar
  case location
  var id: Int { self.rawValue }
}

struct ReminderModel: Codable {
  var timeInterval: TimeInterval?
  var date: Date?
//  var location: LocationReminder?
  var reminderType: ReminderType = .time
  var repeats = false
}

//struct LocationReminder: Codable {
//  var latitude: Double
//  var longitude: Double
//  var radius: Double
//}
