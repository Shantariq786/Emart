//
//  TrackingHelper.swift
//  WaterApp
//
//  Created by Yousaf Shafiq on 22/04/2020.
//  Copyright © 2020 Hexa. All rights reserved.
//

import Foundation
import UIKit

class HomePageHelper {
    
    private var timer : Timer?
    static var shared = HomePageHelper()
    // MARK:- Start Listening for Provider Status Changes
    func startListening(on completion : @escaping ((Bool)->Void)) {
        
        DispatchQueue.main.async {
            self.stopListening()
            self.timer = Timer.scheduledTimer(withTimeInterval: requestCheckInterval, repeats: true, block: { (_) in
                    completion(true)
            })
            self.timer?.fire()
        }
        
    }
    
    //MARK:- Stop Listening
    func stopListening() {
        // DispatchQueue.main.async {
        self.timer?.invalidate()
        self.timer = nil
        // }
    }
    
    

    
    
}



let requestCheckInterval : TimeInterval = 5
