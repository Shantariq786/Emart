//
//  PushNotificationManager.swift
//  AnyRuns
//
//  Created by Yousaf Shafiq on 01/09/2021.
//

import Firebase
import FirebaseMessaging
import UIKit
import UserNotifications

class PushNotificationManager: NSObject, MessagingDelegate,
                               UNUserNotificationCenterDelegate {
    
    
    var user: User?
    
    override init() {
       super.init()
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
        self.user = user
    }
    
    func updateFirestorePushTokenIfNeeded() {
        if let user = self.user{
            if let token = Messaging.messaging().fcmToken{
                setFCMToken(fcmToken: token)
                print("Token set \(token)")
                
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        updateFirestorePushTokenIfNeeded()
    }
    
    
    func registerForPushNotifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in
            // handle error if there is one
        })
        Messaging.messaging().delegate = self
        updateFirestorePushTokenIfNeeded()
        
    }
    
    func setFCMToken(fcmToken:String){
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
