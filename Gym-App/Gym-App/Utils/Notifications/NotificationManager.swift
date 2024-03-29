import Foundation

import SwiftUI
import UserNotifications

class NotificationManager: ObservableObject {
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if let error = error {
                print("Notification authorization denied with error: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(notificationTitle: String, notificationBody: String, timeInterval: Double) {
        let content = UNMutableNotificationContent()
        content.title = notificationTitle
        content.body = notificationBody
        content.sound = UNNotificationSound.defaultRingtone // Use default notification sound
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error.localizedDescription)")
            }
        }
    }
    
    func removeAllPendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    func removeAllDeliveredNotifications(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    func removeAllNotifications(){
        self.removeAllPendingNotifications()
        self.removeAllPendingNotifications()
    }
}
