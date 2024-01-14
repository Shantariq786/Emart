//
//  OrderCancel.swift
//  EMart
//
//  Created by Apple on 13/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import ObjectMapper

struct OrderCancel: Mappable {
    
    var error: Bool?
    var errorMsg: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    error <- map["error"]
    errorMsg <- map["error_msg"]
    }
    
}
