//
//  FCMTokenModel.swift
//  Emart_iOS
//
//  Created by Asad Butt on 07/11/2021.
//

import Foundation
import ObjectMapper

struct FCMTokenModel: Mappable {
    
    var error: Bool?
    var error_msg: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    error <- map["error"]
    error_msg <- map["error_msg"]
    }
    
}
