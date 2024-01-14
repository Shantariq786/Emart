//
//  GoogleMapsHelper.swift
//  WaterApp
//
//  Created by Yousaf Shafiq on 19/04/2020.
//  Copyright © 2020 Hexa. All rights reserved.
//

import Foundation
import GoogleMaps
import MapKit



let defaultMapLocation = LocationCoordinate(latitude: 43.651070, longitude: -79.347015)
var polyLinePath = GMSPolyline()


enum interfaceStyle{
    case dark
    case light
}

typealias LocationCoordinate = CLLocationCoordinate2D
typealias LocationDetail = (address : String, coordinate :LocationCoordinate)

var drawpolylineCheck : (()->())?

private struct Place : Decodable {
    
    var results : [Address]?
    
}

private struct Address : Decodable {
    
    var formatted_address : String?
    var geometry : Geometry?
}

private struct Geometry : Decodable {
    
    var location : Location?
    
}

private struct Location : Decodable {
    
    var lat : Double?
    var lng : Double?
}



class GoogleMapsHelper : NSObject {
    
    var mapView : GMSMapView?
    var locationManager : CLLocationManager?
    private var currentLocation : ((CLLocation)->Void)?
    
    func traitHasBeenChanged(interfaceStyle style: interfaceStyle){
        self.setMapStyle(to : mapView, interfaceStyle: style)
        
    }

    func getMapView(withDelegate delegate: GMSMapViewDelegate? = nil, in view : UIView, withPosition position :LocationCoordinate = defaultMapLocation, zoom : Float = 18, interfaceStyle style: interfaceStyle) {
        
       mapView = GMSMapView(frame: view.frame)
        self.setMapStyle(to : mapView, interfaceStyle: style)
       //mapView?.isMyLocationEnabled = true
       mapView?.delegate = delegate
       mapView?.camera = GMSCameraPosition.camera(withTarget: position, zoom: 18)
       
       view.addSubview(mapView!)
    }
    
    func getCurrentLocation(onReceivingLocation : @escaping ((CLLocation)->Void)){
        
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.distanceFilter = 50
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
        self.currentLocation = onReceivingLocation
    }
    
    func moveTo(location : LocationCoordinate = defaultMapLocation, with center : CGPoint) {
        print("loc", location)
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        CATransaction.setCompletionBlock {
            self.mapView?.animate(to: GMSCameraPosition.camera(withTarget: location, zoom: 18))
        }
        CATransaction.commit()
        DispatchQueue.main.async {
            self.mapView?.center = center  //  Getting current location marker to center point
        }
        
 
    }
    // Setting Map Style
    private func setMapStyle(to mapView: GMSMapView?, interfaceStyle style: interfaceStyle){
        
        var mapStyle = "Map_style"
        
        switch style {
        case .dark:
            mapStyle = "Map_style_dark"
            break
        default:
            break
        }
        
        do {
            // Set the map style by passing a valid JSON string.
            if let url = Bundle.main.url(forResource: mapStyle, withExtension: "json") {
                mapView?.mapStyle = try GMSMapStyle(contentsOfFileURL: url)
                
            }else {
                print("error")
            }
            
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    func getPlaceAddress(from location : LocationCoordinate, on completion : @escaping ((LocationDetail)->())){
        
        /*if !geoCoder.isGeocoding {
            
            geoCoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) { (placeMarks, error) in
                
                guard error == nil, let placeMarks = placeMarks else {
                    print("Error in retrieving geocoding \(error?.localizedDescription ?? .Empty)")
                    return
                }
            
                
                
                guard let placemark = placeMarks.first, let address = (placeMarks.first?.addressDictionary!["FormattedAddressLines"] as? Array<String>)?.joined(separator: ","), let coordinate = placemark.location else {
                    print("Error on parsing geocoding ")
                    return
                }
                
                
                completion((address,coordinate.coordinate))
                
                print(placeMarks)
                
            }
            
        } */
        
        
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(location.latitude),\(location.longitude)&key=\(Keys.GOOGLE_API_KEY)"
        
        guard let url = URL(string: urlString) else {
            print("Error in creating URL Geocoding")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let places = data?.getDecodedObject(from: Place.self), let address = places.results?.first?.formatted_address, let lattitude = places.results?.first?.geometry?.location?.lat, let longitude = places.results?.first?.geometry?.location?.lng {
                
                completion((address, LocationCoordinate(latitude: lattitude, longitude: longitude)))
            }
            
            
        }.resume()
        
    
        
    }
    
    
}


extension GoogleMapsHelper: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
          print("Location: \(location)")
          self.currentLocation?(location)
            if polyLinePath.path != nil {
                self.checkPolyline(coordinate: location.coordinate)
            }
            if manager.location?.coordinate != nil  {
                
                let  location:CLLocationCoordinate2D = manager.location!.coordinate
                print("****TEST", String(location.latitude))
                print("****TEST", String(location.longitude))
                let get = String(location.latitude) + "," + String(location.longitude)
                UserDefaults.standard.set(get, forKey: "location")
                
//                let myData = NSKeyedArchiver.archivedData(withRootObject: location)
//                UserDefaults.standard.set(myData, forKey: "location")

                
//                var userDefaults = UserDefaults.standard
//                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: location)
//                userDefaults.set(encodedData, forKey: "Location")
//                userDefaults.synchronize()
//
//                let decoded  = userDefaults.data(forKey: "Location")
//                let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! LocationPlaces
//                print("decodedTeams",decodedTeams)
            }
            
            
        }
        
    }
    
    func storeCoordinates(_ coordinates: [CLLocationCoordinate2D]) {
        let locations = coordinates.map { coordinate -> CLLocation in
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
        let archived = NSKeyedArchiver.archivedData(withRootObject: locations)
        UserDefaults.standard.set(archived, forKey: "Location")
        UserDefaults.standard.synchronize()
    }
    
    // Return an array of CLLocationCoordinate2D
    func loadCoordinates() -> [CLLocationCoordinate2D]? {
        guard let archived = UserDefaults.standard.object(forKey: "Location") as? Data,
            let locations = NSKeyedUnarchiver.unarchiveObject(with: archived) as? [CLLocation] else {
                return nil
        }
        
        let coordinates = locations.map { location -> CLLocationCoordinate2D in
            return location.coordinate
        }
    
        return coordinates
    }
    
    
    
    
    
    
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager?.stopUpdatingLocation()
        print("Error: \(error)")
    }
    func checkPolyline(coordinate: CLLocationCoordinate2D)  {
        if GMSGeometryContainsLocation(coordinate, polyLinePath.path!, true)
        {
            print("=== true")
        }
        else
        {
//            drawpolylineCheck!()
            print("=== false")
        }
    }
}
