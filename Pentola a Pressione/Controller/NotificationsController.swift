//
//  NotificationsController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 14/06/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationsController: NSObject {

    private let title = "È pronto!"
    private let message = "Spegni il fuoco sotto la\nPentola a Pressione!"
    private let actionTitle = "Okay! 😋"

    private var notificationCenter: UNUserNotificationCenter
    fileprivate(set) var notifiedLocally: Bool

    static let shared: NotificationsController = {
        return NotificationsController()
    }()

    private override init() {
        notifiedLocally = false
        notificationCenter = UNUserNotificationCenter.current()
        super.init()
    }

    public func requireGrantsForLocalNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
    }

    public func notifyWithAlert(usingViewController viewController: UIViewController) {
        AudioPlayerController.shared.play()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            AudioPlayerController.shared.stop()
            if let navigationController = viewController.navigationController {
                navigationController.popViewController(animated: true)
            } else {
                viewController.dismiss(animated: true, completion: nil)
            }
        }))
        viewController.present(alert, animated: true, completion: nil)
    }

    public func notifyWithLocalNotification(atTime time: TimeInterval) {
        removeLocalNotification()
        notifiedLocally = true
        notificationCenter.getNotificationSettings { (setting) in
            if setting.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title = self.title
                content.body = self.message
                content.sound = UNNotificationSound(named: AudioPlayerController.shared.notificationAudioFile)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)

                // Schedule the notification.
                let request = UNNotificationRequest(identifier: "Pentola_a_Pressione", content: content, trigger: trigger)
                self.notificationCenter.add(request, withCompletionHandler: nil)
                print("Time before LocalNotification: \(time)")
            }
        }
    }

    public func removeLocalNotification() {
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.removeAllDeliveredNotifications()
        self.notifiedLocally = false
    }
}
