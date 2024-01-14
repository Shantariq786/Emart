
import Foundation
import ObjectMapper


class RatingModel: BaseModel {
    
    var error : Bool?
    var error_msg : String?
    var records : [RatingRecord]?

    
    override func mapping(map:Map) {
        super.mapping(map: map)
        error <- map["error"]
        error_msg <- map["error_msg"]
        records <- map["records"]
    }
}


// MARK: - Record
struct RatingRecord: Mappable {
    var id: String?
    var vendor_email: String?
    var rating: String?
    var comment: String?
    var created_at: String?
    var user_email: String?
    var vendor_name: String?
    var user_name: String?
    var user_image: String?

    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        vendor_email <- map["vendor_email"]
        rating <- map["rating"]
        comment <- map["comment"]
        created_at <- map["created_at"]
        user_email <- map["user_email"]
        vendor_name <- map["vendor_name"]
        user_name <- map["user_name"]
        user_image <- map["user_image"]
    }
}

