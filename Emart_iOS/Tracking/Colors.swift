//
//  Colors.swift
//  WaterApp
//
//  Created by Yousaf Shafiq on 19/04/2020.
//  Copyright © 2020 Hexa. All rights reserved.
//

import UIKit

enum Color : Int {
    
    case primary = 1
    case secondary = 2
    case lightBlue = 3
    case brightBlue = 4
    
    
    static func valueFor(id : Int)->UIColor?{
        
        switch id {
        case self.primary.rawValue:
            return .primary
            
        case self.secondary.rawValue:
            return .secondary
            
        case self.lightBlue.rawValue:
            return .lightBlue
            
        case self.brightBlue.rawValue:
            return .brightBlue
            
        default:
            return nil
        }
        
    }
    
    
}

extension UIColor {
    
    // Primary Color
    static var primary : UIColor {
        return UIColor(red: 255/255, green: 203/255, blue: 8/255, alpha: 1)
    }
    
    // Secondary Color
    static var secondary : UIColor {
        return  UIColor(red: 255/255, green: 203/255, blue: 8/255, alpha: 1)
    }
    
    // Secondary Color
    static var rating : UIColor {
        return #colorLiteral(red: 0.9921568627, green: 0.7882352941, blue: 0.1568627451, alpha: 1) //UIColor(red: 238/255, green: 98/255, blue: 145/255, alpha: 1)
    }
    
    // Secondary Color
    static var lightBlue : UIColor {
        return #colorLiteral(red: 0.1490196078, green: 0.462745098, blue: 0.737254902, alpha: 1) //UIColor(red: 38/255, green: 118/255, blue: 188/255, alpha: 1)
    }
    
    //Gradient Start Color
    static var startGradient : UIColor {
        return UIColor(red: 83/255, green: 173/255, blue: 46/255, alpha: 1)
    }
    
    //Gradient End Color
    static var endGradient : UIColor {
        return UIColor(red: 158/255, green: 178/255, blue: 45/255, alpha: 1)
    }
    
    // Blue Color
    static var brightBlue : UIColor {
        return UIColor(red: 40/255, green: 25/255, blue: 255/255, alpha: 1)
    }
    
    func UInt()->UInt32{
        
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            
            var colorAsUInt : UInt32 = 0
            
            colorAsUInt += UInt32(red * 255.0) << 16 +
                UInt32(green * 255.0) << 8 +
                UInt32(blue * 255.0)
            return colorAsUInt
            
            // colorAsUInt == 0xCC6699 // true
        }
        return 0xCC6699
    }
}





import UIKit

extension UIImage {
    
    func resizeImage(newWidth: CGFloat) -> UIImage?{
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: newWidth, height: newHeight)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    //MARK:- Image Comparision
    
    func isEqual(to image : UIImage?) -> Bool {
        
        image!.pngData()
    
        
        guard  image != nil, let imageData1 =
                image!.pngData() else {
            return false
        }
        
        guard let imageData2 =
                self.pngData() else {
            return false
        }
        
        return imageData1 == imageData2
        
    }
    
//    //MARK:- Get Image color from specific point
//    func getPixelColor(pos: CGPoint, alpha : CGFloat = 1) -> UIColor? {
//
//        guard let pixelData =  self.cgImage?.dataProvider?.data, let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData) else {
//            return .clear
//        }
//
//        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
//
//        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
//        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
//        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
//        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
//
//        return UIColor(red: r, green: g, blue: b, alpha: a*alpha)
//    }
//
    
}
