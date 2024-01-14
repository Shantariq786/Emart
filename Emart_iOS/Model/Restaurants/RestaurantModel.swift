//
//  RestaurantModel.swift
//  EMart
//
//  Created by Yousaf Shafiq on 15/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//



//
//  Record.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on August 14, 2021

import Foundation
import ObjectMapper

struct Restaurant: Mappable {
    
    var createdAt: String?
    var id: String?
    var userEmail: String?
    var vendor: Vendor?
    var vendorEmail: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    createdAt <- map["created_at"]
    id <- map["id"]
    userEmail <- map["user_email"]
    vendor <- map["vendor"]
    vendorEmail <- map["vendor_email"]
    }
    
}



import Foundation
import ObjectMapper

struct RestaurantResult: Mappable {
    
    var error: Bool?
    var errorMsg: String?
    var records: [Restaurant]?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    error <- map["error"]
    errorMsg <- map["error_msg"]
    records <- map["records"]
    }
    
}
