//
//  UIViewExtensions.swift
//  EMart
//
//  Created by Asad Khan on 5/18/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import UIKit

private var vBorderColour: UIColor = UIColor.white
private var vCornerRadius: CGFloat = 0.0
private var vBorderWidth: CGFloat = 0.0
private var vMasksToBounds: Bool = true
private var vMakeCircle: Bool = false


@IBDesignable class UIView_Category: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.setNeedsLayout()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if makeCircle {
            layer.cornerRadius = self.bounds.width / 2
        }
        else {
            layer.cornerRadius = cornerRadius
        }
        layer.borderColor = vBorderColour.cgColor
        layer.borderWidth = vBorderWidth
        layer.masksToBounds = vMasksToBounds
        self.layoutIfNeeded()
    }
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        self.layoutIfNeeded()
    }
    
    
}


extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return vCornerRadius
        }
        set {
            layer.cornerRadius = newValue
            vCornerRadius = newValue
            self.setNeedsLayout()

        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return vBorderWidth
        }
        set {
            layer.borderWidth = newValue
            vBorderWidth = newValue
            self.setNeedsLayout()

        }
    }
    
    @IBInspectable var masksToBounds: Bool {
        get {
            return vMasksToBounds
        }
        set {
            layer.masksToBounds = newValue
            vMasksToBounds = newValue
            self.setNeedsLayout()

        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get{
            
            return vBorderColour
        }
        set {
            
            layer.borderColor = newValue.cgColor
            vBorderColour = newValue
            self.setNeedsLayout()

        }
    }
    
    @IBInspectable var makeCircle: Bool {
        get{
            
            return vMakeCircle
        }
        set {
            
            if newValue  {
                cornerRadius = frame.size.width / 2
                masksToBounds = true
            }
            else    {
                cornerRadius = vCornerRadius
                masksToBounds = vMakeCircle
            }
            vMakeCircle = newValue
            self.setNeedsLayout()

        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
                self.setNeedsLayout()
            }
        }
    }
    
    func centerInSuperview() {
        self.centerHorizontallyInSuperview()
        self.centerVerticallyInSuperview()
        self.setNeedsLayout()

    }
    func equalAndCenterToSupper() {
        
        self.centerHorizontallyInSuperview()
        self.centerVerticallyInSuperview()
        leadingInSuperview()
        trailingInSuperview()
        topInSuperview()
        bottomInSuperview()
        self.setNeedsLayout()
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func equalToView(constant:Int = 0){
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-\(constant)-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-\(constant)-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    }
    func centerHorizontallyInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.superview, attribute: .centerX, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    
    func centerVerticallyInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    func leadingInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute:.leadingMargin, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    func trailingInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute:.trailingMargin, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    func topInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute:.topMargin, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    func bottomInSuperview(){
        let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute:.bottomMargin, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraint(c)
    }
    
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    
//    func dropShadow(scale: Bool = true) {
//           self.layer.masksToBounds = false
//           self.layer.shadowColor = UIColor.black.cgColor
//           self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
//           self.layer.shadowRadius = 1
//           self.layer.shadowOpacity = 0.5
//       }
//       func dropShadow(size: CGSize, radius: CGFloat) {
//           self.layer.shadowColor = UIColor.black.cgColor
//           self.layer.shadowOffset = size
//           self.layer.masksToBounds = false
//           self.layer.shadowRadius = radius
//           self.layer.shadowOpacity = 0.5
//       }
       
       func dropShadowAllSides(){
           
           
           self.layer.masksToBounds = false
           self.layer.shadowColor = UIColor.darkGray.cgColor
           self.layer.shadowOffset = CGSize(width: 1.5, height: 2)
           self.layer.shadowOpacity = 0.5
           
           
       }
    
    func dropShadowAllSides(ofColor: UIColor = .darkGray , shadowSize : CGFloat){
        
        
        
        
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                             y: -shadowSize / 2,
                                                             width: self.layer.bounds.size.width + shadowSize,
                                                             height: self.layer.bounds.size.height + shadowSize))
                  self.layer.masksToBounds = false
                  self.layer.shadowColor = ofColor.cgColor
                  self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
                  self.layer.shadowOpacity = shadowOpacity
                  self.layer.shadowPath = shadowPath.cgPath
        
        
    }
    
       func dropShadowAllSides(shadowSize : CGFloat , shadowOpacity: Float){
           
           let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                      y: -shadowSize / 2,
                                                      width: self.layer.bounds.size.width + shadowSize,
                                                      height: self.layer.bounds.size.height + shadowSize))
           self.layer.masksToBounds = false
           self.layer.shadowColor = UIColor.darkGray.cgColor
           self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
           self.layer.shadowOpacity = shadowOpacity
           self.layer.shadowPath = shadowPath.cgPath
           
       }

}






