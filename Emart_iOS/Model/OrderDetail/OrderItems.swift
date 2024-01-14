//
//  OrderItems.swift
//  EMart
//
//  Created by Apple on 12/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import ObjectMapper

struct OrderItems: Mappable {
    
    var error: Bool?
    var errorMsg: String?
    var records: [OrderItemsRecord]?
    init?(map: Map) { }

    mutating func mapping(map: Map) {
    error <- map["error"]
    errorMsg <- map["error_msg"]
    records <- map["records"]
    }
    
}
struct OrderItemsRecord: Mappable {

    var discountPrice: String?
    var id: String?
    var images: [OrderItemsImage]?
    var name: String?
    var price: String?
    var productDescription: String?
    var quantity: String?
    var restaurantEmail: String?
    var sideOrder: String?
    var size: String?
    var status: String?
    var subCategoriesId: String?
    var variations: [AnyObject]?
    var vendor: OrderItemsVendor?

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
    variations <- map["variations"]
    vendor <- map["vendor"]
    }

}
struct OrderItemsVendor: Mappable {

    var descriptionField: String?
    var email: String?
    var endTime: String?
    var header: String?
    var id: String?
    var location: String?
    var name: String?
    var password: String?
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
    descriptionField <- map["description"]
    email <- map["email"]
    endTime <- map["end_time"]
    header <- map["header"]
    id <- map["id"]
    location <- map["location"]
    name <- map["name"]
    password <- map["password"]
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
struct OrderItemsImage: Mappable {
    
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
