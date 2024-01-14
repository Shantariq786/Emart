//
//  showSliderA.swift
//  EMart
//
//  Created by Asad Khan on 5/7/21.
//  Copyright © 2021 Apple. All rights reserved.
//


import Foundation
struct showSliderAPI : Codable {
    let error : Bool?
    let error_msg : String?
    let records : [showSliderRecords]?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case error_msg = "error_msg"
        case records = "records"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error)
        error_msg = try values.decodeIfPresent(String.self, forKey: .error_msg)
        records = try values.decodeIfPresent([showSliderRecords].self, forKey: .records)
    }

}
