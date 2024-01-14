
import Foundation
import ObjectMapper



class VoucherModel: BaseModel {
    
    var error : Bool?
    var error_msg : String?
    var records : [VoucherRecord]?

    
    override func mapping(map:Map) {
        super.mapping(map: map)
        error <- map["error"]
        error_msg <- map["error_msg"]
        records <- map["records"]
    }
}


// MARK: - Record
struct VoucherRecord: Mappable {
    var id: String?
    var coupon_key: String?
    var no_of_time: String?
    var percentage_off: String?
    var coupon_status: String?
    var expiry_date: String?
    var vendor_email: String?
    var user_email: String?
    var message: String?
    var used: String?

    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        coupon_key <- map["coupon_key"]
        no_of_time <- map["no_of_time"]
        percentage_off <- map["percentage_off"]
        coupon_status <- map["coupon_status"]
        expiry_date <- map["expiry_date"]
        vendor_email <- map["vendor_email"]
        user_email <- map["user_email"]
        message <- map["message"]
        used <- map["used"]
    }
}

