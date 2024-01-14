//
//  showSliderRecords.swift
//  EMart
//
//  Created by Asad Khan on 5/7/21.
//  Copyright © 2021 Apple. All rights reserved.
//


import Foundation
struct showSliderRecords : Codable {
    let id : String?
    let image : String?
    let text : String?
    let value : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case image = "image"
        case text = "text"
        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }

}
