//
//  TrackRiderViewController.swift
//  EMart
//
//  Created by Yousaf Shafiq on 06/09/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import FirebaseDatabase

class TrackRiderViewController: UIViewController {
    
    var mapSet = false
    var pathSet = false
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var order:Order?
    var orderID:Int?
    var orderFullDetails:OrderDetailModel?
    
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var viewMapOuter : UIView!
    
    var providerLastLocation = LocationCoordinate()
    
    lazy var markerProviderLocation : GMSMarker = {  // Provider Location Marker
        let marker = GMSMarker()
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        imageView.contentMode =  .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "ic_delivery")
        marker.iconView = imageView
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.map = self.mapViewHelper?.mapView
        return marker
    }()
    
    private var destinationMarker : GMSMarker = {
        let marker = GMSMarker()
        marker.appearAnimation = .pop
        marker.icon =  #imageLiteral(resourceName: "ic_location").resizeImage(newWidth: 30)
        return marker
    }()
    
    
    
    private var isUserInteractingWithMap = false // Boolean to handle Mapview User interaction
    // private let transition = CircularTransition()  // Translation to for location Tap
    var mapViewHelper : GoogleMapsHelper?
    
    
    
    var currentLocation = Bind<LocationCoordinate>(defaultMapLocation)
    
    
    var markersProviders = [GMSMarker]()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //           locationTimer.invalidate()
        HomePageHelper.shared.stopListening()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        locationTimer.invalidate()
    }
    
    
    internal var locationTimer = Timer()
    
    func updateUserRequest(){
        locationTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) {
            timer in
            self.checkRideStatus()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialLoads()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Add Mapview
    
    private func addMapView(){
        
        self.mapViewHelper = GoogleMapsHelper()
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark{
                self.mapViewHelper?.getMapView(withDelegate: self, in: self.viewMapOuter, interfaceStyle: .dark)
            }else{
                self.mapViewHelper?.getMapView(withDelegate: self, in: self.viewMapOuter, interfaceStyle: .light)
            }
        } else {
            self.mapViewHelper?.getMapView(withDelegate: self, in: self.viewMapOuter, interfaceStyle: .light)
        }
        self.getCurrentLocationDetails()
    }
    
    
    //Getting current location detail
    private func getCurrentLocationDetails() {
        
        self.mapViewHelper?.getCurrentLocation(onReceivingLocation: { (location) in
            self.currentLocation.value = location.coordinate
            
        })
    }
    
    func getDataFromFirebase(providerID:Int)  {
        
        Database.database()
            .reference()
            .child("54").child("location").observe(.value, with: { (snapshot) in
                guard let dict = snapshot.value as? NSDictionary else {
                    print("Error")
                    return
                }
                var latDouble = 0.0 //for android sending any or double
                var longDouble = 0.0
                if let latitude = dict.value(forKey: "latitude") as? Double {
                    latDouble = Double(latitude)
                    print("latitude>>>>>>>>",latitude)
                }else{
                    let strLat = dict.value(forKey: "lat")
                    latDouble = Double("\(strLat ?? 0.0)")!
                    print("strLat>>>>>>>>",strLat as Any)
                }
                if let longitude = dict.value(forKey: "longitude") as? Double {
                    longDouble = Double(longitude)
                    print("longitude>>>>>>>>",longitude as Any)
                }else{
                    let strLong = dict.value(forKey: "lng")
                    longDouble = Double("\(strLong ?? 0.0)")!
                    print("strLong>>>>>>>>",strLong as Any)
                }
                
                
                let bearingValue = dict.value(forKey: "bearing") as? Double
                //print("bearingValue ",bearingValue)
                
                DispatchQueue.main.async {
                    print("Moving \(latDouble) \(longDouble)")
                    print("latitude>>>>>>",latDouble)
                    print("longitude >>>",longDouble)
                    
                    
                    if !self.mapSet{
                        self.mapSet = true
                        self.setGooglemap(location: LocationCoordinate(latitude: latDouble , longitude: longDouble ), bearingValue: bearingValue ?? 290.00)
                    }
                    
                    self.moveProviderMarker(to: LocationCoordinate(latitude: latDouble , longitude: longDouble ))
                    if polyLinePath.path != nil {
                        
                        if !self.pathSet {
                            self.pathSet = true
                            self.mapViewHelper?.moveTo(location: LocationCoordinate(latitude: latDouble , longitude: longDouble ), with: self.viewMapOuter.center)
                            self.mapViewHelper?.checkPolyline(coordinate:  LocationCoordinate(latitude: latDouble , longitude: longDouble ))
                        }
                        
                        
                        
                    }
                }
                
                drawpolylineCheck = {
                    self.drawPolyline(isReroute: true)
                }
            })
        
    }
    
    
    func drawPolyline(isReroute:Bool) {
        
        let currentuser =   UserDefaults.standard.string(forKey: "location")
        let pointsArr = currentuser?.components(separatedBy: ",")
        print("latituude>>>>",pointsArr?[0] as Any)
        print("longitude>>>>",pointsArr?[1] as Any)
        
        var currentLocationvalue:CLLocationCoordinate2D! //location object
        
        currentLocationvalue = CLLocationCoordinate2D(latitude:pointsArr?[0].toDouble() ?? 0.0, longitude: pointsArr?[1].toDouble() ?? 0.0)
        
        guard let order = orderFullDetails?.records![0] else {return}
        guard let location = order.location else {return}
        print("location is ",location)
       
       // let location = "33.569446,73.059311"
        
        let array = location.components(separatedBy: ",")
        print(array)
        
        if array.count == 0 {
            return
        }
        let latitude = array[0]
        let longitude = array[1]
        
        self.mapViewHelper?.mapView?.clear()
        self.destinationMarker.map = self.mapViewHelper?.mapView
        if isReroute{
            let coordinate = CLLocationCoordinate2D(latitude: (currentLocation.value?.latitude)!, longitude: (currentLocation.value?.longitude)!)
            // sourceCoordinate = coordinate
            
            self.providerLastLocation = coordinate
        }
        
        let destinationCoordinate = CLLocationCoordinate2D(latitude: latitude.toDouble() ?? 0.0, longitude: longitude.toDouble() ?? 0.0)
        
        self.destinationMarker.position = destinationCoordinate
        //self.selectionViewAction(in: self.viewSourceLocation)
        //self.selectionViewAction(in: self.viewDestinationLocation)
        self.mapViewHelper?.mapView?.drawPolygon(from:providerLastLocation , to: destinationCoordinate)
        
        
        
    }
    
    
    func moveProviderMarker(to location : LocationCoordinate) {
        
        if markerProviderLocation.map == nil {
            markerProviderLocation.map = mapViewHelper?.mapView
        }
        let originCoordinate = CGPoint(x: providerLastLocation.latitude-location.latitude, y: providerLastLocation.longitude-location.longitude)
        let tanDegree = atan2(originCoordinate.x, originCoordinate.y)
        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        markerProviderLocation.position = location
        markerProviderLocation.rotation = CLLocationDegrees(tanDegree*CGFloat.pi/180)
        CATransaction.commit()
        self.providerLastLocation = location
    }
    
}



