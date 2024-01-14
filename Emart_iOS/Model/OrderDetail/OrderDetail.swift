//
//  OrderDetail.swift
//  EMart
//
//  Created by Yousaf Shafiq on 01/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//


import Foundation
import ObjectMapper

struct Order: Mappable {
    
    var acceptedBy: String?
    var address: String?
    var branchEmail: String?
    var count: String?
    var coupenOff: String?
    var dateTime: String?
    var descriptionField: String?
    var gpsAddress: String?
    var id: String?
    var location: String?
    var mobileNumber: String?
    var name: String?
    var orderNumber: String?
    var rId: String?
    var secMobile: String?
    var status: String?
    var statusName: String?
    var totalPrice: String?
    var userEmail: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    acceptedBy <- map["accepted_by"]
    address <- map["address"]
    branchEmail <- map["branch_email"]
    count <- map["count"]
    coupenOff <- map["coupen_off"]
    dateTime <- map["date_time"]
    descriptionField <- map["description"]
    gpsAddress <- map["gps_address"]
    id <- map["id"]
    location <- map["location"]
    mobileNumber <- map["mobile_number"]
    name <- map["name"]
    orderNumber <- map["order_number"]
    rId <- map["r_id"]
    secMobile <- map["sec_mobile"]
    status <- map["status"]
    statusName <- map["status_name"]
    totalPrice <- map["total_price"]
    userEmail <- map["user_email"]
    }
    
}





class OrderResult: BaseModel {
    
    var error : Bool?
    var error_msg : String?
    var records : [Order]?

    
    override func mapping(map:Map) {
        super.mapping(map: map)
        error <- map["error"]
        error_msg <- map["error_msg"]
        records <- map["records"]
    }
}
