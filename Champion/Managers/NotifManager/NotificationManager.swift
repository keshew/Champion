import UserNotifications
import SwiftUI

class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { success, error in
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleNotificationEvent(event: TaskModel) {
        let content = UNMutableNotificationContent()
        content.title = "Champion"
        content.body = event.typeActivity.rawValue
        content.sound = .default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: event.date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: event.time)
        
        guard let eventDateTime = calendar.date(
            bySettingHour: timeComponents.hour ?? 0,
            minute: timeComponents.minute ?? 0,
            second: 0,
            of: calendar.date(from: dateComponents)!
        ) else {
            print("Invalid date components")
            return
        }
        

        guard let notificationDate = calendar.date(
            byAdding: .minute,
            value: -0,
            to: eventDateTime
        ) else {
            print("Failed to calculate notification date")
            return
        }
        
        guard notificationDate > Date() else {
            print("Notification time is in the past")
            return
        }
        
        let triggerComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: notificationDate
        )
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: triggerComponents,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: event.id,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func scheduleNotificationTask(task: TaskModel) {
        let content = UNMutableNotificationContent()
        content.title = "Bet"
        content.body = task.typeActivity.rawValue
        content.sound = .default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: task.date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: task.time)
        
        guard let eventDateTime = calendar.date(
            bySettingHour: timeComponents.hour ?? 0,
            minute: timeComponents.minute ?? 0,
            second: 0,
            of: calendar.date(from: dateComponents)!
        ) else {
            print("Invalid date components")
            return
        }
        

        guard let notificationDate = calendar.date(
            byAdding: .minute,
            value: -0,
            to: eventDateTime
        ) else {
            print("Failed to calculate notification date")
            return
        }
        
        guard notificationDate > Date() else {
            print("Notification time is in the past")
            return
        }
        
        let triggerComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: notificationDate
        )
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: triggerComponents,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: task.id,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
