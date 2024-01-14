//
//  CatViseProduct.swift
//  EMart
//
//  Created by Yousaf Shafiq on 01/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import Foundation
import ObjectMapper


class CategoryViseProductsRecord: BaseModel {
    
    var cat_name : Bool?
    var cat_id : String?
    var products : [RestaurantProduct]?

    
    override func mapping(map:Map) {
        super.mapping(map: map)
        cat_name <- map["cat_name"]
        cat_id <- map["cat_id"]
        products <- map["products"]
    }
}


class CategoryViseProductsRecordResult: BaseModel {
    
    var error : Bool?
    var error_msg : String?
    var records : [CategoryViseProductsRecord]?

    
    override func mapping(map:Map) {
        super.mapping(map: map)
        error <- map["error"]
        error_msg <- map["error_msg"]
        records <- map["records"]
    }
}
