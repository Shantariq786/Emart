//
//  SearchProductImages.swift
//  EMart
//
//  Created by Asad Khan on 6/5/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
struct SearchProductImages : Codable {
    let id : String?
    let image : String?
    let product_id : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case image = "image"
        case product_id = "product_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
    }

}
