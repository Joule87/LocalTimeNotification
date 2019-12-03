//
//  Notifications.swift
//  LocalTimeNotification
//
//  Created by Julio Collado on 12/1/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject {
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestNotificationPermissions() {
        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
        notificationCenter.requestAuthorization(options: options) { (isAhutorized, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
            if !isAhutorized {
                print("Permission ungranted")
            }
            
        }
    }
    
    func scheduleNotification(notificationTitle: String) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Notification title: " + notificationTitle
        notificationContent.body = "Notification body: " + notificationTitle
        notificationContent.sound = .default
        notificationContent.badge = 1
        notificationContent.categoryIdentifier = notificationTitle
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identifier = "LocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        addCategory(notificationTitle)
    }
    
    private func addCategory(_ categoryIdentifier: String) {
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        
        let category = UNNotificationCategory(identifier: categoryIdentifier, actions: [snoozeAction, deleteAction], intentIdentifiers: [], options: [])
        notificationCenter.setNotificationCategories([category])
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "LocalNotification" {
            switch response.actionIdentifier {
            case "Snooze":
                print("Snooze Action Triggered")
            case "Delete":
                print("Delete Action Triggered")
            default:
                print("Unknown")
            }
        }
        completionHandler()
    }
    

    
}
