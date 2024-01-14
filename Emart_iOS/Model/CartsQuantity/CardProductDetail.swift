//
//  CardProductDetail.swift
//  oye baryani
//
//  Created by Apple on 19/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
struct CardProductDetail : Codable {
    let error : Bool?
    let error_msg : String?
    var records : [CardsRecord]?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case error_msg = "error_msg"
        case records = "records"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error)
        error_msg = try values.decodeIfPresent(String.self, forKey: .error_msg)
        records = try values.decodeIfPresent([CardsRecord].self, forKey: .records)
    }

}
