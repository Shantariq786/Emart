//
//  addFavourite.swift
//  EMart
//
//  Created by Apple on 10/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import ObjectMapper

struct GenericModel: Mappable {
    
    var error: Bool?
    var errorMsg: String?
    var records: Bool?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    error <- map["error"]
    errorMsg <- map["error_msg"]
    records <- map["records"]
    }
    
}
