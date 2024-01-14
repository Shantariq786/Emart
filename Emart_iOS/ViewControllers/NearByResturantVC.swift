//
//  NearByResturantVC.swift
//  EMart
//
//  Created by Asad Khan on 6/21/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import GoogleMaps

class NearByResturantVC: UIViewController {
    
    
    var nearby :[showRestaurantsRecords]?
    
    @IBOutlet weak var mapView:GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nearBy = self.nearby{
            self.showCurrentLocationOnMap(records: nearBy)
        }else{
            getResturentData()
        }

       
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
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
                    self.showCurrentLocationOnMap(records: records)
                }
                
            } else {
               
            }
        })
        
    }
    
    
    func showCurrentLocationOnMap(records:[showRestaurantsRecords]) {

        let camera = GMSCameraPosition.camera(withLatitude: 33.642386, longitude: 73.064686, zoom: 10.0) //Set default lat and long
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
