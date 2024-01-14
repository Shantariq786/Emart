//
//  GMSMapView.swift
//  WaterApp
//
//  Created by Yousaf Shafiq on 19/04/2020.
//  Copyright © 2020 Hexa. All rights reserved.
//

import GoogleMaps

private struct MapPath : Decodable{
    
    var routes : [Route]?
    
}

private struct Route : Decodable{
    
    var overview_polyline : OverView?
    var legs : [LegsObject]?
}

private struct OverView : Decodable {
    
    var points : String?
}

private struct LegsObject : Decodable {
    var duration : DurationObject?
}

private struct DurationObject : Decodable {
    var text : String?
}

extension GMSMapView {
    
    
    //MARK:- Call API for polygon points
    
    func drawPolygon(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
       
        self.getGoogleResponse(between: source, to: destination) { (mapPath) in
            if let points = mapPath.routes?.first?.overview_polyline?.points {
//                DispatchQueue.main.async {
//                    Global.shared.polyline.map = nil
//                }
                
                self.drawPath(with: points)

            }
        }
    }
    
    
    // MARK;- Get estimation between coordinates
    
//    func getEstimation(between source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion : @escaping((String)->Void)) {
//        self.getGoogleResponse(between: source, to: destination) { (mapPath) in
//            if let estimationString = mapPath.routes?.first?.legs?.first?.duration?.text {
//                completion(estimationString)
//            }
//        }
//    }
    
    // Get response Between Coordinates
    private func getGoogleResponse(between source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion : @escaping((MapPath)->Void)) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(Keys.GOOGLE_API_KEY)") else {
            return
        }
        
        
        DispatchQueue.main.async {
            session.dataTask(with: url) { (data, response, error) in
               print("Inside Polyline ", data != nil)
                guard data != nil else {
                    return
                }
                do {
                    let parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                    print(parsedResult)

                    let mapPath = try JSONDecoder().decode(MapPath.self, from: data!)
                     completion(mapPath)
                   // print("Routes === \(mapPath.routes!)")
                    print(mapPath.routes?.first?.overview_polyline?.points as Any)
                    
                } catch let error {
                    
                    print("Failed to draw ",error.localizedDescription)
                }
                
                }.resume()
        }
        
        
        
    }
    
    
    
    
    //MARK:- Draw polygon
    
    private func drawPath(with points : String){
        

                DispatchQueue.main.async {
                    
             
                    //Global.shared.polyline.map = nil
                    guard let path = GMSPath(fromEncodedPath: points) else { return }
                    Global.shared.polyline = GMSPolyline(path: path)
                    Global.shared.polyline.strokeWidth = 3.0
                    Global.shared.polyline.strokeColor = .lightBlue
                    Global.shared.polyline.map = self
                    var bounds = GMSCoordinateBounds()
                    for index in 1...path.count() {
                        
                        bounds = bounds.includingCoordinate(path.coordinate(at: index))
                    }
        //            self.animate(with: .fit(bounds))
                }
        
        
       // print("Drawing Polyline ", points)
        
//        DispatchQueue.main.async {
//
//            guard let path = GMSPath(fromEncodedPath: points) else { return }
//            Global.shared.polyline = GMSPolyline(path: path)
//            polyLinePath = Global.shared.polyline
//            Global.shared.polyline.strokeWidth = 3.0
//            Global.shared.polyline.strokeColor = .blue
//            Global.shared.polyline.map = self
//            var bounds = GMSCoordinateBounds()
//            for index in 1...path.count() {
//                bounds = bounds.includingCoordinate(path.coordinate(at: index))
//            }
//            self.animate(with: .fit(bounds))
//        }
        
    }
    
}





import Foundation
import UIKit
import GoogleMaps

//private struct MapPath : Decodable{
//
//    var routes : [Route]?
//
//}
//
//private struct Route : Decodable{
//
//    var overview_polyline : OverView?
//}
//
//private struct OverView : Decodable {
//
//    var points : String?
//}

extension GMSMapView {
    
    //MARK:- Call API for polygon points
    
    func drawPolygonSupplier(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(Keys.GOOGLE_API_KEY)") else {
            return
        }
        
        DispatchQueue.main.async {
            
            session.dataTask(with: url) { (data, response, error) in
                
                guard data != nil else {
                    return
                }
                
                do {
                    
                    let route = try JSONDecoder().decode(MapPath.self, from: data!)
//                    NotificationCenter.default.post(name: "clearMap", object: nil)
//                    NotificationCenter.default.post(name: Notification.Name(rawValue: "clearMap"), object: nil)
                    self.removePolyLine()
                    if let points = route.routes?.first?.overview_polyline?.points {
                        self.drawPathSupplier(with: points)
                    }
                    
                    print("polyLinePath:\(route.routes?.first?.overview_polyline?.points ?? "")")
                    
                } catch let error {
                    
                    print("Failed to draw ",error.localizedDescription)
                }
                
                
                }.resume()
            
            
        }
        
        
    }
    
    //MARK:- Draw polygon
    
    private func drawPathSupplier(with points : String){
        
        DispatchQueue.main.async {
            
            guard let path = GMSPath(fromEncodedPath: points) else { return }
            Global.shared.polyline = GMSPolyline(path: path)
            Global.shared.polyline.strokeWidth = 3.0
            Global.shared.polyline.strokeColor = .lightBlue
            Global.shared.polyline.map = self
            var bounds = GMSCoordinateBounds()
            for index in 1...path.count() {
                bounds = bounds.includingCoordinate(path.coordinate(at: index))
            }
//            self.animate(with: .fit(bounds))
        }
        
    }
    
    

    private func removePolyLine()
    {
        
        DispatchQueue.main.async {
            Global.shared.polyline.map = nil
        }
        
    }
    
    
}
