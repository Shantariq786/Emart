////
////  OyeBaryaniSessions.swift
////  oye baryani
////
////  Created by Apple on 18/02/2020.
////  Copyright © 2020 Apple. All rights reserved.
////
//
//import Foundation
//import UIKit
//class OyeBaryaniSessions
//:NSObject{
//    var _UserProfileInfo:User?
//     var UserProfileInfo:User?{
//        get{
//          return _UserProfileInfo
//        }
//        set{
//            _UserProfileInfo = newValue
//            saveUserData(user: newValue)
//        }
//        
//    }
//    
//    override init() {
//        super.init()
//        showUserData()
//    }
//    static let shared:OyeBaryaniSessions
//    = {
//        let obj = OyeBaryaniSessions()
//        return obj
//    }()
//    
//    
//    func saveUserData(user:User?)
//    {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(user){
//            UserDefaults.standard.set(encoded, forKey: "user")
//            UserDefaults.standard.synchronize()
//            showUserData()
//        }
//        
//        
//    }
//  fileprivate  func showUserData()
//       {
//           let decoder = JSONDecoder()
//        if let data = UserDefaults.standard.value(forKey: "user"),
//            let userdata = try? decoder.decode(User.self, from: data as! Data)
//        {
//            _UserProfileInfo = userdata 
//           }
//           
//           
//       }
//    func removeUserData()
//    {
//        UserDefaults.standard.removeObject(forKey: "user")
//        _UserProfileInfo = nil
//        
//    }
//        
////    static func SaveUserDefaults(user:User)
////    {
////        UserDefaults.standard.set(user.name, forKey: "name")
////        UserDefaults.standard.set(user.id, forKey: "id")
////        UserDefaults.standard.set(user.active, forKey: "active")
////        UserDefaults.standard.set(user.created_at, forKey: "created_at")
////        UserDefaults.standard.set(user.email, forKey: "email")
////        UserDefaults.standard.set(user.encrypted_password, forKey: "encrypted_password")
////        UserDefaults.standard.set(user.facebook_password, forKey: "facebook_password")
////        UserDefaults.standard.set(user.google_password, forKey: "google_password")
////        UserDefaults.standard.set(user.image, forKey: "image")
////        UserDefaults.standard.set(user.is_rider, forKey: "is_rider")
////        UserDefaults.standard.set(user.modified, forKey: "modified")
////        UserDefaults.standard.set(user.myref, forKey: "myref")
////        UserDefaults.standard.set(user.phone, forKey: "phone")
////        UserDefaults.standard.set(user.ref, forKey: "ref")
////        UserDefaults.standard.set(user.salt, forKey: "salt")
////        UserDefaults.standard.set(user.salt_facebook, forKey: "salt_facebook")
////        UserDefaults.standard.set(user.salt_google, forKey: "salt_google")
////        UserDefaults.standard.set(user.token, forKey: "token")
////
////
////    }
////
////    static func RemoveUserDefaults()
////       {
////           UserDefaults.standard.set(nil, forKey: "name")
////           UserDefaults.standard.set(nil, forKey: "id")
////           UserDefaults.standard.set(nil, forKey: "active")
////           UserDefaults.standard.set(nil, forKey: "created_at")
////           UserDefaults.standard.set(nil, forKey: "email")
////           UserDefaults.standard.set(nil, forKey: "encrypted_password")
////           UserDefaults.standard.set(nil, forKey: "facebook_password")
////           UserDefaults.standard.set(nil, forKey: "google_password")
////           UserDefaults.standard.set(nil, forKey: "image")
////           UserDefaults.standard.set(nil, forKey: "is_rider")
////           UserDefaults.standard.set(nil, forKey: "modified")
////           UserDefaults.standard.set(nil, forKey: "myref")
////           UserDefaults.standard.set(nil, forKey: "phone")
////           UserDefaults.standard.set(nil, forKey: "ref")
////           UserDefaults.standard.set(nil, forKey: "salt")
////           UserDefaults.standard.set(nil, forKey: "salt_facebook")
////           UserDefaults.standard.set(nil, forKey: "salt_google")
////           UserDefaults.standard.set(nil, forKey: "token")
////
////
////       }
////
//    
//     static func SaveSetting(setting:SettingRecords)
//        {
//            UserDefaults.standard.set(setting.delivery_charges, forKey: "delivery_charges")
//            UserDefaults.standard.set(setting.id, forKey: "id")
//            UserDefaults.standard.set(setting.open_close, forKey: "open_close")
//            UserDefaults.standard.set(setting.timings, forKey: "timings")
//            UserDefaults.standard.set(setting.delivery_time, forKey: "delivery_time")
//    
//        }
//    static func SaveSetting()
//        {
//         
//          UserDefaults.standard.value(forKey: "id") as? String
//           UserDefaults.standard.value(forKey: "open_close") as? String
//        UserDefaults.standard.value(forKey: "timings") as? String
//        UserDefaults.standard.value(forKey: "delivery_time") as? String
//
//        }
//}