//
//  ViewExtension.swift
//  Gallivant Inc
//
//  Created by Somi on 10/07/2020.
//  Copyright © 2020 HexaITSolutions. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
//    enum Transition {
//
//        case top
//        case bottom
//        case right
//        case left
//
//        var type : String {
//
//            switch self {
//
//            case .top :
//                return convertFromCATransitionSubtype(CATransitionSubtype.fromBottom)
//            case .bottom :
//                return convertFromCATransitionSubtype(CATransitionSubtype.fromTop)
//            case .right :
//                return convertFromCATransitionSubtype(CATransitionSubtype.fromLeft)
//            case .left :
//                return convertFromCATransitionSubtype(CATransitionSubtype.fromRight)
//
//            }
//
//        }
//
//    }
    
//    func
//        show(with transition : Transition, duration : CFTimeInterval = 0.5, completion : (()->())?) {
//
//        let animation = CATransition()
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        animation.type = CATransitionType.push
//        animation.subtype = convertToOptionalCATransitionSubtype(transition.type)
//        animation.duration = duration
//
//        self.layer.add(animation, forKey: convertFromCATransitionType(CATransitionType.push))
//        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//            completion?()
//        }
//    }
    
     // Set Tint color
     
//     @IBInspectable
//     var tintColorId : Int {
//
//         get {
//            return self.tintColorId
//         }
//         set(newValue){
//             self.tintColor = {
//
//                 if let color = Color.valueFor(id: newValue){
//                     return color
//                 } else {
//                     return tintColor
//                 }
//
//             }()
//         }
//     }
//
//
//    //Set background color
//
//     @IBInspectable
//     var backgroundColorId : Int {
//
//         get {
//             return self.backgroundColorId
//         }
//         set(newValue){
//             self.backgroundColor = {
//
//                 if let color = Color.valueFor(id: newValue){
//                     return color
//                 } else {
//                     return backgroundColor
//                 }
//
//             }()
//         }
//
//     }
     
     //Setting Corner Radius
     
//     @IBInspectable
//     var cornerRadius : CGFloat {
//
//         get{
//           return self.layer.cornerRadius
//         }
//
//         set(newValue) {
//             self.layer.cornerRadius = newValue
//         }
//
//     }
     
     
     //MARK:- Setting bottom Line
//
//     @IBInspectable
//     var borderWidth : CGFloat {
//         get {
//             return self.layer.borderWidth
//         }
//         set(newValue) {
//             self.layer.borderWidth = newValue
//         }
//     }
     
     
     //MARK:- Setting border color
//
//     @IBInspectable
//     var borderColor : UIColor {
//
//         get {
//
//             return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
//         }
//         set(newValue) {
//             self.layer.borderColor = newValue.cgColor
//         }
//
//     }
     
     
//     MARK:- Shadow Offset

     @IBInspectable
     var offsetShadow : CGSize {

         get {
            return self.layer.shadowOffset
         }
         set(newValue) {
             self.layer.shadowOffset = newValue
         }


     }

     
     //MARK:- Shadow Opacity
     @IBInspectable
     var opacityShadow : Float {

         get{
             return self.layer.shadowOpacity
         }
         set(newValue) {
             self.layer.shadowOpacity = newValue
         }

     }
     
     //MARK:- Shadow Color
     @IBInspectable
     var colorShadow : UIColor? {

         get{
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
         }
         set(newValue) {
             self.layer.shadowColor = newValue?.cgColor
         }
     }
     
     //MARK:- Shadow Radius
     @IBInspectable
     var radiusShadow : CGFloat {
         get {
              return self.layer.shadowRadius
         }
         set(newValue) {

            self.layer.shadowRadius = newValue
         }
     }
     
     //MARK:- Mask To Bounds

     @IBInspectable
     var maskToBounds : Bool {
         get {
             return self.layer.masksToBounds
         }
         set(newValue) {

             self.layer.masksToBounds = newValue
         }
     }

    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}


