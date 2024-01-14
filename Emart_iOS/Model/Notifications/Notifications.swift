//
//  Notifications.swift
//  EMart
//
//  Created by Apple on 05/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import ObjectMapper

struct Notifications: Mappable {
    
    var error: Bool?
    var errorMsg: String?
    var NotificationsRecord: [NotificationsRecord]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        error <- map["error"]
        errorMsg <- map["error_msg"]
        NotificationsRecord <- map["records"]
    }
    
}
struct NotificationsRecord: Mappable {
    
    var id: String?
    var message: String?
    var order_id: String?
    var user_email: String?
    var data:String?
    var timestamp:String?
    var isread:String?
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        message <- map["message"]
        order_id <- map["order_id"]
        user_email <- map["user_email"]
        data <- map["data"]
        timestamp <- map["timestamp"]
        isread <- map["isread"]
    }
    
}
