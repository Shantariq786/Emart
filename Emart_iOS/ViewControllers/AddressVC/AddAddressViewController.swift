//
//  AddAddressViewController.swift
//  oye baryani
//
//  Created by Apple on 17/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SVProgressHUD
class AddAddressViewController: UIViewController,CLLocationManagerDelegate {
    
    
    var addressString : String = ""
    var gpslocation:String = ""
    
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    
    let llocationManager = CLLocationManager()
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //addShadowToBtn(button: homeBtn)
        
        getGPSAddress()
    }
    
    
    func addShadowToBtn(button:UIButton){
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
    }
   
    func getGPSAddress() {
        llocationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = llocationManager.location
            //print(currentLoc.coordinate.latitude)
            // print(currentLoc.coordinate.longitude)
        }
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func SaveAddressButtonTapped(_ sender: UIButton) {
        
        
        guard let user = UserStateHolder.loggedInUser else{
            return
        }
        
        if titleTextField.text == "" || addressTextField.text == ""{
            UIViewController.showAlertWithoutButton(inViewController: self, message: "Please Enter All Data")
            return
        }
        
        guard let title = titleTextField.text, let address = addressTextField.text else {return}
        
        
        let paramerter = ["address":address,"location":gpslocation,"gps_address":locationTextField.text!,"user_email": user.email ?? "","title":title] as [String:Any]
        print(paramerter)
        guard let url = URL(string: URLPath.AddAddress) else {
            print("URL Error")
            return
        }
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.show(withStatus: "Adding Address")
        EMartAPIManager.shared.ForErrorMessage(url: url, parameter: paramerter) { (errorMessage, error) in
            SVProgressHUD.dismiss()
            print("come")
            if error == false{
                print("error is false")
                UIViewController.showAlertWithoutButton(inViewController: self, message: "Address saved Successfully")
                self.navigationController?.popViewController(animated: true)
            }
            else{
                UIViewController.showAlertWithoutButton(inViewController: self, message: errorMessage ?? "error")
            }
        }
        
        
    }
    
    @IBAction func PopNavigationController(_ sender: UIButton){
           self.navigationController?.popViewController(animated: true)
       }
}
extension AddAddressViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let userLocation :CLLocation = locations[0] as CLLocation
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        gpslocation = "\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)"
        getAddressFromLatLon(pdblLatitude: userLocation.coordinate.latitude, withLongitude : userLocation.coordinate.longitude)
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude : Double){
        addressString = ""
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = pdblLatitude
        let lon: Double = withLongitude
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:{
            (placemarks, error) in
            if (error != nil){
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            guard let place = placemarks else{
                print("cannot get Location")
                return
            }
            let pm = place
            if pm.count > 0{
                let pm = placemarks![0]
                if pm.subLocality != nil{
                    self.addressString = self.addressString + pm.subLocality! + ","
                }
                if pm.thoroughfare != nil {
                    self.addressString = self.addressString + pm.thoroughfare! + ","
                }
                if pm.locality != nil {
                    self.addressString = self.addressString + pm.locality! + ","
                }
                if pm.country != nil {
                    self.addressString = self.addressString + pm.country!
                }
                if self.addressString != ""{
                    
                    
                    print("addressString \(self.addressString)")
                    self.locationTextField.text = self.addressString
                }
                
            }
        })
        
    }
}

