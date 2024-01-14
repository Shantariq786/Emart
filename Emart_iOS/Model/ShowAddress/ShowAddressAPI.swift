//
//  ShowAddressAPI.swift
//  oye baryani
//
//  Created by Apple on 20/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//
import Foundation
struct ShowAddressAPI : Codable {
    let error : Bool?
    let error_msg : String?
    var records : [AddressRecords]?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case error_msg = "error_msg"
        case records = "records"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error)
        error_msg = try values.decodeIfPresent(String.self, forKey: .error_msg)
        records = try values.decodeIfPresent([AddressRecords].self, forKey: .records)
    }

}
