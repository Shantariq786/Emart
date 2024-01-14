//
//  showRestaurantsRecords.swift
//  EMart
//
//  Created by Asad Khan on 5/8/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
struct showRestaurantsRecords : Codable {
    let id : String?
    let name : String?
    let email : String?
    let password : String?
    let location : String?
    let timings : String?
    let thumb : String?
    let header : String?
    let sec_id : String?
    let description : String?
    let status : String?
    let is_admin : String?
    let review_count : String?
    let rating : String?
    var is_fav : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case email = "email"
        case password = "password"
        case location = "location"
        case timings = "timings"
        case thumb = "thumb"
        case header = "header"
        case sec_id = "sec_id"
        case description = "description"
        case status = "status"
        case is_admin = "is_admin"
        case review_count = "review_count"
        case rating = "rating"
        case is_fav = "is_fav"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        timings = try values.decodeIfPresent(String.self, forKey: .timings)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
        header = try values.decodeIfPresent(String.self, forKey: .header)
        sec_id = try values.decodeIfPresent(String.self, forKey: .sec_id)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        is_admin = try values.decodeIfPresent(String.self, forKey: .is_admin)
        review_count = try values.decodeIfPresent(String.self, forKey: .review_count)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        is_fav = try values.decodeIfPresent(String.self, forKey: .is_fav)
    }

}
