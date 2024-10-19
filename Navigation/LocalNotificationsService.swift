//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by eva on 19.10.2024.
//

import UserNotifications

class LocalNotificationsService {
    
    static let shared = LocalNotificationsService()
    
    private init () {}
    
    func reqestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                
            }
        }
    }
    
    func checkPremission() async -> Bool {
        await UNUserNotificationCenter.current().notificationSettings().authorizationStatus == .authorized
    }
    
    func registeForLatestUpdatesIfPossible() async {
        if await checkPremission() {
            let content = UNMutableNotificationContent()
            content.body = "Посмотрите последние обновления"
            content.title = "Посмотрите последние обновления"
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 19
            dateComponents.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "latestUpdates", content: content, trigger: trigger)
            
            do {
                try await UNUserNotificationCenter.current().add(request)
                print("notif registration success")
            } catch {
                print("some error while notif registration")
            }
        } else {
            reqestPermission()
        }
    }
}
