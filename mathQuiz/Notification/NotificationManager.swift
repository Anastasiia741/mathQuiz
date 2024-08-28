//  NotificationManager.swift
//  mathQuiz
//  Created by Анастасия Набатова on 26/8/24.

import UserNotifications

final class NotificationManager {

    func requestNotificationPermition() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { gainted, error  in
            if gainted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
    
//    func reminderNotification(userName: String) {
//        let content = UNMutableNotificationContent()
//        content.title = "Hey \(userName)! Time to learn math!"
//        content.body = "It's been a few days since you last studied. Time to learn something new!"
//        content.sound = UNNotificationSound.default
////        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3 * 24 * 60 * 60, repeats: false)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//        let request = UNNotificationRequest(identifier: "StudyMathReminder", content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Failed to schedule notification: \(error)")
//            } else {
//                print("Notification scheduled successfully.")
//            }
//        }
//    }
//    
//    func resetReminderNotification() {
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["StudyMathReminder"])
//        reminderNotification(userName: "")
//    }
//    
//    func updatePushNotifications(enabled: Bool) {
//        if enabled {
//            UNUserNotificationCenter.current().getNotificationSettings { settings in
//                if settings.authorizationStatus == .notDetermined {
//                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//                        if granted {
//                            print("Push notifications enabled")
//                        } else {
//                            print("Push notifications disabled")
//                        }
//                    }
//                }
//            }
//        } else {
//            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//            print("Push notifications disabled")
//        }
//    }
    
    
    
    func updatePushNotifications(enabled: Bool, userName: String) {
            if enabled {
                // Запрашиваем разрешение, если оно ещё не предоставлено
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    if settings.authorizationStatus == .notDetermined {
                        self.requestNotificationPermition()
                    } else if settings.authorizationStatus == .authorized {
                        // Если разрешение уже предоставлено, планируем повторяющиеся уведомления
                        self.scheduleRepeatingNotification(userName: userName)
                    } else {
                        print("Push notifications permission not granted")
                    }
                }
            } else {
                // Удаляем все запланированные уведомления
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                print("Push notifications disabled")
            }
        }
        
        // Метод для планирования повторяющихся уведомлений каждые 3 дня
        private func scheduleRepeatingNotification(userName: String) {
            let content = UNMutableNotificationContent()
            content.title = "Hey \(userName)! Time to learn math!"
            content.body = "It's been a few days since you last studied. Time to learn something new!"
            content.sound = UNNotificationSound.default
            
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3 * 24 * 60 * 60, repeats: true)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "StudyMathReminder", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Failed to schedule notification: \(error)")
                } else {
                    print("Notification scheduled successfully.")
                }
            }
        }
    
}
