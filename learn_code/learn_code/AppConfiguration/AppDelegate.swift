//
//  AppDelegate.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 29/11/2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import UserNotifications
import FirebaseMessaging
import Messages
import IQKeyboardManager
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
   
   var bestAttemptContent: UNMutableNotificationContent?
   
   var window: UIWindow?
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      FirebaseApp.configure()
      Messaging.messaging().delegate = self
      UNUserNotificationCenter.current().delegate = self
      let authOptions: UNAuthorizationOptions = [.alert, .sound,.badge]
      UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { success, error in
         if error != nil {
         }
      }
      application.registerForRemoteNotifications()
      IQKeyboardManager.shared().isEnabled = true
      return true
   }
   
   // MARK: UISceneSession Lifecycle
   
   func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      // Called when a new scene session is being created.
      // Use this method to select a configuration to create the new scene with.
      return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
   }
   
   func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
      // Called when the user discards a scene session.
      // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
      // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
   }
   
}


extension AppDelegate: UNUserNotificationCenterDelegate {
   func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
      Messaging.messaging().token { (token, error) in
         if let error = error {
            print("Error \(error)")
         } else if let token = token {
            print("Token ",token)
            
         }
      }
   }
   
   func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Failed to register with push. Error: \(error.localizedDescription)")
   }
   
   func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      print("Will gets called when app is in forground and we want to show banner")
      completionHandler([.alert, .sound, .badge])
   }
   
   
   
   func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      
      let userInfo = response.notification.request.content.userInfo
      
      bestAttemptContent = response.notification.request.content.mutableCopy() as! UNMutableNotificationContent
      if let attachments = bestAttemptContent?.attachments, !attachments.isEmpty {
         for attachment in attachments {
            let attachmentURL = attachment.url
            let attachmentIdentifier = attachment.identifier
            
            // Perform actions with the attachment
            print("Attachment URL: \(attachmentURL)")
            print("Attachment Identifier: \(attachmentIdentifier)")
         }
      }
      completionHandler()
   }
   
   
   func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print(fcmToken)
   }
   
}


