//
//  AddressRecords.swift
//  oye baryani
//
//  Created by Apple on 20/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct AddressRecords : Codable {
    let id : String?
    let address : String?
    let gps_address : String?
    let location : String?
    let user_email : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case address = "address"
        case gps_address = "gps_address"
        case location = "location"
        case user_email = "user_email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        gps_address = try values.decodeIfPresent(String.self, forKey: .gps_address)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        user_email = try values.decodeIfPresent(String.self, forKey: .user_email)
    }

}
