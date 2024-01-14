

import UIKit
import MapKit
import GoogleMaps

class OrderMapLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var trackerOrderBtn: UIButton!
    @IBOutlet weak var googleMapView: UIView!
    
    var mapView:GMSMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        GMSServices.provideAPIKey(Keys.GOOGLE_API_KEY)
        
    }
    
    
    func setData(orderFullDetails:OrderDetailModel?){
        guard let order = orderFullDetails else {return}

        guard let userLocationString = order.records?[0].location else {return}
        guard let venderLocationString =  order.records?[0].vendor?.location else {return}


        let userLoc = getLocation(location: userLocationString)
        let venderLoc = getLocation(location: venderLocationString)


        let camera = GMSCameraPosition.camera(withLatitude: userLoc.coordinate.latitude, longitude: userLoc.coordinate.longitude, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: googleMapView.frame, camera: camera)
        self.googleMapView.addSubview(mapView)
        

        addAnnotations(location: userLoc, title: "User")
        addAnnotations(location: venderLoc, title: "Vender")
        
    }
    
    
    func addAnnotations(location: CLLocation , title:String){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.title = title
        marker.map = mapView

        }
    
    func getLocation(location:String)->CLLocation{
        let locArray = location.components(separatedBy: ",")
        let lat = Double(locArray[0]) ?? 0
        let long = Double(locArray[1]) ?? 0
        
        let location = CLLocation(latitude: lat, longitude: long)
        
        return location
    }
    
}

