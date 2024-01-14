//
//  Bind.swift
//  WaterApp
//
//  Created by Yousaf Shafiq on 19/04/2020.
//  Copyright © 2020 Hexa. All rights reserved.
//

import Foundation

class Bind<T> {
  
   typealias Listener = (T?) -> Void
    
    var listener : Listener?
    
    var value : T? {
        
        didSet {
            listener?(value)
        }
    }
    
    init(_ value : T?) {
        self.value = value
    }
    
    func bind(listener : Listener?) {
        
        self.listener = listener
        listener?(value)
        
    }
    
}




import GoogleMaps
class Global {

class var shared : Global {
    
    struct Static {
        static let instance : Global = Global()
    }
    return Static.instance
    }
    var distance = 0.0
    var lat = 0.0
    var long = 0.0
    var newLat = 0.0
    var newLong = 0.0
    var polyline = GMSPolyline()
    
    var sourceLatitute   = 0.0
    var sourceLongtitude = 0.0
    var destinationLatitde = 0.0
    var destinationLontitude = 0.0
    var driver_lat = 0.0
    var driver_long = 0.0
    var isOnRide = false
    var isPickup = false
    var isStarted = false
    
    var invoiceCount = 0
    
    var isGetNullInTotal = false
    
    
    var getZeroo = ""
    
}
