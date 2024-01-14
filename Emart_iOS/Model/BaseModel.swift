//
//  BaseModel.swift
//  EMart
//
//  Created by Yousaf Shafiq on 01/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseModel:NSObject, Mappable, NSCoding {
    
//    var error : Bool?
//    var error_msg : String?

    var success: String?
    var message : String?

    var customer_id:String?
   
    required init?(map: Map) {
        
    }
    
    override init() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
//
//        error = (aDecoder.decodeObject(forKey: "error") as? Bool)
//        error_msg = (aDecoder.decodeObject(forKey: "error_msg") as? String)
//
        success = (aDecoder.decodeObject(forKey: "success") as? String)
        message = (aDecoder.decodeObject(forKey: "message") as? String)
        customer_id = (aDecoder.decodeObject(forKey: "customer_id") as? String)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(success, forKey: "success")
        aCoder.encode(message, forKey: "message")
        aCoder.encode(customer_id, forKey: "customer_id")
//        aCoder.encode(error, forKey: "error")
//        aCoder.encode(error_msg, forKey: "error_msg")
        
        
        
    }

    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        customer_id <- map["customer_id"]
//        error <- map["error"]
//        error_msg <- map["error_msg"]
        
        
    }
}
