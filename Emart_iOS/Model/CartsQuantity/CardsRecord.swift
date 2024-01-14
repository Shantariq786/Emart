//
//  CardsRecord.swift
//  oye baryani
//
//  Created by Apple on 19/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import ObjectMapper

import Foundation

struct CardsRecord : Codable {
    let id : String?
    let images : [Image]?
    let name : String?
    let flavour : String?
    let price : String?
    let cat_id : String?
    let product_description : String?
    let image_1 : String?
    let image_2 : String?
    let image_3 : String?
    let size : String?
    let side_order : String?
    let iscart : String?
    let cart_id:String?
    var quantity:String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case images = "images"
        case name = "name"
        case flavour = "flavour"
        case price = "price"
        case cat_id = "cat_id"
        case product_description = "product_description"
        case image_1 = "image_1"
        case image_2 = "image_2"
        case image_3 = "image_3"
        case size = "size"
        case side_order = "side_order"
        case iscart = "iscart"
        case cart_id = "cart_id"
        case quantity = "quantity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        images = try values.decodeIfPresent([Image].self, forKey: .images)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        flavour = try values.decodeIfPresent(String.self, forKey: .flavour)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        product_description = try values.decodeIfPresent(String.self, forKey: .product_description)
        image_1 = try values.decodeIfPresent(String.self, forKey: .image_1)
        image_2 = try values.decodeIfPresent(String.self, forKey: .image_2)
        image_3 = try values.decodeIfPresent(String.self, forKey: .image_3)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        side_order = try values.decodeIfPresent(String.self, forKey: .side_order)
        iscart = try values.decodeIfPresent(String.self, forKey: .iscart)
        cart_id = try values.decodeIfPresent(String.self, forKey: .cart_id)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
    }

}



struct Image : Codable {
    
    let id : String?
    let image : String?
    let productId : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case productId = "product_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
    }
    
}

