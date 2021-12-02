//
//  NotificationManager.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 01/12/21.
//

import Foundation
import UserNotifications
enum NotificationManagerConstants {
  static let timeBasedNotificationThreadId =
    "TimeBasedNotificationThreadId"
  static let calendarBasedNotificationThreadId =
    "CalendarBasedNotificationThreadId"
  static let locationBasedNotificationThreadId =
    "LocationBasedNotificationThreadId"
}

class NotificationManager: ObservableObject {
  static let shared = NotificationManager()
  @Published var settings: UNNotificationSettings?
    
    func requestAuthorization(completion: @escaping  (Bool) -> Void) {
      UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
            self.fetchNotificationSettings()

          completion(granted)
        }
    }

    func fetchNotificationSettings() {
      // 1
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        // 2
        DispatchQueue.main.async {
          self.settings = settings
        }
      }
    }
    
    
//    // 1
//    func scheduleNotification(task: TimerReminderModel) {
//      // 2
//      let content = UNMutableNotificationContent()
//        content.title = task.alertTitle
//      content.body = "Gentle reminder for your task!"
//
//
//        //di ubah dulu jadi reminder
//      // 3
//      var trigger: UNNotificationTrigger?
//
//
//          trigger = UNCalendarNotificationTrigger(
//            dateMatching: Calendar.current.dateComponents(
//              [.day, .month, .year, .hour, .minute],
//              from: task.timestamp),
//            repeats: false)
//
//        content.threadIdentifier =
//          NotificationManagerConstants.calendarBasedNotificationThreadId
//
//
//      // 4
//      if let trigger = trigger {
//        let request = UNNotificationRequest(
//          identifier: task.id,
//          content: content,
//          trigger: trigger)
//        // 5
//        UNUserNotificationCenter.current().add(request) { error in
//          if let error = error {
//            print(error)
//          }
//        }
//      }
//    }

}



    



