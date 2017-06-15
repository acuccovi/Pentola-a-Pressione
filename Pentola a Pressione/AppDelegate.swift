//
//  AppDelegate.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 24/05/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NotificationsController.shared.requireGrantsForLocalNotification()
        AudioPlayerController.shared.setAudioUrl(UserDefaultsController.shared.getAudioFile())
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        scheduleLocalNotification()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        scheduleLocalNotification()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        NotificationsController.shared.removeLocalNotification()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        NotificationsController.shared.removeLocalNotification()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        NotificationsController.shared.removeLocalNotification()
    }

    private func scheduleLocalNotification() {
        if let navigationController = window?.rootViewController as? UINavigationController {
            if let viewController = navigationController.visibleViewController as? DetailsViewController {
                if let time = viewController.label.remainingTime {
                    NotificationsController.shared.removeLocalNotification()
                    NotificationsController.shared.notifyWithLocalNotification(atTime: TimeInterval(time))
                }
            }
        }
    }
}
