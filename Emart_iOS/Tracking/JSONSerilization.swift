//
//  JSONSerilization.swift
//  WaterApp
//
//  Created by Yousaf Shafiq on 19/04/2020.
//  Copyright © 2020 Hexa. All rights reserved.
//

import Foundation


protocol JSONSerializable : Codable {
    var JSONRepresentation : [String : Any] { get }
}

extension JSONSerializable {
    
    
    var JSONRepresentation : [String : Any] {
        
        var representation = [String:Any]()
        
        for case let (label?, value) in Mirror(reflecting: self).children {
            
            switch value {
            case let value as Dictionary<String,Any>:
                
                representation[label] = value as AnyObject
                
            case let value as Array<Any>:
                
                if let val = value as? [JSONSerializable]{
                    representation[label] = val.map({ $0.JSONRepresentation as AnyObject}) as AnyObject
                } else {
                    representation[label] = value as AnyObject
                }
                
            case let value as JSONSerializable:
                
                representation[label] = value.JSONRepresentation
                
            case let value as AnyObject :
                
                representation[label] = value
                
            default: break
            }
        }
        return representation
    }
    
    // Convert to data by Encoding
    
    func toData()->Data? {
        
        do {
            
           return try JSONEncoder().encode(self)
            
        } catch let err {
            print("Error in Encoding ", self.JSONRepresentation, err.localizedDescription)
            return nil
        }
        
    }
    
    
    
//    func toData()->Data?{  // Convert struct directly into json request
//
//        let representation = JSONRepresentation
//
//        return getData(representation)
//
//
//    }
    
}

// MARK:- For Data

extension Data {
    
     func getDecodedObject<T>(from object : T.Type)->T? where T : Decodable {
        
        do {
            
            return try JSONDecoder().decode(object, from: self)
            
        } catch let error {
            
            print("Manually parsed  ", (try? JSONSerialization.jsonObject(with: self, options: .allowFragments)) ?? "nil")
            
            print("Error in Decoding OBject ", error)
            return nil
        }
        
    }
    
}

















