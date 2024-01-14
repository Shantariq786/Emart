////
////  CustomDesigns.swift
////  TourismPakistan
////
////  Created by Obaid Khan on 29/01/2020.
////  Copyright © 2020 Obaid Khan. All rights reserved.
////
//
//import Foundation
//import UIKit
///*
//class RoundedButtonWithShadow: UIButton {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.layer.masksToBounds = false
//        self.layer.cornerRadius = self.frame.height/2
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowRadius = 1.0
//    }
//}
//class RoundedViewWithShadow: UIView {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.layer.masksToBounds = false
//        self.layer.cornerRadius = self.frame.height/4
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowRadius = 1.0
//    }
//}
//
//extension UIView {
//    
//    func applyShadowWithCornerRadius(color:UIColor, opacity:Float, radius: CGFloat, edge:AIEdge, shadowSpace:CGFloat)    {
//        
//        var sizeOffset:CGSize = CGSize.zero
//        switch edge {
//        case .Top:
//            sizeOffset = CGSize(width: 0, height: -shadowSpace)
//        case .Left:
//            sizeOffset = CGSize(width: -shadowSpace, height: 0)
//        case .Bottom:
//            sizeOffset = CGSize(width: 0, height: shadowSpace)
//        case .Right:
//            sizeOffset = CGSize(width: shadowSpace, height: 0)
//            
//            
//        case .Top_Left:
//            sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace)
//        case .Top_Right:
//            sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace)
//        case .Bottom_Left:
//            sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace)
//        case .Bottom_Right:
//            sizeOffset = CGSize(width: shadowSpace, height: shadowSpace)
//            
//            
//        case .All:
//            sizeOffset = CGSize(width: 0, height: 0)
//        case .None:
//            sizeOffset = CGSize.zero
//        }
//        
//        self.layer.cornerRadius = self.frame.size.height / 4
//        self.layer.masksToBounds = true;
//        
//        self.layer.shadowColor = color.cgColor
//        self.layer.shadowOpacity = opacity
//        self.layer.shadowOffset = sizeOffset
//        self.layer.shadowRadius = radius
//        self.layer.masksToBounds = false
//        
//        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
//    }
//}
//
//enum AIEdge:Int {
//    case
//    Top,
//    Left,
//    Bottom,
//    Right,
//    Top_Left,
//    Top_Right,
//    Bottom_Left,
//    Bottom_Right,
//    All,
//    None
//}
// */
//
//final class CustomViewWithShadow: UIView {
//    
//    private var shadowLayer: CAShapeLayer!
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        if shadowLayer == nil {
//            shadowLayer = CAShapeLayer()
//            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.layer.frame.height/9).cgPath
//            shadowLayer.fillColor = UIColor.white.cgColor
//            
//            shadowLayer.shadowColor = UIColor.darkGray.cgColor
//            shadowLayer.shadowPath = shadowLayer.path
//            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//            shadowLayer.shadowOpacity = 0.8
//            shadowLayer.shadowRadius = 2
//            
//            layer.insertSublayer(shadowLayer, at: 0)
//            //layer.insertSublayer(shadowLayer, below: nil) // also works
//        }
//    }
//    
//}
//
