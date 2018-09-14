//
//  AppDelegate.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var baseURL: String!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        self.baseURL = kbaseURLDev
        Fabric.with([Crashlytics.self])
        return true
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        println_debug("APNs registration failed: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        println_debug("userInfo: \(userInfo)")
        completionHandler(UIBackgroundFetchResult.noData)
    }
    func applicationWillResignActive(_ application: UIApplication) {
        println_debug("Resign-Active")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        println_debug("Application-Background")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        println_debug("Application-Foreground")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        println_debug("Application-BecomeActive")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        println_debug("Application-Terminate")
    }
    
}

