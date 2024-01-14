//
//  ProductDetailData.swift
//  oye baryani
//
//  Created by Asad Khan on 5/2/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
struct ProductDetailData : Codable {
    let error : Bool?
    let error_msg : String?
    let records : [Records]?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case error_msg = "error_msg"
        case records = "records"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error)
        error_msg = try values.decodeIfPresent(String.self, forKey: .error_msg)
        records = try values.decodeIfPresent([Records].self, forKey: .records)
    }

}
