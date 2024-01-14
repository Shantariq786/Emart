//
//  orderRootClass.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on November 8, 2021

import Foundation
import ObjectMapper

struct orderRootClass: Mappable {
    
    var error: Bool?
    var errorMsg: String?
    var records: [orderRecord]?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    error <- map["error"]
    errorMsg <- map["error_msg"]
    records <- map["records"]
    }
    
}
struct orderRecord: Mappable {
    
    var acceptedBy: String?
    var address: String?
    var branchEmail: String?
    var canceledTime: String?
    var count: String?
    var coupenOff: String?
    var dateTime: String?
    var deliveredTime: String?
    var deliveryCharges: String?
    var deliveryTime: String?
    var descriptionField: String?
    var dispatchedTime: String?
    var gpsAddress: String?
    var id: String?
    var location: String?
    var mobileNumber: String?
    var name: String?
    var orderNumber: String?
    var processingTime: String?
    var products: [orderProduct]?
    var rId: String?
    var rider: orderRider?
    var riderLinkedTime: String?
    var secMobile: String?
    var status: String?
    var statusName: String?
    var totalPrice: String?
    var userEmail: String?
    var vendor: orderVendor?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    acceptedBy <- map["accepted_by"]
    address <- map["address"]
    branchEmail <- map["branch_email"]
    canceledTime <- map["canceled_time"]
    count <- map["count"]
    coupenOff <- map["coupen_off"]
    dateTime <- map["date_time"]
    deliveredTime <- map["delivered_time"]
    deliveryCharges <- map["delivery_charges"]
    deliveryTime <- map["delivery_time"]
    descriptionField <- map["description"]
    dispatchedTime <- map["dispatched_time"]
    gpsAddress <- map["gps_address"]
    id <- map["id"]
    location <- map["location"]
    mobileNumber <- map["mobile_number"]
    name <- map["name"]
    orderNumber <- map["order_number"]
    processingTime <- map["processing_time"]
    products <- map["products"]
    rId <- map["r_id"]
    rider <- map["rider"]
    riderLinkedTime <- map["rider_linked_time"]
    secMobile <- map["sec_mobile"]
    status <- map["status"]
    statusName <- map["status_name"]
    totalPrice <- map["total_price"]
    userEmail <- map["user_email"]
    vendor <- map["vendor"]
    }
    
}
struct orderVendor: Mappable {
    
    var address: String?
    var descriptionField: String?
    var email: String?
    var endTime: String?
    var header: String?
    var id: String?
    var location: String?
    var name: String?
    var password: String?
    var phone: String?
    var radius: String?
    var role: String?
    var secId: String?
    var startTime: String?
    var status: String?
    var thumb: String?
    var timings: String?
    var typeId: String?
    var vendorEmail: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    address <- map["address"]
    descriptionField <- map["description"]
    email <- map["email"]
    endTime <- map["end_time"]
    header <- map["header"]
    id <- map["id"]
    location <- map["location"]
    name <- map["name"]
    password <- map["password"]
    phone <- map["phone"]
    radius <- map["radius"]
    role <- map["role"]
    secId <- map["sec_id"]
    startTime <- map["start_time"]
    status <- map["status"]
    thumb <- map["thumb"]
    timings <- map["timings"]
    typeId <- map["type_id"]
    vendorEmail <- map["vendor_email"]
    }
    
}
struct orderRider: Mappable {
    
    var active: String?
    var createdAt: String?
    var credit: String?
    var email: String?
    var encryptedPassword: String?
    var facebookPassword: String?
    var googlePassword: String?
    var id: String?
    var image: String?
    var isRider: String?
    var modified: String?
    var myref: String?
    var name: String?
    var phone: String?
    var ref: String?
    var riderOnline: String?
    var salt: String?
    var saltFacebook: String?
    var saltGoogle: String?
    var token: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    active <- map["active"]
    createdAt <- map["created_at"]
    credit <- map["credit"]
    email <- map["email"]
    encryptedPassword <- map["encrypted_password"]
    facebookPassword <- map["facebook_password"]
    googlePassword <- map["google_password"]
    id <- map["id"]
    image <- map["image"]
    isRider <- map["is_rider"]
    modified <- map["modified"]
    myref <- map["myref"]
    name <- map["name"]
    phone <- map["phone"]
    ref <- map["ref"]
    riderOnline <- map["rider_online"]
    salt <- map["salt"]
    saltFacebook <- map["salt_facebook"]
    saltGoogle <- map["salt_google"]
    token <- map["token"]
    }
    
}
struct orderProduct: Mappable {
    
    var discountPrice: String?
    var id: String?
    var images: [orderImage]?
    var name: String?
    var price: String?
    var productDescription: String?
    var quantity: String?
    var restaurantEmail: String?
    var sideOrder: String?
    var size: String?
    var status: String?
    var subCategoriesId: String?
    var variationGroups: [orderVariationGroup]?
    var vendor: orderVendor?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    discountPrice <- map["discount_price"]
    id <- map["id"]
    images <- map["images"]
    name <- map["name"]
    price <- map["price"]
    productDescription <- map["product_description"]
    quantity <- map["quantity"]
    restaurantEmail <- map["restaurant_email"]
    sideOrder <- map["side_order"]
    size <- map["size"]
    status <- map["status"]
    subCategoriesId <- map["sub_categories_id"]
    variationGroups <- map["variation_groups"]
    vendor <- map["vendor"]
    }
    
}
struct orderVariationGroup: Mappable {
    
    var id: String?
    var productId: String?
    var required: String?
    var selection: String?
    var title: String?
    var variations: [orderVariation]?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    id <- map["id"]
    productId <- map["product_id"]
    required <- map["required"]
    selection <- map["selection"]
    title <- map["title"]
    variations <- map["variations"]
    }
    
}
struct orderVariation: Mappable {
    
    var createdAt: String?
    var id: String?
    var name: String?
    var price: String?
    var productVariationId: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    createdAt <- map["created_at"]
    id <- map["id"]
    name <- map["name"]
    price <- map["price"]
    productVariationId <- map["product_variation_id"]
    }
    
}
struct orderImage: Mappable {
    
    var id: String?
    var image: String?
    var productId: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    id <- map["id"]
    image <- map["image"]
    productId <- map["product_id"]
    }
    
}
