//
//  WelcomeBackViewController.swift
//  EMart
//
//  Created by Asad Khan on 6/20/21.
//  Copyright © 2021 Apple. All rights reserved.
// 60 - 30 - 30

import UIKit
import GoogleMaps
import DropDown
import SVProgressHUD

class WelcomeBackViewController: UIViewController,CLLocationManagerDelegate {
    //, CLLocationManagerDelegate {
    
    var selecteIndex = 0
    var showAddressData:ShowAddressAPI?
    
    var nearby :[showRestaurantsRecords]?
    @IBOutlet weak var mapView:GMSMapView!
    @IBOutlet weak var addressViewLine: UIView!
    
    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var addressDec: UILabel!
    
    let llocationManager = CLLocationManager()
    var locationManager:CLLocationManager!
    
    var addressString : String = ""
    var subAddress = ""
    
    var isMoveToAddressScreen = false
    
    let dropDown:DropDown = {
        let dropDown = DropDown()
        dropDown.dataSource = []
        
        //cell design
        let appearance = DropDown.appearance()
        appearance.cellHeight = 60
        
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.animationduration = 0.25
        
        
        return dropDown
    }()
    
    var email = UserStateHolder.loggedInUser?.email ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getResturentData()
        setupDropDown()
        
        getGPSAddress()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        ShowAddresses()
        
