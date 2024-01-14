//
//  HomeViewController.swift
//  EMart
//
//  Created by Asad Khan on 5/3/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import CoreLocation

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var foodSearchBar: UITextField!
    var obj_showRestaurants:showRestaurantsAPI?
    
    var pushManager: PushNotificationManager?
    var selectedIndexPath:IndexPath!
    var delegate:SlideMenuDelegate?
    
    let llocationManager = CLLocationManager()
    var locationManager:CLLocationManager!
    var gpslocation:String = ""
    
    var isfirstTime = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        roundedView.roundCorner([.topRight,.bottomRight], radius: 20)
        
        
        mainTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        mainTableView.register(UINib(nibName: "RestuarantsTableViewCell", bundle: nil), forCellReuseIdentifier: "RestuarantsTableViewCell")
        
        mainTableView.register(UINib(nibName: "FeaturedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeaturedTableViewCell")
        
        
        mainTableView.estimatedRowHeight = 100
        mainTableView.tableFooterView = UIView()
        
        self.updateToken()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        isfirstTime = true
        getGPSAddress()
        
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton){
        //move to search screen
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.seachText = foodSearchBar.text ?? ""
        self.navigationController?.pushViewController(vc , animated: true)
    }
    
    func updateToken(){
          self.pushManager = PushNotificationManager()
          self.pushManager?.updateFirestorePushTokenIfNeeded()
      }
}

//MARK: -                   API REQUEST

extension HomeViewController {
    func getResturentData() {
        
        let email = UserStateHolder.loggedInUser?.email ?? ""
        
        let paramater :[String:Any] = ["email":email,"location":gpslocation,"type_id":"1"]
        guard let url2 = URL(string:"https://edelivero.com/api/showVendors.php") else {
            print("url error")
            return
        }
        EMartAPIManager.shared.showRestaurantsData(url: url2, parameter: paramater, completion: { data, error in
            if data != nil {
                self.obj_showRestaurants = data
                self.mainTableView.reloadData()
            } else {
                print("no data found")
            }
        })
        
        }
}


