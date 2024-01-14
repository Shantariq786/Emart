//
//  SearchProductRecords.swift
//  EMart
//
//  Created by Asad Khan on 6/5/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
struct SearchProductRecords : Codable {
    let id : String?
    let name : String?
    let discount_price : String?
    let price : String?
    let cat_id : String?
    let product_description : String?
    let size : String?
    let side_order : String?
    let status : String?
    let restaurant_email : String?
    let iscart : String?
    let images : [SearchProductImages]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case discount_price = "discount_price"
        case price = "price"
        case cat_id = "cat_id"
        case product_description = "product_description"
        case size = "size"
        case side_order = "side_order"
        case status = "status"
        case restaurant_email = "restaurant_email"
        case iscart = "iscart"
        case images = "images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        discount_price = try values.decodeIfPresent(String.self, forKey: .discount_price)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        product_description = try values.decodeIfPresent(String.self, forKey: .product_description)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        side_order = try values.decodeIfPresent(String.self, forKey: .side_order)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        restaurant_email = try values.decodeIfPresent(String.self, forKey: .restaurant_email)
        iscart = try values.decodeIfPresent(String.self, forKey: .iscart)
        images = try values.decodeIfPresent([SearchProductImages].self, forKey: .images)
    }

}