extension String{
    /// EZSE: Converts String to Double
    public func toDouble() -> Double?
    {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
}





// MARK:- MapView

extension TrackRiderViewController : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition){}
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {}
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition){}
    
    
}


extension TrackRiderViewController {
    
    private func initialLoads() {
        
        let lat =   currentLocation.value?.latitude
        UserDefaults.standard.set(lat, forKey: "lat")
        let long =   currentLocation.value?.longitude
        UserDefaults.standard.set(long, forKey: "long")
        self.addMapView()
        self.checkRideStatus()
        //        self.updateUserRequest()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK:- View Will appear
    
    private func setGooglemap(location: CLLocationCoordinate2D , bearingValue:Double){

        self.mapViewHelper?.mapView?.camera = GMSCameraPosition(target: location, zoom: 18, bearing: bearingValue, viewingAngle: 10.00)
    }
    
    @IBAction private func getCurrentLocation(){
        
        
        mapViewHelper?.getCurrentLocation(onReceivingLocation: { (location) in
            
            self.mapViewHelper?.moveTo(location: location.coordinate, with: self.viewMapOuter.center)
            self.mapViewHelper?.getPlaceAddress(from: location.coordinate, on: { (locationDetail) in  // On Tapping current location, set
                DispatchQueue.main.async {
                    //self.textFieldSourceLocation.text = locationDetail.address
                    // self.sourceLocationDetail?.value = locationDetail
                }
                
                
            })
        })
    }
    
    private func plotMarker(marker : inout GMSMarker, with coordinate : CLLocationCoordinate2D){
        marker.position = coordinate
        marker.map = self.mapViewHelper?.mapView
    }
    
    func updatePolyline(){
        guard let order = orderFullDetails?.records![0] else {return}
        guard let location = order.location else {return}
        print("location is ",location)

       // let location = "33.569446,73.059311"
        let array = location.components(separatedBy: ",")
        print(array)
        
        if array.count == 0 {
            return
        }
        let latitude = array[0]
        let longitude = array[1]
        
       
        
        self.drawPoly(s_latitude: providerLastLocation.latitude, s_longtitude: providerLastLocation.longitude, d_latitude: latitude.toDouble() ?? 0.0, d_longtitude: longitude.toDouble() ?? 0.0)
        
    }
    
    //MARK:- Draw Polyline
    
    func drawPoly(s_latitude: Double?, s_longtitude : Double?, d_latitude: Double?, d_longtitude: Double?){
        
        let polyLineSource = CLLocationCoordinate2D(latitude: s_latitude! , longitude: s_longtitude!)
        let polyLineDestination = CLLocationCoordinate2D(latitude: d_latitude!, longitude: d_longtitude!)
        
        self.plotMarker(marker: &destinationMarker, with: polyLineDestination)
        self.mapViewHelper?.mapView?.drawPolygon(from:polyLineSource , to: polyLineDestination)
        
        
    }
    
}


extension TrackRiderViewController{
    func getDriverLocation(){
        //
        //        guard let order = self.order else {
        //            return
        //        }
        //        guard let supplier = order.sellerID else {
        //            return
        //        }
        //
        
        self.getDataFromFirebase(providerID: orderID ?? 0)
        
    }
    
    
    func checkRideStatus(){
        self.updatePolyline()
        
        self.handler()
        //        HomePageHelper.shared.startListening { (success) in
        //            if success{
        //                self.updatePolyline()
        //
        //                self.handler()
        //            }
        //        }
    }
    
    
    func handler(){
        
        DispatchQueue.global(qos: .default).async {
            
            //            guard let location = self.order?.location else {
            //                return
            //            }
            //
            //            let array = location.components(separatedBy: ",")
            //            print(array)
            //
            //            if array.count == 0 {
            //                return
            //            }
            //            let latitude = array[0]
            //            let longitude = array[1]
            
            DispatchQueue.main.async {
                self.drawPolyline(isReroute: false)
                self.getDriverLocation()
            }
        }
    }
    
    
}

