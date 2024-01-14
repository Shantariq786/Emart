//
//  SettingAPI.swift
//  oye baryani
//
//  Created by Apple on 02/03/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
struct SettingAPI : Codable {
    let error : Bool?
    let error_msg : String?
    let records : [SettingRecords]?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case error_msg = "error_msg"
        case records = "records"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error)
        error_msg = try values.decodeIfPresent(String.self, forKey: .error_msg)
        records = try values.decodeIfPresent([SettingRecords].self, forKey: .records)
    }

}

