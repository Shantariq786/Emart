//
//  Utils.swift
//  EMart
//
//  Created by Yousaf Shafiq on 01/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import SVProgressHUD

import JDStatusBarNotification
import Kingfisher




//var appSetting:Settings?

func setupStatusBar() {
    JDStatusBarNotification.setDefaultStyle { (style) -> JDStatusBarStyle? in
//        style.font = //Fonts.getFontWith(name: .SFRegular, size: 12)
        style.barColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        style.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return style
    }
}

func showStatusBarAlert(Str:String, Duration:Double) {
    JDStatusBarNotification.show(withStatus: Str, dismissAfter: Duration, styleName: "failure")
}
func showStatusBarAlertSuccess(Str:String, Duration:Double) {
    JDStatusBarNotification.show(withStatus: Str, dismissAfter: Duration, styleName: JDStatusBarStyleSuccess)
}


//MARK:- SV Hud Methods

func showSuccessHud(status: String?){
    SVProgressHUD.setBorderWidth(1.0)
    SVProgressHUD.setBorderColor(.green)
    SVProgressHUD.showSuccess(withStatus: status)
    SVProgressHUD.dismiss(withDelay: 0.5)
}

func showErrorHud(status: String?)
{
    SVProgressHUD.showError(withStatus: status)
    SVProgressHUD.dismiss(withDelay: 0.5)
}

func showHud(customMessage:String = ""){
    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)    //gradient
    SVProgressHUD.show(withStatus: nil)
    if customMessage == "" {
        SVProgressHUD.show(withStatus: "Please Wait")
    }else{
        SVProgressHUD.show(withStatus: "Please Wait" + "\n" + customMessage)
    }
}

func hideHud(){
    SVProgressHUD.dismiss()
}




struct AlertTitle {
    static let UNAUTHORISED_USER = "Unauthorized User"
    static let NETWORK_ERROR = "No internet connection."
    static let ALERT_WEBSERVICE_ERROR = "Something went wrong! Please try again"
    static let SIGNUP_LINK_MESSAGE = "Verification link has been sent to your account, please check your inbox and verify it."
}





func downloadImagesCustom(imageView:UIImageView, urlString:String){
    let url = URL(string: urlString)
    let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                 |> RoundCornerImageProcessor(cornerRadius: 4)
    imageView.kf.indicatorType = .activity
    imageView.kf.setImage(
        with: url,
        placeholder: UIImage(named: "sample_visa_placeholder"),
        options: [
            .processor(processor),
            .transition(.fade(1)),
            .cacheOriginalImage
        ]){
        result in
        switch result {
        case .success(let value):
            print("Task done for: \(value.source.url?.absoluteString ?? "")")
            UIImageWriteToSavedPhotosAlbum(value.image, nil, nil, nil)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}







//MARK:- Userdefault Methods
func setIntoUserDefault (key:String, value:Any) {
    UserDefaults.standard.set(value, forKey: key)
}

func getFromUserDefault(key:String) -> Any {
    return UserDefaults.standard.value(forKey: key) as Any
}

//MARK:- User defaults
func cacheObject(object:AnyObject, forKey key:String) -> Bool {
    userDefault.set(object, forKey: key)
    return userDefault.synchronize()
}

func cachedObjectForKey(key:String) -> AnyObject? {
    return userDefault.object(forKey: key) as AnyObject?
}

func cacheBool(boolValue:Bool, forKey key:String) -> Bool {
    userDefault.set(boolValue, forKey: key)
    return userDefault.synchronize()
}

func cachedBoolForKey(key:String) -> Bool? {
    return userDefault.bool(forKey: key)
}

func cacheCustomObject(object:AnyObject, forKey key:String) -> Bool {
    userDefault.set(NSKeyedArchiver.archivedData(withRootObject: object), forKey: key)
    return userDefault.synchronize()
}

func cachedCustomObjectForKey(key:String) -> AnyObject? {
    if let data = UserDefaults.standard.object(forKey: key) as? Data {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject?
    }
    else {
        return nil
    }
}


func cacheCustomArrayObject(object:[AnyObject], forKey key:String) -> Bool {

    userDefault.set(NSKeyedArchiver.archivedData(withRootObject: object), forKey: key)
    return userDefault.synchronize()
}
func cachedCustomArrayObjectForKey(key:String) -> [AnyObject]? {
    
    
    if let data = UserDefaults.standard.object(forKey: key) as? Data {
        do {
            if let loadedMeals = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [AnyObject] {
                return loadedMeals
            }
        } catch {
            print("Couldn't read file.")
            return nil
        }
    }
    return nil

}


func isEmpty(_ thing : String? )->Bool {
    
    if (thing?.count == 0) {
        return true
    }
    return false;
}

func removeCachedObjectForKey(key:String) -> Bool {
    userDefault.removeObject(forKey: key)
    return userDefault.synchronize()
}





//Application Theme Colors


func AppBlackColor() -> UIColor{
    return UIColor(named: "AppBlackColor")!
}

func AppPrimaryColor() -> UIColor{
    return UIColor(named: "AppPrimaryColor")!
}

func AppDarkGrayColor() -> UIColor{
    return UIColor(named: "AppDarkGrayColor")!
}

func AppGrayColor() -> UIColor{
    return UIColor(named: "AppGrayColor")!
}

func AppLightGrayColor() -> UIColor{
    return UIColor(named: "AppLightGrayColor")!
}


