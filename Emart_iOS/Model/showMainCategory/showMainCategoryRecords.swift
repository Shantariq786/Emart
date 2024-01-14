//
//  showMainCategoryRecords.swift
//  EMart
//
//  Created by Asad Khan on 5/7/21.
//  Copyright © 2021 Apple. All rights reserved.
//


import Foundation
struct showMainCategoryRecords : Codable {
    let id : String?
    let name : String?
    let image_name : String?
    let active : String?
    let restaurant_email : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case image_name = "image_name"
        case active = "active"
        case restaurant_email = "restaurant_email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image_name = try values.decodeIfPresent(String.self, forKey: .image_name)
        active = try values.decodeIfPresent(String.self, forKey: .active)
        restaurant_email = try values.decodeIfPresent(String.self, forKey: .restaurant_email)
    }

}
