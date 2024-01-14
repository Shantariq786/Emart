//
//  OyeBaryaniMainAPI.swift
//  oye baryani
//
//  Created by Apple on 19/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
class EMartAPIManager {
    static var shared = EMartAPIManager()
    //Login
    func ForErrorMessage(url:URL,parameter:Parameters,completionHandler: @escaping (String?,Bool?)->Void) {
        
        
        AF.request(url, method: .post, parameters:parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
//                if let json = response.result.value as? NSDictionary{
                if let json = response.value as? NSDictionary{
                    if  let error = json["error"] as? Bool {
                        if  let error_msg = json["error_msg"] as? String {
                            if (error == false) {
                                completionHandler(error_msg, error)
                            }
                            else {
                                completionHandler(error_msg, error)
                            }
                            
                            
                        }
                        
                    }
                    
                }
            case .failure:
//                if let json = response.result.value{
                if let json = response.value{
                    print(json)
                }
                break
            }
        }
    }
    //Redistration Now
//    func RegisterUser(url:URL,parameter:Parameters,completionHandler: @escaping (ResgistrationAPI?,Bool?)->Void) {
//
//        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON{
//            response in
//            switch response.result {
//            case .success:
//                let json = response.data
//                do{
//                    let decoder = JSONDecoder()
//
//                    let registerdata = try decoder.decode(ResgistrationAPI.self, from: json!)
//                    if registerdata.error ?? false == false {
//                        completionHandler(registerdata,false)
//                    }
//                    else {
//                        completionHandler(nil,true)
//                    }
//                }catch {
//                    completionHandler(nil,true)
//                }
//            case .failure:
//                completionHandler(nil,true)
//            }
//        }
//    }
    func SettingData(url:URL,parameter:Parameters?,completionHandler: @escaping (SettingAPI?,Bool?)->Void) {
        AF.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    
                    let settingdata = try decoder.decode(SettingAPI.self, from: json!)
                    if settingdata.error ?? false == false {
                        completionHandler(settingdata,false)
                    }
                    else {
                        completionHandler(nil,true)
                    }
                }catch {
                    completionHandler(nil,true)
                }
            case .failure:
                completionHandler(nil,true)
            }
        }
    }
    
    //Show Address
    func ShowAddress(url:URL,parameter:Parameters,completionHandler: @escaping (ShowAddressAPI?,Bool?)->Void)
    {
        
        AF.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON{
            response in
            
            switch response.result {
            case .success:
                let json = response.data
                
                do{
                    let decoder = JSONDecoder()
                    
                    let addressdata = try decoder.decode(ShowAddressAPI.self, from: json!)
                    if addressdata.error ?? false == false
                    {
                        completionHandler(addressdata,false)
                    }
                    else
                    {
                        completionHandler(nil,true)
                    }
                }catch
                {
                    completionHandler(nil,true)
                }
            case .failure:
                completionHandler(nil,true)
                
                
            }
        }
    }
    
    // UserOrderRequestAPI
    func getAllUserOrders(url:URL,parameter:Parameters?,completionHandler: @escaping (UserOrderRequestAPI?,Bool?)->Void)
    {
        AF.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON{
            response in
            switch response.result {
            case .success:
                let json = response.data
                
                do{
                    let decoder = JSONDecoder()
                    
                    let userorders = try decoder.decode(UserOrderRequestAPI.self, from: json!)
                    if userorders.error ?? false == false
                    {
                        completionHandler(userorders,false)
                    }
                    else
                    {
                        completionHandler(nil,true)
                    }
                }catch
                {
                    completionHandler(nil,true)
                }
            case .failure:
                completionHandler(nil,true)
                
                
            }
        }
    }
    //UserOrderSingleDataAPI
    
    func getRiderAcceptedOrders(url:URL,parameter:Parameters?,completionHandler: @escaping (UserOrderSingleDataAPI?,Bool?)->Void)
    {
        AF.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON{
            response in
            switch response.result {
            case .success:
                let json = response.data
                
                do{
                    let decoder = JSONDecoder()
                    
                    let userorders = try decoder.decode(UserOrderSingleDataAPI.self, from: json!)
                    if userorders.error ?? false == false
                    {
                        completionHandler(userorders,false)
                    }
                    else
                    {
                        completionHandler(nil,true)
                    }
                }catch
                {
                    completionHandler(nil,true)
                }
            case .failure:
                completionHandler(nil,true)
                
                
            }
        }
    }
    func getUserCartedProduct(url:URL,parameter:Parameters,completionHandler: @escaping (ProductDetailData?,Bool?)->Void)
    {
        AF.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON{
            response in
            switch response.result {
            case .success:
                let json = response.data
                
                do{
                    let decoder = JSONDecoder()
                    
                    let cartsproduct = try decoder.decode(ProductDetailData.self, from: json!)
                    if cartsproduct.error ?? false == false
                    {
                        completionHandler(cartsproduct,false)
                    }
                    else
                    {
                        completionHandler(nil,true)
                    }
                }catch
                {
                    completionHandler(nil,true)
                }
            case .failure:
                completionHandler(nil,true)
                
                
            }
        }
    }
    
    func getCartsProduct(url:URL,parameter:Parameters,completionHandler: @escaping (CardProductDetail?,Bool?)->Void)
    {
        AF.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON{
            response in
            switch response.result {
            case .success:
                let json = response.data
                
                do{
                    let decoder = JSONDecoder()
                    
                    let cartsproduct = try decoder.decode(CardProductDetail.self, from: json!)
                    if cartsproduct.error ?? false == false
                    {
                        completionHandler(cartsproduct,false)
                    }
                    else
                    {
                        completionHandler(nil,true)
                    }
                }catch
                {
                    completionHandler(nil,true)
                }
            case .failure:
                completionHandler(nil,true)
                
                
            }
        }
    }
    
    func getOrderDetailProduct(url:URL,parameter:Parameters,completionHandler: @escaping (orderProductAPI?,Bool?)->Void)
    {
        AF.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON{
            response in
            switch response.result {
            case .success:
                let json = response.data
                
                do{
                    let decoder = JSONDecoder()
                    
                    let cartsproduct = try decoder.decode(orderProductAPI.self, from: json!)
                    if cartsproduct.error ?? false == false
                    {
                        completionHandler(cartsproduct,false)
                    }
                    else
                    {
                        completionHandler(nil,true)
                    }
                }catch
                {
                    completionHandler(nil,true)
                }
            case .failure:
                completionHandler(nil,true)
                
                
            }
        }
    }
    
    func CheckCopen(url:URL,parameter:Parameters,completionHandler: @escaping (String?,Double?,Bool?)->Void) {
        AF.request(url, method: .post, parameters:parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON
        {
            response in
            switch response.result {
            case .success:
                //                if let json = response.result.value as? NSDictionary{
                if let json = response.value as? NSDictionary{
                    if  let error = json["error"] as? Bool
                    {
                        if  let error_msg = json["error_msg"] as? String
                        {
                            if (error == false)
                            {
                                if let price = json["price"] as? Double
                                {
                                    completionHandler(error_msg,price, error)
                                }
                            }
                            else
                            {
                                completionHandler(error_msg,nil, error)
                            }
                        }
                    }
                }
            case .failure:
                
                //                completionHandler(response.result.error.debugDescription,nil, nil)
                
                completionHandler(response.error.debugDescription,nil, nil)
            }
        }
    }
    
    
    //OrderDetail
//    func getUserOrderDetail(url:URL,parameter:Parameters,completionHandler: @escaping (OrderDetailAPI?,Bool?)->Void){
//        AF.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil).responseJSON{
//            response in
//            switch response.result {
//            case .success:
//                let json = response.data
//                
//                do{
//                    let decoder = JSONDecoder()
//                    
//                    let orderDetail = try decoder.decode(OrderDetailAPI.self, from: json!)
//                    if orderDetail.error ?? false == false
//                    {
//                        completionHandler(orderDetail,false)
//                    }
//                    else
//                    {
//                        completionHandler(nil,true)
//                    }
//                }catch
//                {
//                    completionHandler(nil,true)
//                }
//            case .failure:
//                completionHandler(nil,true)
//                
//                
//            }
//        }
//    }
    
    func getsliderData(url:URL,completion:@escaping ((showSliderAPI?,String)->())) {
        //let url = AppConfig.getsliderimgUrl
        //let url = "https://emart.pkgadget.com/api/showSliders.php"
        AF.request(url, method: .post, parameters: nil, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let myData = try decoder.decode(showSliderAPI.self, from: json!)
                    completion(myData, "")
                }catch(let exception){
                    completion(nil, exception.localizedDescription)
                }
            case .failure:
                completion(nil, response.error?.localizedDescription ?? "")
            }
        }
    }
    
    func showMainCategoryData(url:URL,completion:@escaping ((showMainCategoryAPI?,String)->())) {
       // let url = "https://emart.pkgadget.com/api/showMainCategory.php"
        
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(imageOrVideo!.jpegData(compressionQuality: 0.5)!, withName: "profile_image" , fileName: uuid + ".jpeg", mimeType: "image/jpeg")
//            multipartFormData.append(Data(self.doctorid!.utf8), withName: "doctorid")
//            multipartFormData.append(Data(self.fname!.utf8), withName: "fname")
//            multipartFormData.append(Data(self.lname!.utf8), withName: "lname")
//            multipartFormData.append(Data(self.mc.text!.utf8), withName: "degrees")
//            multipartFormData.append(Data(self.cit.text!.utf8), withName: "city")
//            multipartFormData.append(Data(self.sp.text!.utf8), withName: "specialty")
//            multipartFormData.append(Data("".utf8), withName: "facility")
//            multipartFormData.append(Data(self.exp.text!.utf8), withName: "experience")
//            multipartFormData.append(Data(self.no.text!.utf8), withName: "phone")
//            multipartFormData.append(Data(self.titles!.utf8), withName: "title")
//            multipartFormData.append(Data(self.username!.utf8), withName: "username")
//            multipartFormData.append(Data(self.sessionid!.utf8), withName: "sessionid")
//            multipartFormData.append(Data("DOCTOR".utf8), withName: "usertype")
//        },
//        to: url , method:  , headers: nil)
//            .response { resp in
//                // print(resp.response)
//                UserDefaults.standard.removeObject(forKey: "image")
//                UserDefaults.standard.set(self.fname!, forKey: "fname")
//                UserDefaults.standard.set(self.lname!, forKey: "lname")
//                UserDefaults.standard.set(self.titles!, forKey: "title")
//                UserDefaults.standard.set(self.mc.text!, forKey: "degrees")
//                UserDefaults.standard.set(self.exp.text!, forKey: "experience")
//                UserDefaults.standard.set(self.no.text!, forKey: "phone")
//                UserDefaults.standard.set(self.sp.text!, forKey: "specialty")
//                UserDefaults.standard.set(self.cit.text!, forKey: "city")
//                UserDefaults.standard.set(uuid + ".jpeg", forKey: "image")
//                //           self.loadprofiledata()
//                self.removeAllOverlays()
//        }
//    }
        AF.request(url, method: .post, parameters: nil, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let myData = try decoder.decode(showMainCategoryAPI.self, from: json!)
                    completion(myData, "")
                }catch(let exception){
                    completion(nil, exception.localizedDescription)
                }
            case .failure:
                completion(nil, response.error?.localizedDescription ?? "")
            }
        }
    }
    func showRestaurantsData(url:URL,parameter:Parameters,completion:@escaping ((showRestaurantsAPI?,String)->())) {
        showHud()
      //  let url = "https://emart.pkgadget.com/api/showRestaurants.php"
        AF.request(url, method: .post, parameters: parameter, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                hideHud()
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let myData = try decoder.decode(showRestaurantsAPI.self, from: json!)
                    completion(myData, "")
                }catch(let exception){
                    completion(nil, exception.localizedDescription)
                }
            case .failure:
                hideHud()
                completion(nil, response.error?.localizedDescription ?? "")
            }
        }
    }
    
    func searchProductsData(url:URL,parameter:Parameters,completion:@escaping ((SearchProductAPI?,String)->())) {
      //  let url = "https://emart.pkgadget.com/api/showRestaurants.php"
        AF.request(url, method: .post, parameters: nil, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success:
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let myData = try decoder.decode(SearchProductAPI.self, from: json!)
                    completion(myData, "")
                }catch(let exception){
                    completion(nil, exception.localizedDescription)
                }
            case .failure:
                completion(nil, response.error?.localizedDescription ?? "")
            }
        }
    }
    
}









