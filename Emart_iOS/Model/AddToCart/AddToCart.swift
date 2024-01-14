//
//  AddToCart.swift
//  EMart
//
//  Created by Yousaf Shafiq on 09/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//
import Foundation
import ObjectMapper

struct AddToCart: Mappable {
    
    var error: Bool?
    var errorMsg: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    error <- map["error"]
    errorMsg <- map["error_msg"]
    }
    
}

struct UpdateCart: Mappable {
    
    var error: Bool?
    var errorMsg: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    error <- map["error"]
    errorMsg <- map["error_msg"]
    }
    
}