////
////  TrackingOrderViewController.swift
////  WaterApp
////
////  Created by Yousaf Shafiq on 19/04/2020.
////  Copyright © 2020 Hexa. All rights reserved.
////
//
//import UIKit
//import Firebase
//import GoogleMaps
//
//class TrackingOrderViewController: UIViewController {
//
//
//    @IBAction func btnBackAction(_ sender: Any) {
//          self.navigationController?.popViewController(animated: true)
//      }
//
//    var order:Order?
//    var orderID:Int?
//
//
//    @IBOutlet weak var viewMapOuter : GMSMapView!
//
//            private var sourceCoordinate = LocationCoordinate()
//            private var destinationCoordinate = LocationCoordinate()
//
//            var providerLastLocation = LocationCoordinate()
//            lazy var markerProviderLocation : GMSMarker = {  // Provider Location Marker
//                let marker = GMSMarker()
//                let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
//                imageView.contentMode =  .scaleAspectFit
//                imageView.image = #imageLiteral(resourceName: "map-vehicle-icon-black")
//                marker.iconView = imageView
//                marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
//                marker.map = self.mapViewHelper?.mapView
//                return marker
//            }()
//
//
//
//
//
//            private var isUserInteractingWithMap = false // Boolean to handle Mapview User interaction
//            // private let transition = CircularTransition()  // Translation to for location Tap
//            var mapViewHelper : GoogleMapsHelper?
//    //        private var favouriteViewSource : LottieView?
//    //        private var favouriteViewDestination : LottieView?
//
//
//
//
//            var sourceLocationDetail : Bind<LocationDetail>? = Bind<LocationDetail>(nil)
//
//            var destinationLocationDetail : LocationDetail?
//
//            //  private var favouriteLocations : LocationService? //[(type : String,address: [LocationDetail])]() // Favourite Locations of User
//            var slatitude = "43.651070"
//            var slongitude = "-79.347015"
//
//            var currentLocation = Bind<LocationCoordinate>(defaultMapLocation)
//
//            var isRateViewShowed:Bool = false
//            var isInvoiceShowed:Bool = false
//
////            lazy var loader  : UIView = {
////                return createActivityIndicator(self.view)
////            }()
//
//            var currentRequestId = 0
//            var timerETA : Timer?
//
//            //MARKERS
//
//            var sourceMarker : GMSMarker = {
//                let marker = GMSMarker()
//               // marker.title = Constants.string.ETA.localize()
//                marker.appearAnimation = .pop
//                marker.icon =  #imageLiteral(resourceName: "sourcePin").resizeImage(newWidth: 30)
//                return marker
//            }()
//
//            private var destinationMarker : GMSMarker = {
//                let marker = GMSMarker()
//                marker.appearAnimation = .pop
//                marker.icon =  #imageLiteral(resourceName: "destinationPin").resizeImage(newWidth: 30)
//                return marker
//            }()
//
//            var markersProviders = [GMSMarker]()
//
//
//
//
//
//
//
//
//
//       override func viewWillDisappear(_ animated: Bool) {
//           super.viewWillDisappear(animated)
//           locationTimer.invalidate()
//       }
//
//
//        internal var locationTimer = Timer()
//
//        func updateUserRequest(){
//            locationTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {
//                timer in
//                self.checkRideStatus()
//            }
//        }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//           self.initialLoads()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//
//
//    // MARK:- Add Mapview
//
//    private func addMapView(){
//
//        self.mapViewHelper = GoogleMapsHelper()
//        if #available(iOS 12.0, *) {
//            if traitCollection.userInterfaceStyle == .dark{
//                self.mapViewHelper?.getMapView(withDelegate: self, in: self.viewMapOuter, interfaceStyle: .dark)
//            }else{
//                self.mapViewHelper?.getMapView(withDelegate: self, in: self.viewMapOuter, interfaceStyle: .light)
//            }
//        } else {
//            self.mapViewHelper?.getMapView(withDelegate: self, in: self.viewMapOuter, interfaceStyle: .light)
//        }
//        self.getCurrentLocationDetails()
//    }
//
//
//    //Getting current location detail
//    private func getCurrentLocationDetails() {
//        self.mapViewHelper?.getCurrentLocation(onReceivingLocation: { (location) in
//            if self.sourceLocationDetail?.value == nil {
//                self.mapViewHelper?.getPlaceAddress(from: location.coordinate, on: { (locationDetail) in
//                    DispatchQueue.main.async {
//
//                        //self.textFieldSourceLocation.text = locationDetail.address
//                        self.sourceLocationDetail?.value = locationDetail
//                    }
//
//                })
//            }
//            self.currentLocation.value = location.coordinate
//        })
//    }
//
//
//            func getDataFromFirebase(providerID:Int)  {
//
//                Database.database()
//                    .reference()
//                    .child("loc_p_\(providerID)").observe(.value, with: { (snapshot) in
//                        guard let dict = snapshot.value as? NSDictionary else {
//                            print("Error")
//                            return
//                        }
//                        var latDouble = 0.0 //for android sending any or double
//                        var longDouble = 0.0
//                        if let latitude = dict.value(forKey: "lat") as? Double {
//                            latDouble = Double(latitude)
//                            print("latitude>>>>>>>>",latitude)
//                        }else{
//                            let strLat = dict.value(forKey: "lat")
//                            latDouble = Double("\(strLat ?? 0.0)")!
//                            print("strLat>>>>>>>>",strLat as Any)
//                        }
//                        if let longitude = dict.value(forKey: "lng") as? Double {
//                            longDouble = Double(longitude)
//                             print("longitude>>>>>>>>",longitude as Any)
//                        }else{
//                            let strLong = dict.value(forKey: "lng")
//                            longDouble = Double("\(strLong ?? 0.0)")!
//                            print("strLong>>>>>>>>",strLong as Any)
//                        }
//
//    //                    if let pLatitude = latDouble, let pLongitude = longDouble {
//                            DispatchQueue.main.async {
//                                print("Moving \(latDouble) \(longDouble)")
//                                print("latitude>>>>>>",latDouble)
//                                print("longitude >>>",longDouble)
//                                self.moveProviderMarker(to: LocationCoordinate(latitude: latDouble , longitude: longDouble ))
//                                if polyLinePath.path != nil {
//                                    self.mapViewHelper?.checkPolyline(coordinate:  LocationCoordinate(latitude: latDouble , longitude: longDouble ))
//                                }
//                            }
//
//                        drawpolylineCheck = {
//                            self.drawPolyline(isReroute: true)
//                        }
//    //                    }
//                    })
//
//            }
//
//
//
//
//    func drawPolyline(isReroute:Bool) {
//
//            let currentuser =   UserDefaults.standard.string(forKey: "location")
//            var pointsArr = currentuser?.components(separatedBy: ",")
//            print("latituude>>>>",pointsArr?[0] as Any)
//            print("longitude>>>>",pointsArr?[1] as Any)
//
//            var currentLocationvalue:CLLocationCoordinate2D! //location object
//
//            currentLocationvalue = CLLocationCoordinate2D(latitude:pointsArr?[0].toDouble() ?? 0.0, longitude: pointsArr?[1].toDouble() ?? 0.0)
//
//            if var sourceCoordinate = self.sourceLocationDetail?.value?.coordinate,
//                let destinationCoordinate = self.destinationLocationDetail?.coordinate {  // Draw polyline from source to destination
//                self.mapViewHelper?.mapView?.clear()
//                self.sourceMarker.map = self.mapViewHelper?.mapView
//                self.destinationMarker.map = self.mapViewHelper?.mapView
//                if isReroute{
//                    let coordinate = CLLocationCoordinate2D(latitude: (currentLocation.value?.latitude)!, longitude: (currentLocation.value?.longitude)!)
//                    sourceCoordinate = coordinate
//                }
//                // let cord: CLLocationCoordinate2D = UserDefaults.standard.value(forKey: "location") as! CLLocationCoordinate2D
//
//                self.sourceMarker.position = sourceCoordinate
//                self.destinationMarker.position = destinationCoordinate
//                //self.selectionViewAction(in: self.viewSourceLocation)
//                //self.selectionViewAction(in: self.viewDestinationLocation)
//                self.mapViewHelper?.mapView?.drawPolygon(from:sourceCoordinate , to: destinationCoordinate)
//
//            }
//    }
//
//
//
//    func moveProviderMarker(to location : LocationCoordinate) {
//
//        if markerProviderLocation.map == nil {
//            markerProviderLocation.map = mapViewHelper?.mapView
//        }
//        let originCoordinate = CGPoint(x: providerLastLocation.latitude-location.latitude, y: providerLastLocation.longitude-location.longitude)
//        let tanDegree = atan2(originCoordinate.x, originCoordinate.y)
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(2)
//        markerProviderLocation.position = location
//        markerProviderLocation.rotation = CLLocationDegrees(tanDegree*CGFloat.pi/180)
//        CATransaction.commit()
//        self.providerLastLocation = location
//    }
//
//}
//
//
//
//extension String{
//    /// EZSE: Converts String to Double
//    public func toDouble() -> Double?
//    {
//        if let num = NumberFormatter().number(from: self) {
//            return num.doubleValue
//        } else {
//            return nil
//        }
//    }
//}
//
//
//
//
//
//// MARK:- MapView
//
//extension TrackingOrderViewController : GMSMapViewDelegate {
//
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//
//        if self.isUserInteractingWithMap {
//
//            func getUpdate(on location : CLLocationCoordinate2D, completion :@escaping ((LocationDetail)->Void)) {
//                self.drawPolyline(isReroute: false)
//
//                self.mapViewHelper?.getPlaceAddress(from: location, on: { (locationDetail) in
//                    completion(locationDetail)
//                })
//            }
//
//            if  self.sourceLocationDetail != nil {
//
//                if let location = mapViewHelper?.mapView?.projection.coordinate(for: viewMapOuter.center) {
//                    self.sourceLocationDetail?.value?.coordinate = location
//                    getUpdate(on: location) { (locationDetail) in
//                        self.sourceLocationDetail?.value = locationDetail
//                    }
//                }
//            } else if  self.destinationLocationDetail != nil {
//
//                if let location = mapViewHelper?.mapView?.projection.coordinate(for: viewMapOuter.center) {
//                    self.destinationLocationDetail?.coordinate = location
//                    getUpdate(on: location) { (locationDetail) in
//                        self.destinationLocationDetail = locationDetail
//                     //   self.updateLocation(with: locationDetail) // Update Request Destination Location
//                    }
//                }
//            }
//        }
//        //self.isMapInteracted(false)
//    }
//
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//
//        print("Gesture ",gesture)
//        self.isUserInteractingWithMap = gesture
//
////        if self.isUserInteractingWithMap {
////            self.isMapInteracted(true)
////        }
//
//    }
//
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition){}
////    {
////
////        // return
////
////        if isUserInteractingWithMap {
////
////            if self.selectedLocationView == self.viewSourceLocation, self.sourceLocationDetail != nil {
////
////                self.sourceMarker.map = nil
////                self.imageViewMarkerCenter.tintColor = .secondary
////                self.imageViewMarkerCenter.image = #imageLiteral(resourceName: "sourcePin").withRenderingMode(.alwaysTemplate)
////                self.imageViewMarkerCenter.isHidden = false
////                //                if let location = mapViewHelper?.mapView?.projection.coordinate(for: viewMapOuter.center) {
////                //                    self.sourceLocationDetail?.value?.coordinate = location
////                //                    self.mapViewHelper?.getPlaceAddress(from: location, on: { (locationDetail) in
////                //                        print(locationDetail)
////                //                        self.sourceLocationDetail?.value = locationDetail
////                ////                        let sLocation = self.sourceLocationDetail
////                ////                        self.sourceLocationDetail = sLocation
////                //                    })
////                //                }
////
////
////            } else if self.selectedLocationView == self.viewDestinationLocation, self.destinationLocationDetail != nil {
////
////                self.destinationMarker.map = nil
////                self.imageViewMarkerCenter.tintColor = .primary
////                self.imageViewMarkerCenter.image = #imageLiteral(resourceName: "destinationPin").withRenderingMode(.alwaysTemplate)
////                self.imageViewMarkerCenter.isHidden = false
////                //                if let location = mapViewHelper?.mapView?.projection.coordinate(for: viewMapOuter.center) {
////                //                    self.destinationLocationDetail?.coordinate = location
////                //                    self.mapViewHelper?.getPlaceAddress(from: location, on: { (locationDetail) in
////                //                        print(locationDetail)
////                //                        self.destinationLocationDetail = locationDetail
////                //                    })
////                //                }
////            }
////
////        }
////        //        else {
////        //            self.destinationMarker.map = self.mapViewHelper?.mapView
////        //            self.sourceMarker.map = self.mapViewHelper?.mapView
////        //            self.imageViewMarkerCenter.isHidden = true
////        //        }
////
////    }
//
//}
//
//
//
//extension TrackingOrderViewController {
//    func resetAll()
//    {
//
//        //self.textFieldSourceLocation.text = ""
//        mapViewHelper?.getCurrentLocation(onReceivingLocation: { (location) in
//
//            self.mapViewHelper?.moveTo(location: LocationCoordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), with: self.viewMapOuter.center)
//
//            self.mapViewHelper?.getPlaceAddress(from: location.coordinate, on: { (locationDetail) in  // On Tapping current location, set
//                DispatchQueue.main.async {
//
//                    //self.textFieldSourceLocation.text = locationDetail.address
//                    self.sourceLocationDetail?.value = locationDetail
//                }
//
//            })
//        })
//
//
//    }
//    private func initialLoads() {
//
//        let lat =   currentLocation.value?.latitude
//
//        UserDefaults.standard.set(lat, forKey: "lat")
//        let long =   currentLocation.value?.longitude
//        UserDefaults.standard.set(long, forKey: "long")
//
//        self.addMapView()
//        self.checkRideStatus()
//
//        self.updateUserRequest()
//
//
////            self.currentLocation.bind(listener: { (locationCoordinate) in
////                // TODO:- Handle Current Location
////
////                if locationCoordinate != nil {
////                    self.mapViewHelper?.moveTo(location: LocationCoordinate(latitude: locationCoordinate!.latitude, longitude: locationCoordinate!.longitude), with: self.viewMapOuter.center)
////                }
////            })
////
////            self.sourceLocationDetail?.bind(listener: { (locationDetail) in
//////                if locationDetail == nil {
//////                    self.isSourceFavourited = false
//////                }
////                let sourceAddress = locationDetail?.address
////
////                if self.updateStatus != .accepted && self.updateStatus != .started && self.updateStatus != .arrived && self.updateStatus != .pickedup && self.updateStatus != .searching {
////                    DispatchQueue.main.async {
////
////                        self.isSourceFavourited = false // reset favourite location on change
////
////                        if let address = sourceAddress{
////                            self.textFieldSourceLocation.text = address
////                        }
////                    }
////                }
////            })
////            NotificationCenter.default.addObserver(self, selector: #selector(self.observer(notification:)), name: .providers, object: nil)
////            NotificationCenter.default.addObserver(self, selector: #selector(self.networkChanged(notification:)), name: NSNotification.Name.reachabilityChanged, object: nil)
//
////            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShowRateView(info:)), name: .UIKeyboardWillShow, object: nil)
////            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHideRateView(info:)), name: .UIKeyboardWillHide, object: nil)      }
//            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//        }
//
//    // MARK:- View Will appear
//
//
//
//
//
//        @IBAction private func getCurrentLocation(){
//
//
//            mapViewHelper?.getCurrentLocation(onReceivingLocation: { (location) in
//
//                self.mapViewHelper?.moveTo(location: location.coordinate, with: self.viewMapOuter.center)
//                self.mapViewHelper?.getPlaceAddress(from: location.coordinate, on: { (locationDetail) in  // On Tapping current location, set
//                    DispatchQueue.main.async {
//                        //self.textFieldSourceLocation.text = locationDetail.address
//                        self.sourceLocationDetail?.value = locationDetail
//                    }
//
//
//                })
//            })
////            if currentLocation.value != nil {
////                self.mapViewHelper?.getPlaceAddress(from: currentLocation.value!, on: { (locationDetail) in  // On Tapping current location, set
////                    print("locdet", locationDetail.address, locationDetail.coordinate)
////                    if self.selectedLocationView == self.viewSourceLocation {
////                        self.sourceLocationDetail?.value = locationDetail
////                    } else if self.selectedLocationView == self.viewDestinationLocation {
////                        self.destinationLocationDetail = locationDetail
////                    }
////
////                })
////
////            }
////            self.mapViewHelper?.moveTo(location: currentLocation.value!, with: self.viewMapOuter.center)
//        }
//
//        // MARK:- Localize
//
//        // MARK:- Set Design
//
//
//
//        // MARK:- Add Mapview
//
//        // MARK:- Observer
////
////       @objc private func observer(notification : Notification) {
////
////            if notification.name == .providers, let serviceArray = notification.userInfo?[Notification.Name.providers.rawValue] as? [Service] {
////                showProviderInCurrentLocation(with: serviceArray)
////            }
////
////        }
//
//
//        // MARK:- Get Favourite Location From Local
//
//
//        // MARK:- View Location Action
//
//
//        // MARK:- Favourite Location Action
//
//
//
//        // MARK:- Show Marker on Location
//
//
//        private func plotMarker(marker : inout GMSMarker, with coordinate : CLLocationCoordinate2D){
//
//            marker.position = coordinate
//            marker.map = self.mapViewHelper?.mapView
////            self.mapViewHelper?.mapView?.animate(toLocation: coordinate)
//        }
//
//
//        // MARK:- Show Location View
//
//
//        // MARK:- Remove Location VIew
//
//    func updatePolyline()
//    {
//        if (Global.shared.isPickup && Global.shared.isStarted)
//        {
//            //MARK:- set Marker for source and destination
//            self.drawPoly(s_latitude: Global.shared.driver_lat, s_longtitude: Global.shared.driver_long, d_latitude: Global.shared.destinationLatitde, d_longtitude: Global.shared.destinationLontitude)
//
////            self.setMarker(sourceLat: c_lat, sourceLong: c_long, destinationLat: Global.shared.destinationLatitde, destinationLong: Global.shared.destinationLontitude)
//        }
//        else if (Global.shared.isStarted)
//        {
//            //MARK:- set Marker for source and destination
//
//            self.drawPoly(s_latitude: Global.shared.driver_lat, s_longtitude: Global.shared.driver_long, d_latitude: Global.shared.sourceLatitute, d_longtitude: Global.shared.sourceLongtitude)
////            self.setMarker(sourceLat: c_lat, sourceLong: c_long, destinationLat: Global.shared.sourceLongtitude, destinationLong: Global.shared.sourceLongtitude)
//        }
//    }
//
//        //MARK:- Draw Polyline
//
//    func drawPoly(s_latitude: Double?, s_longtitude : Double?, d_latitude: Double?, d_longtitude: Double?){
//
//        let polyLineSource = CLLocationCoordinate2D(latitude: s_latitude! , longitude: s_longtitude!)
//        let polyLineDestination = CLLocationCoordinate2D(latitude: d_latitude!, longitude: d_longtitude!)
////        self.plotMarker(marker: &sourceMarker, with: polyLineSource)
//        sourceMarker.map = nil
//        self.plotMarker(marker: &destinationMarker, with: polyLineDestination)
//        self.mapViewHelper?.mapView?.drawPolygon(from:polyLineSource , to: polyLineDestination)
//
//
//    }
//
//
//
//
//
//
//    // MARK:- Observe Network Changes
////    @objc private func networkChanged(notification : Notification) {
////        if let reachability = notification.object as? Reachability, ([Reachability.Connection.cellular, .wifi].contains(reachability.connection)) {
////            self.getCurrentLocationDetails()
////        }
////      }
//
//    }
//
//
//
//
//extension TrackingOrderViewController{
//
//
//    func getDriverLocation(){
//
//        guard let order = self.order else {
//            return
//        }
//        guard let supplier = order.sellerID else {
//            return
//        }
//
//
//        self.getDataFromFirebase(providerID: supplier)
//
//    }
//
//
//    func checkRideStatus(){
//
//
//
//        HomePageHelper.shared.startListening { (success) in
//            if success{
//                self.updatePolyline()
//
//                self.handler()
//
//
//
//
//
//            }
//
//        }
//
//        //  checkForProviderStatus
//
//    }
//
//
//    func handler(){
//
//
//        DispatchQueue.global(qos: .default).async {
//
//
//            guard let order = self.order else {
//                   return
//               }
//            guard let latitude = order.latitude, let longitude = order.longitude else {
//                return
//            }
//
//
//
//            self.destinationLocationDetail = LocationDetail(order.address ?? "", LocationCoordinate(latitude: latitude.toDouble() ?? 0.0, longitude: longitude.toDouble() ?? 0.0))
//            self.sourceLocationDetail?.value = LocationDetail("",LocationCoordinate(latitude: self.providerLastLocation.latitude, longitude: self.providerLastLocation.longitude))
//
//
//           // providerLastLocation
////
////                self.destinationLocationDetail = LocationDetail(dAddress, LocationCoordinate(latitude: dLatitude, longitude: dLongitude))
////                self.sourceLocationDetail?.value = LocationDetail(sAddress,LocationCoordinate(latitude: sLattitude, longitude: sLongitude))
//
//                DispatchQueue.main.async {
//                    self.drawPolyline(isReroute: false)
//                    self.getDriverLocation()
//                }
//
//
//        }
//
//
//
////        DispatchQueue.global(qos: .default).async {
////            DispatchQueue.main.async {
////                self.drawPolyline(isReroute: false)
////
////            }
////        }
//
//    }
//}
//
//
