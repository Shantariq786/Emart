//
//  UserStateHolder.swift
//  EMart
//
//  Created by Yousaf Shafiq on 01/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation


class UserStateHolder {
    class var loggedInUser:User? {
        set {
            _ = cacheCustomObject(object: newValue!, forKey: UserDefaultKey.kUserProfile)
        }
        get {
            return cachedCustomObjectForKey(key: UserDefaultKey.kUserProfile) as? User
        }
    }



    class var isUserLoggedIn:Bool {
        set {
            _ = cacheBool(boolValue: newValue, forKey: UserDefaultKey.kIsUserLoggedIn)
        }
        get {
            let _isUserLoggedIn = cachedBoolForKey(key: UserDefaultKey.kIsUserLoggedIn)
            if _isUserLoggedIn == nil {
                return false
            }
            else {
                return _isUserLoggedIn!
            }
        }
    }
    
    
    
//    class var notificationState:String? {
//        set {
//            _ = cacheCustomObject(object: newValue as AnyObject, forKey: UserDefaultKey.kNotificationState)
//        }
//        get {
//            return cachedCustomObjectForKey(key: UserDefaultKey.kNotificationState) as? String
//        }
//    }
//   
//    class var deviceToken : String? {
//        set {
//            _ = cacheCustomObject(object: newValue as AnyObject, forKey: UserDefaultKey.kDeviceID)
//        }
//        get {
//            return cachedCustomObjectForKey(key: UserDefaultKey.kDeviceID) as? String
//        }
//
//    }
//
//    
    
        
    

    
    class func resetUserState() {
        
     //   _ = removeCachedObjectForKey(key: UserDefaultKey.tokens)
       
        _ = removeCachedObjectForKey(key: UserDefaultKey.kUserProfile)
        _ = removeCachedObjectForKey(key: UserDefaultKey.kIsUserLoggedIn)
        
//
//        _ = removeCachedObjectForKey(key: UserDefaultKey.kUserChannels)
//
//              _ = removeCachedObjectForKey(key: UserDefaultKey.kUserChannelsParticipents)
//              _ = removeCachedObjectForKey(key: UserDefaultKey.kAllChannels)
       
    }
    
    
       
//    class var userChannels:[GroupChatChannel]? {
//        set {
//            _ = cacheCustomArrayObject(object: newValue! as [AnyObject], forKey: UserDefaultKey.kUserChannels)
//        }
//        get {
//            return cachedCustomArrayObjectForKey(key: UserDefaultKey.kUserChannels) as? [GroupChatChannel]
//        }
//    }
//
//
//
//    class var userChannelsParticipations:[GroupParticipent]? {
//        set {
//            _ = cacheCustomArrayObject(object: newValue!, forKey: UserDefaultKey.kUserChannelsParticipents)
//        }
//        get {
//            return cachedCustomArrayObjectForKey(key: UserDefaultKey.kUserChannelsParticipents) as? [GroupParticipent]
//        }
//    }
//
//
//
//    class var allChanels:[GroupChatChannel]? {
//        set {
//            _ = cacheCustomArrayObject(object: newValue! as [AnyObject], forKey: UserDefaultKey.kAllChannels)
//        }
//        get {
//            return cachedCustomArrayObjectForKey(key: UserDefaultKey.kAllChannels) as? [GroupChatChannel]
//        }
//    }

}