//MARK: -                       TABLEVIEW FUNCTIONS

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4{
            if let resturants = obj_showRestaurants?.records!{
                return resturants.count
            }
        }else{
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 ||  indexPath.section == 1 ||  indexPath.section == 2 ||  indexPath.section == 3 {
            
            if let resturants = obj_showRestaurants?.records!.filter({ $0.sec_id == "\(indexPath.section+1)" }){
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedTableViewCell") as! FeaturedTableViewCell
                cell.setupData(records: resturants)
                cell.vc = self
                return cell
            }
            
        }
        
        if indexPath.section == 4 {
            if let resturants = obj_showRestaurants?.records!{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RestuarantsTableViewCell") as! RestuarantsTableViewCell
                cell.setData(record: resturants[indexPath.row], indepath: indexPath)
                cell.allResturantHeatButtonProtocol = self
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3{
            return 220
        }else{
            return 320
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewCustom = Bundle.main.loadNibNamed("HeaderHomeView", owner: self, options: nil)![0] as! HeaderHomeView
        viewCustom.section = section
        viewCustom.headerViewProtocol = self
        if section == 0 {
            viewCustom.headerLabel.text = "Featured"
        }else if section == 1 {
            viewCustom.headerLabel.text = "Mostly Rated"
        }else if section == 2 {
            viewCustom.headerLabel.text = "Deals"
        }else if section == 3 {
            viewCustom.headerLabel.text = "Super Deals"
        }else if section == 4 {
            viewCustom.headerLabel.text = "All Restaurants"
        }
        
        return viewCustom

       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped at in home \(indexPath)")
        
        if indexPath.section == 4 {
   
            let StoryBoard = UIStoryboard(name: "Resturant", bundle: nil)
            let Nextvc = StoryBoard.instantiateViewController(withIdentifier: "ResturantDetailViewController") as! ResturantDetailViewController
            Nextvc.resturantData = obj_showRestaurants?.records?[indexPath.row]
            Nextvc.indexPath = indexPath
            Nextvc.resturantDetailProtocol = self
            self.navigationController?.pushViewController(Nextvc,animated: true)
        }
    }
    
}


//MARK: -                       CUSTOM PROTOCOLS //form tablview cell

extension HomeViewController:AllResturantHeatButtonProtocol{
    func allResturantHeartButtonPressed(indepath: IndexPath) {
        selectedIndexPath = indepath
        let email = UserStateHolder.loggedInUser?.email ?? ""
        if email == ""{
            let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: "LOGINViewController") as! LOGINViewController
            vc.loginProtocol = self
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            loginDoneTapped()
        }
        
    }
    
}

// MARK: -           WHEN THE USER HIT HEART FROM RESTURANT DETAIL SCREEN

extension HomeViewController:ResturantDetailProtocol{
    func resturantDetailHeartBtnTapped(indexPath: IndexPath, resturantData: showRestaurantsRecords) {
        print("call from main screen")
        obj_showRestaurants?.records?[indexPath.row] = resturantData
        mainTableView.reloadRows(at: [indexPath], with: .none)
    }
}



// MARK: -                  VIEW ALL PROTOCOLS


extension HomeViewController:HeaderViewProtocol{
    func viewAllBtnTapped(section: Int) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ViewAllViewController") as! ViewAllViewController
        if section == 0 {
            vc.screenTitle = "Featured"
            if let resturants = obj_showRestaurants?.records!.filter({ $0.sec_id == "1" }){
                vc.resturants = resturants
            }
        }else if section == 1 {
            vc.screenTitle = "Mostly Rated"
            if let resturants = obj_showRestaurants?.records!.filter({ $0.sec_id == "2" }){
                vc.resturants = resturants
            }
        }else if section == 2 {
            vc.screenTitle = "Deals"
            if let resturants = obj_showRestaurants?.records!.filter({ $0.sec_id == "3" }){
                vc.resturants = resturants
            }
        }else if section == 3 {
            vc.screenTitle = "Super Deals"
            if let resturants = obj_showRestaurants?.records!.filter({ $0.sec_id == "4" }){
                vc.resturants = resturants
            }
        }else if section == 4 {
            vc.screenTitle = "All Restaurants"
            if let resturants = obj_showRestaurants?.records!{
                vc.resturants = resturants
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}




//MARK: -               LOGIN PROTOCOL

extension HomeViewController:LoginProtocol{
    func loginDoneTapped() {
        
        let currentFavStat = Int((obj_showRestaurants?.records?[selectedIndexPath.row].is_fav)!)
        if currentFavStat == 0{
            // make it favourite
            obj_showRestaurants?.records?[selectedIndexPath.row].is_fav = "1"
        }else{
            //remove if from favourite
            obj_showRestaurants?.records?[selectedIndexPath.row].is_fav = "0"
        }
        
        mainTableView.reloadRows(at: [selectedIndexPath], with: .none)
        
        
        //update on server
        
        guard let isLike = obj_showRestaurants?.records?[selectedIndexPath.row].is_fav , let vendor_email = obj_showRestaurants?.records?[selectedIndexPath.row].email else{return}
        guard let user = UserStateHolder.loggedInUser else{return}
        
        let parameters =  ["islike" : isLike , "vendor_email":vendor_email , "user_email":user.email]
        print(parameters)
        APIService.sharedInstance.updateFav(parameters: parameters as [String : Any]) { favouriteRes in
            if favouriteRes.error == false{
                print("favourite error ",favouriteRes.error_msg as Any)
            }
        } failure: { (error) -> (Void) in
            
        }
    }
}



//MARK: -               LOCATION PICKER

extension HomeViewController:CLLocationManagerDelegate{
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let userLocation :CLLocation = locations[0] as CLLocation
        gpslocation = "\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)"
        if isfirstTime == true{
            isfirstTime = false
            self.getResturentData()
            UserDefaults.standard.set(gpslocation, forKey: "gpslocation")
        }else{
            let needToHitApi = checkGPSDifference(userLocation)
            if needToHitApi == true{
                self.getResturentData()
                UserDefaults.standard.set(gpslocation, forKey: "gpslocation")
            }
        }
       
        
    }
    func checkGPSDifference(_ coordinate₁:CLLocation)->Bool{
        let coordinate₀ = getLocation()
        print("coordinate₀ ",coordinate₀)
        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
        if distanceInMeters > 50{
            return true
        }else{
            return false
        }
    }
    
    func getLocation()->CLLocation{
        let locationString = UserDefaults.standard.string(forKey: "gpslocation")!
        let dataArray = locationString.components(separatedBy: ",")
        let lat = Double(dataArray[0])!
        let long = Double(dataArray[1])!
        let location = CLLocation(latitude: lat, longitude: long)
        return location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}




