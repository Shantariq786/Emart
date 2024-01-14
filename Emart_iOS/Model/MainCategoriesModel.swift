//
//  MainCategoriesModel.swift
//  Emart_iOS
//
//  Created by Hexacrew on 04/01/2022.
//

import Foundation
import ObjectMapper

class MainCategoriesModel: BaseModel {
    
    var error : Bool?
    var error_msg : String?
    var records : [CategoriesName]?

    
    override func mapping(map:Map) {
        super.mapping(map: map)
        error <- map["error"]
        error_msg <- map["error_msg"]
        records <- map["records"]
    }
}

struct CategoriesName: Mappable {
    
    var id: String?
    var name: String?
    var image_name: String?
    var active: String?
    var parent_id: String?
    var vendor_type_id: String?
    
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image_name <- map["image_name"]
        active <- map["active"]
        parent_id <- map["parent_id"]
        vendor_type_id <- map["vendor_type_id"]
    }
}

