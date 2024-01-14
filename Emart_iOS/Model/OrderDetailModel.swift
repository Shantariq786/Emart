

import Foundation
import ObjectMapper


struct OrderDetailModel : Mappable {
    var error : Bool?
    var error_msg : String?
    var records : [OrderDetailRecords]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_msg <- map["error_msg"]
        records <- map["records"]
    }

}

struct OrderDetailProducts : Mappable {
    var id : String?
    var name : String?
    var discount_price : String?
    var price : String?
    var sub_categories_id : String?
    var product_description : String?
    var size : String?
    var side_order : String?
    var status : String?
    var restaurant_email : String?
    var quantity : String?
    var images : [OrderDetailImages]?
    var variation_groups : [String]?
    var vendor : OrderDetailVendor?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        discount_price <- map["discount_price"]
        price <- map["price"]
        sub_categories_id <- map["sub_categories_id"]
        product_description <- map["product_description"]
        size <- map["size"]
        side_order <- map["side_order"]
        status <- map["status"]
        restaurant_email <- map["restaurant_email"]
        quantity <- map["quantity"]
        images <- map["images"]
        variation_groups <- map["variation_groups"]
        vendor <- map["vendor"]
    }

}

struct OrderDetailRecords : Mappable {
    var id : String?
    var name : String?
    var mobile_number : String?
    var user_email : String?
    var order_number : String?
    var date_time : String?
    var total_price : String?
    var delivery_charges : String?
    var status : String?
    var delivery_time : String?
    var address : String?
    var gps_address : String?
    var location : String?
    var sec_mobile : String?
    var r_id : String?
    var description : String?
    var accepted_by : String?
    var coupen_off : String?
    var branch_email : String?
    var processing_time : String?
    var rider_linked_time : String?
    var dispatched_time : String?
    var delivered_time : String?
    var canceled_time : String?
    var count : String?
    var status_name : String?
    var vendor : OrderDetailVendor?
    var products : [OrderDetailProducts]?
    var rider : OrderDetailRider?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        mobile_number <- map["mobile_number"]
        user_email <- map["user_email"]
        order_number <- map["order_number"]
        date_time <- map["date_time"]
        total_price <- map["total_price"]
        delivery_charges <- map["delivery_charges"]
        status <- map["status"]
        delivery_time <- map["delivery_time"]
        address <- map["address"]
        gps_address <- map["gps_address"]
        location <- map["location"]
        sec_mobile <- map["sec_mobile"]
        r_id <- map["r_id"]
        description <- map["description"]
        accepted_by <- map["accepted_by"]
        coupen_off <- map["coupen_off"]
        branch_email <- map["branch_email"]
        processing_time <- map["processing_time"]
        rider_linked_time <- map["rider_linked_time"]
        dispatched_time <- map["dispatched_time"]
        delivered_time <- map["delivered_time"]
        canceled_time <- map["canceled_time"]
        count <- map["count"]
        status_name <- map["status_name"]
        vendor <- map["vendor"]
        products <- map["products"]
        rider <- map["rider"]
    }

}

struct OrderDetailRider : Mappable {
    var id : String?
    var name : String?
    var email : String?
    var image : String?
    var phone : String?
    var token : String?
    var encrypted_password : String?
    var salt : String?
    var facebook_password : String?
    var salt_facebook : String?
    var google_password : String?
    var salt_google : String?
    var modified : String?
    var created_at : String?
    var active : String?
    var is_rider : String?
    var myref : String?
    var ref : String?
    var credit : String?
    var rider_online : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        image <- map["image"]
        phone <- map["phone"]
        token <- map["token"]
        encrypted_password <- map["encrypted_password"]
        salt <- map["salt"]
        facebook_password <- map["facebook_password"]
        salt_facebook <- map["salt_facebook"]
        google_password <- map["google_password"]
        salt_google <- map["salt_google"]
        modified <- map["modified"]
        created_at <- map["created_at"]
        active <- map["active"]
        is_rider <- map["is_rider"]
        myref <- map["myref"]
        ref <- map["ref"]
        credit <- map["credit"]
        rider_online <- map["rider_online"]
    }

}

struct OrderDetailVendor : Mappable {
    var id : String?
    var name : String?
    var email : String?
    var phone : String?
    var password : String?
    var location : String?
    var address : String?
    var timings : String?
    var thumb : String?
    var header : String?
    var sec_id : String?
    var description : String?
    var status : String?
    var role : String?
    var vendor_email : String?
    var type_id : String?
    var radius : String?
    var start_time : String?
    var end_time : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        password <- map["password"]
        location <- map["location"]
        address <- map["address"]
        timings <- map["timings"]
        thumb <- map["thumb"]
        header <- map["header"]
        sec_id <- map["sec_id"]
        description <- map["description"]
        status <- map["status"]
        role <- map["role"]
        vendor_email <- map["vendor_email"]
        type_id <- map["type_id"]
        radius <- map["radius"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
    }

}

struct OrderDetailImages : Mappable {
    var id : String?
    var image : String?
    var product_id : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        image <- map["image"]
        product_id <- map["product_id"]
    }

}
