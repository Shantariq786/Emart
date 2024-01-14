//
//  UIStoryBoard+Extension.swift
//  EMart
//
//  Created by Asad Khan on 6/9/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import UIKit
extension UIStoryboard
{
   public enum Storyboard:String
    {
        case main = "Main"
        case OnBoarding = "OnBoarding"
        case forums = "Forums"
        case profile = "Profile"
    case auth = "Auth"
    case home = "Home"

    }
    
    class var main:UIStoryboard
    {
        
        return UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
        
    }
    class var OnBoarding:UIStoryboard
       {
           
           return UIStoryboard(name: Storyboard.OnBoarding.rawValue, bundle: nil)
           
       }
    class var forums:UIStoryboard
    {
        
        return UIStoryboard(name: Storyboard.forums.rawValue, bundle: nil)
        
    }
    class var profile:UIStoryboard
       {
           
           return UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil)
           
       }
    class var auth:UIStoryboard
       {
           
           return UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil)
           
       }
    class var home:UIStoryboard
       {
           
           return UIStoryboard(name: Storyboard.home.rawValue, bundle: nil)
           
       }
    
    
    
    
}
