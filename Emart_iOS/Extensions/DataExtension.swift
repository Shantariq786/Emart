//
//  DataExtension.swift
//  Emart_iOS
//
//  Created by Asad Butt on 08/11/2021.
//

import Foundation
extension Data{
    var hexString:String{
        let hexString = map{String(format: "%02.2hhx",$0)}.joined()
        return hexString
    }
}