//// Helper function inserted by Swift 4.2 migrator.
//fileprivate func convertFromCATransitionSubtype(_ input: CATransitionSubtype) -> String {
//    return input.rawValue
//}
//
//// Helper function inserted by Swift 4.2 migrator.
//fileprivate func convertToOptionalCATransitionSubtype(_ input: String?) -> CATransitionSubtype? {
//    guard let input = input else { return nil }
//    return CATransitionSubtype(utf8String: input)
//}
//
//// Helper function inserted by Swift 4.2 migrator.
//fileprivate func convertFromCATransitionType(_ input: CATransitionType) -> String {
//    return input.rawValue
//}
//
//extension UINavigationBar {
//    func makeTransparent() {
//    self.setBackgroundImage(UIImage(), for: .default)
//    self.shadowImage = UIImage()
//    self.isTranslucent = true
//    }
//}

//extension UIView
//{
//    func fixInView(_ container: UIView!) -> Void{
//        self.translatesAutoresizingMaskIntoConstraints = false;
//        self.frame = container.frame;
//        container.addSubview(self);
//        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
//        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
//        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
//        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
//    }
//}




//
//  UIButtonExtension.swift
//  ChattingApp
//
//  Created by Hexacrew on 16/11/2020.
//

import Foundation
import UIKit

extension UIButton
{
    @objc var substituteFontName: String{
        get {
            return self.titleLabel!.font.fontName;
        }
        set {
            let fontNameToTest = self.titleLabel!.font.fontName.lowercased();
            var fontName = newValue;
            if fontNameToTest.range(of: "black") != nil {
                fontName += "-Black";
            }else if fontNameToTest.range(of: "bold") != nil {
                fontName += " Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.titleLabel!.font = UIFont(name: fontName, size: self.titleLabel!.font.pointSize)
        }
    }
//        {
//        get
//        {
//            return self.titleLabel!.font.fontName
//        }
//        set
//        {
//            if self.titleLabel!.font.fontName.range(of:"Thin") == nil {
//                self.titleLabel!.font = UIFont(name: newValue, size: self.titleLabel!.font.pointSize)
//            }
//        }
//    }
    
    @objc var subFont : UIFont{
        get{
            return self.titleLabel!.font
        }
        set{
            if self.titleLabel!.font.fontName.range(of:"Thin") == nil {
                self.titleLabel!.font = newValue
            }
        }

        
    }
}



//
//  LabelExtension.swift
//  Gallivant Inc
//
//  Created by Somi on 23/07/2020.
//  Copyright © 2020 HexaITSolutions. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    @objc var substituteFontName : String {
        get {
            return self.font.fontName;
        }
        set {
            let fontNameToTest = self.font.fontName.lowercased();
            var fontName = newValue;
            if fontNameToTest.range(of: "black") != nil {
                fontName += "-Black";
            }else if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font.pointSize)
        }
    }
}

//extension UILabel{
//
//    @objc var substituteFontName: String
//        {
//        get
//        {
//            return self.font.fontName
//        }
//        set
//        {
//            if self.font.fontName.range(of:"Medium") != nil {
//                self.font = UIFont(name: newValue, size: self.font.pointSize)
//            }
//            else if self.font.fontName.range(of:"SemiBold") != nil {
//                self.font = UIFont(name: newValue, size: self.font.pointSize)
//            }
//            else if self.font.fontName.range(of:"Bold") != nil {
//                self.font = UIFont(name: newValue, size: self.font.pointSize)
//            }
//            else if self.font.fontName.range(of:"Thin") == nil {
//                self.font = UIFont(name: newValue, size: self.font.pointSize)
//            }
//        }
//    }
//
//    @objc var subFont: UIFont
//        {
//        get
//        {
//            return self.font
//        }
//        set
//        {
//            if self.font.fontName.range(of:"Medium") != nil {
//                self.font = newValue
//            }
//            else if self.font.fontName.range(of:"SemiBold") != nil {
//                self.font = newValue
//            }
//            else if self.font.fontName.range(of:"Bold") != nil {
//                self.font = newValue
//            }
//            else if self.font.fontName.range(of:"Thin") == nil {
//                self.font = newValue
//            }
//        }
//    }
//
//}
