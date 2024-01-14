//
//  SettingRecords.swift
//  oye baryani
//
//  Created by Apple on 02/03/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
struct SettingRecords : Codable {
    let id : String?
    var delivery_charges : String?
    let open_close : String?
    let timings : String?
    let delivery_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case delivery_charges = "delivery_charges"
        case open_close = "open_close"
        case timings = "timings"
        case delivery_time = "user_email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        delivery_charges = try values.decodeIfPresent(String.self, forKey: .delivery_charges)
        open_close = try values.decodeIfPresent(String.self, forKey: .open_close)
        timings = try values.decodeIfPresent(String.self, forKey: .timings)
        delivery_time = try values.decodeIfPresent(String.self, forKey: .delivery_time)
    }

}
