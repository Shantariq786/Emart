//
//  AppDelegate.swift
//  oye baryani
//
//  Created by Apple on 20/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
import GoogleSignIn
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    let gcmMessageIDKey = "gcm.Message_ID"
    var window: UIWindow?
    
    var navigationController : UINavigationController?
    
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        // Configure GoogleAPI key
        GMSServices.provideAPIKey(Keys.GOOGLE_API_KEY)
        GMSPlacesClient.provideAPIKey(Keys.GOOGLE_API_KEY)
        setLandingScreen()
        IQKeyboardManager.shared.enable = true
        
        // firebase push notifications code
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

        Messaging.messaging().delegate = self
        
        
        // google sign in
        GIDSignIn.sharedInstance().clientID = "768062460938-dr54dpvjvvo9okp7vd837oci6jh2sqim.apps.googleusercontent.com"
        
        
        return true
    }
    
    
    func  setLandingScreen(){
        
        if window == nil{
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        if navigationController == nil{
            navigationController = UINavigationController()
        }
        
        
        let homeVC = SplashViewController(nibName:String(describing: SplashViewController.self), bundle:nil)
        let homeNavigationController = UINavigationController.init(rootViewController: homeVC)
        window?.rootViewController = homeNavigationController // Your RootViewController in here
        window?.makeKeyAndVisible()
        
        
    }
    
    
    func application(_ application: UIApplication,open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return GIDSignIn.sharedInstance().handle(url)
        
        
    }
    
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return false
    }
    
    
    func application(_ application: UIApplication,didReceiveRemoteNotification userInfo: [AnyHashable: Any],fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)-> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }

    func application(_ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
     
    
    
    
}



extension AppDelegate : MessagingDelegate{
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
     print("Firebase registration token: \(String(describing: fcmToken))")
     setFCMToken(fcmToken: fcmToken!)
      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
        
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

    
    func setFCMToken(fcmToken:String){
        print("fcmToken ",fcmToken)
        guard let email = UserStateHolder.loggedInUser?.email else{
            return
        }
        let parameters =  ["email" : email,
                           "token":fcmToken]
        
        APIService.sharedInstance.setFirebaseToken(parameters: parameters) { (tokenDetail) -> (Void) in
            if tokenDetail.error == false {
                print("token Detail \(tokenDetail.error_msg!)")
            }
        } failure: { (error) -> (Void) in
            
        }
        
    }
}


@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo


    // Print full message.
    print(userInfo)

    completionHandler()
  }
}



