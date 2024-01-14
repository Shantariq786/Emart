//
//  NotificationModel.swift
//  Emart_iOS
//
//  Created by Hexacrew on 11/02/2022.
//

import Foundation
import ObjectMapper

struct NotificationModel:Mappable{
//    var error: String?
//    var status: String?
    var error: Bool?
    var status: Bool?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        error <- map["error"]
        status <- map["status"]
    }
}
