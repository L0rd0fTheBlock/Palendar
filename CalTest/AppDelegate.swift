//
//  AppDelegate.swift
//  CalTest
//
//  Created by Jamie McAllister on 19/11/2017.
//  Copyright © 2017 Jamie McAllister. All rights reserved.
//

import UIKit
import UserNotifications
//import FBSDKLoginKit
//import FBNotifications
//import FacebookCore
import CoreData
//import GoogleMobileAds
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseUI


//MARK: Handler Declarations
let userHandler = UserHandler()
let calendarHandler = CalendarHandler()
let inviteHandler = InviteHandler()
let friendHandler = FriendHandler()
let statusHandler = StatusHandler()
let me = Person()



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate /*MessagingDelegate*/ {

    var window: UIWindow?

    
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       // FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        FirebaseApp.configure()
        
        
        Auth.auth().addStateDidChangeListener { (auth, user) in }
       
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
     /*
        do {
            try  Auth.auth().signOut()
        } catch {
            
        }
       */
        
      //  AppEventsLogger.activate(application)
        //GADMobileAds.configure(withApplicationID: "ca-app-pub-8694139400395039~1830749784")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = TabBarController()//TODO: set this back to tab bar controller after testing
    return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo["gcmMessageIDKey"] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo["gcmMessageIDKey"] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    //MARK: FIREBASE NOTIFICATION DELEGATE
    
   /* func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String){
        print("Firebase registration token refreshed: \(fcmToken)")
        
        if(AccessToken.current != nil){
            let calHandler = CalendarHandler()
            calHandler.registerDviceToken()
        }
    }
*/
    
    

}

