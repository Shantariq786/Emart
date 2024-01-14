//
//  ResturantFoodCategories.swift
//  AlternateDummy
//
//  Created by Apple on 29/07/2021.
//

//import Foundation
//struct ResturantFoodCategories_Base : Codable {
//    let error : Bool?
//    let error_msg : String?
//    let records : [ResturantFoodCategories_Records]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case error = "error"
//        case error_msg = "error_msg"
//        case records = "records"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        error = try values.decodeIfPresent(Bool.self, forKey: .error)
//        error_msg = try values.decodeIfPresent(String.self, forKey: .error_msg)
//        records = try values.decodeIfPresent([ResturantFoodCategories_Records].self, forKey: .records)
//    }
//}
//
//struct ResturantFoodCategories_Records : Codable {
//    let id : String?
//    let name : String?
//    let image : String?
//    let active : String?
//    let restaurant_email : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//        case image = "image"
//        case active = "active"
//        case restaurant_email = "restaurant_email"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        image = try values.decodeIfPresent(String.self, forKey: .image)
//        active = try values.decodeIfPresent(String.self, forKey: .active)
//        restaurant_email = try values.decodeIfPresent(String.self, forKey: .restaurant_email)
//    }
//
//}




import Foundation
import ObjectMapper

struct ResturantFoodCategory: Mappable {
    
    var id : String?
    var name : String?
    var image : String?
    var active : String?
    var restaurant_email : String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        active <- map["active"]
        restaurant_email <- map["restaurant_email"]
    }
}

class ResturantFoodCategoryResult: BaseModel {
    
    var error : Bool?
    var error_msg : String?
    var records : [ResturantFoodCategory]?

    
    override func mapping(map:Map) {
        super.mapping(map: map)
        error <- map["error"]
        error_msg <- map["error_msg"]
        records <- map["records"]
    }
}
