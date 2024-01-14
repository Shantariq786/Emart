//
//  extensionClasses.swift
//  oye baryani
//
//  Created by Apple on 18/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import Alamofire

extension UIApplication {

class var statusBarBackgroundColor: UIColor? {
    get {
        return statusBarUIView?.backgroundColor
    } set {
        statusBarUIView?.backgroundColor = newValue
    }
}

class var statusBarUIView: UIView? {
    if #available(iOS 13.0, *) {
        let tag = 987654321

        if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
            return statusBar
        }
        else {
            let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
            statusBarView.tag = tag

            UIApplication.shared.keyWindow?.addSubview(statusBarView)
            return statusBarView
        }
    } else {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
    }
    return nil
}}
class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
//extension UIView {
//
//    func dropShadow() {
//
//        var shadowLayer: CAShapeLayer!
//        let cornerRadius: CGFloat = self.frame.height/8
//        let fillColor: UIColor = .white
//
//        if shadowLayer == nil {
//            shadowLayer = CAShapeLayer()
//
//            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
//            shadowLayer.fillColor = fillColor.cgColor
//
//            shadowLayer.shadowColor = UIColor.black.cgColor
//            shadowLayer.shadowPath = shadowLayer.path
//            shadowLayer.shadowOffset = CGSize(width: -2.0, height: 2.0)
//            shadowLayer.shadowOpacity = 0.8
//            shadowLayer.shadowRadius = 2
//
//            layer.insertSublayer(shadowLayer, at: 0)
//        }
//    }
//}
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
extension UIViewController
{
    
    class func showAlert(inViewController:UIViewController,title:String,message:String,compeletionHandler:(()->Void)? = nil)
    {
        let AlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
        if compeletionHandler != nil
        {
            compeletionHandler!()
            
        }
        }
        AlertController.addAction(okButton)
        inViewController.present(AlertController, animated: true, completion: nil)
        
    }
    
    
    

 class func showAlertWithoutButton(inViewController:UIViewController,message:String)
    {
        let AlertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        inViewController.present(AlertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            inViewController.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
}
extension String {
    
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}

//MARK:- Capitalizing First Letter
extension String {
  func capitalizingFirstLetter() -> String {
    return prefix(1).capitalized + dropFirst()
  }
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }
}

//MARK:- UIView Round corners
extension UIView {

    func roundCorner(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

extension UIImage {

    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }

}