        if isMoveToAddressScreen == true{
            isMoveToAddressScreen = false
            let mainStoryBoard = UIStoryboard(name: "Porfile", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
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
    
    func setupDropDown(){
        dropDown.anchorView = addressViewLine
        dropDown.dismissMode = .onTap
        
        
        // setup cell
        dropDown.cellNib = UINib(nibName: "AddressCell", bundle: nil)
        dropDown.customCellConfiguration = { [self] (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? AddressCell else { return }
            
            if showAddressData?.records?[index] != nil{
                
                cell.optionLabel.text = showAddressData!.records![index].address
                cell.addressDesc.text =  showAddressData!.records![index].gps_address
                
                if index == selecteIndex{
                    cell.addressImage.image = #imageLiteral(resourceName: "tick")
                }else{
                    cell.addressImage.image = #imageLiteral(resourceName: "circle")
                }
            }
        }
        
        
        //tap index
        dropDown.selectionAction = {(index: Int, item: String) in
            print("index: \(index)")
            self.selecteIndex = index
            self.setHeaderAdress()
        }
    }
    
    func ShowAddresses(){
        
        guard let user = UserStateHolder.loggedInUser else {
            return
        }
        
        guard let url = URL(string: URLPath.ShowAddresses) else {
            print("URL Error")
            return
        }
        
        let parameter = ["email":user.email ?? ""]
        EMartAPIManager.shared.ShowAddress(url: url, parameter: parameter) {[self] (ShowAddressData, error) in
            if (error == false){
                
                let address = ShowAddressData
                showAddressData = address
                showAddressData?.records = address!.records?.sorted(by:{$0.id! > $1.id!})
                
                self.dropDown.dataSource = self.makeEmptyArray(count: ShowAddressData?.records?.count ?? 0)
                self.dropDown.reloadAllComponents()
                self.setHeaderAdress()
                
            }
            else{
                UIViewController.showAlertWithoutButton(inViewController: self, message: "Address not Found")
            }
        }
        
        
    }
    
    func setHeaderAdress(){
        if showAddressData?.records?[selecteIndex] != nil{
            addressTitle.text = showAddressData!.records![selecteIndex].address
            addressDec.text =  showAddressData!.records![selecteIndex].gps_address
        }
    }
    
    
    func makeEmptyArray(count:Int)->[String]{
        var emptyArray = [String]()
        var check = 0
        while (check < count){
            emptyArray.append("")
            check += 1
        }
        return emptyArray
    }
    
    
    
    
    @IBAction func showAdress(_ sender: UIButton) {
        dropDown.show()
        //dropDown.hide()
    }
    
    @IBAction func addAdressTapped(_ sender: Any) {
        
        if email == ""{
            let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: "LOGINViewController") as! LOGINViewController
            vc.loginProtocol = self
            self.navigationController!.pushViewController(vc, animated: true)
        }else{
            let mainStoryBoard = UIStoryboard(name: "Porfile", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func orderFoodButtontapped(_ sender: UIButton) {
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        //        self.navigationController?.pushViewController(vc, animated: true)
        let vc = TabBarViewController()
        vc.isOrderFoodSelected = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func orderGroceryButtontapped(_ sender: UIButton) {
        let vc = TabBarViewController()
        vc.isOrderFoodSelected = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func pickupButtontapped(_ sender: UIButton) {
        let vc = TabBarViewController()
        vc.isOrderFoodSelected = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func mapButtontapped(_ sender: UIButton) {
        
        let vc = TrackRiderViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func shopBtnTapped(_ sender:UIButton){
        //        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ShopHomeController") as! ShopHomeController
        //        self.navigationController?.pushViewController(vc, animated: true)
        
        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
        
    }
    
    
}



extension WelcomeBackViewController {
    func getResturentData() {
        
        guard let email = UserStateHolder.loggedInUser?.email else{
            return
        }
        
        //  type_id
        let paramater :[String:Any] = ["email":email,"location":"33.649346,73.079227","type_id":"1"]
        guard let url2 = URL(string:"https://emart.pkgadget.com/api/showVendors.php") else {
            print("url error")
            return
        }
        
        EMartAPIManager.shared.showRestaurantsData(url: url2, parameter: paramater, completion: { data, error in
            if data != nil {
                
                if let records = data?.records{
                    self.nearby = records
                    self.showCurrentLocationOnMap(records: records)
                }
                
            } else {
                
            }
        })
        
    }
    
    
    func loadMapsView(records:[showRestaurantsRecords]) {
        
        for record in records {
            let state_marker = GMSMarker()
            
            if let place = record.location{
                let placeSeprated = place.components(separatedBy: ",")
                state_marker.position = CLLocationCoordinate2D(latitude: Double(placeSeprated[0])!, longitude: Double(placeSeprated[1])!)
            }
            
            
            state_marker.icon = UIImage(named: "MainIcon")
            state_marker.map = mapView
        }
        
    }
    
    
    func showCurrentLocationOnMap(records:[showRestaurantsRecords]) {
        let camera = GMSCameraPosition.camera(withLatitude: 33.642386, longitude: 73.064686, zoom: 8.0)
        mapView.camera = camera
        for record in records {
            let state_marker = GMSMarker()
            
            if let place = record.location{
                let placeSeprated = place.components(separatedBy: ",")
                state_marker.position = CLLocationCoordinate2D(latitude: Double(placeSeprated[0])!, longitude: Double(placeSeprated[1])!)
            }
            
            
            state_marker.icon = UIImage(named: "emart_logo")
            state_marker.map = mapView
            
        }
    }
    
    
}


extension WelcomeBackViewController:LoginProtocol{
    func loginDoneTapped() {
        isMoveToAddressScreen = true
        email = UserStateHolder.loggedInUser?.email ?? ""
    }
    
    
}


//MARK: -               ADDRESS

extension WelcomeBackViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                let userLocation :CLLocation = locations[0] as CLLocation
                getAddressFromLatLon(pdblLatitude: userLocation.coordinate.latitude, withLongitude : userLocation.coordinate.longitude)

            }
        }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude : Double){
        addressString = ""
        subAddress = ""
        
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
                    self.subAddress = self.subAddress + pm.locality! + " "
                }
                if pm.country != nil {
                    self.addressString = self.addressString + pm.country!
                    self.subAddress = self.subAddress + pm.country! + " "
                }
                if self.addressString != ""{
                    
                    print("self.subAddress ",self.subAddress )
                    print("self.addressDec ",self.addressDec )
                    
                    self.addressTitle.text = self.subAddress
                    self.addressDec.text = self.addressString
                }
                
            }
        })
        
    }
}
