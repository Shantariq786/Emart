//
//  RestuarantsTableViewCell.swift
//  EMart
//
//  Created by Asad Khan on 5/10/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import Kingfisher
protocol AllResturantHeatButtonProtocol {
    func allResturantHeartButtonPressed(indepath:IndexPath)
}
class RestuarantsTableViewCell: UITableViewCell {

    var allResturantHeatButtonProtocol:AllResturantHeatButtonProtocol!
    @IBOutlet weak var restuarantImageview: UIImageView!
    @IBOutlet weak var restuarantNameLbl: UILabel!
    @IBOutlet weak var deliveryTimeLbl: UILabel!
    @IBOutlet weak var deliveryPriceLbl: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var heatBtn: UIButton!
    
    
    @IBOutlet weak var freeDeliveryLabel: UILabel!
    
    var indepath:IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        freeDeliveryLabel.layer.cornerRadius = 15.0
        freeDeliveryLabel.clipsToBounds = true
//        restuarantImageview.layer.cornerRadius = 8.0;
//        restuarantImageview.contentMode = UIView.ContentMode.scaleAspectFill
//        restuarantImageview.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        restuarantImageview.layer.shadowOpacity = 0.4
    }
    
    @IBAction func heartBtnTapped(_ sender: Any) {
        allResturantHeatButtonProtocol.allResturantHeartButtonPressed(indepath: indepath)
    }
    
    func setData(record: showRestaurantsRecords? , indepath:IndexPath) {
        self.indepath = indepath
        if let url = URL(string: "\(BASEURL.imageUrl)\(record?.thumb ?? "")"){
            restuarantImageview.load(url: url)
        }
        descriptionLabel.text = record!.description ?? ""
        restuarantNameLbl.text = record?.name ?? ""
//        deliveryTimeLbl.text = record?.timings ?? ""
//        descriptionLbl.text = record?.description ?? ""
//        deliveryPriceLbl.text = record?.rating ?? ""
        
        if let rating = record?.rating{
            if let doubleRating = Double(rating){
                deliveryPriceLbl.text = "\(doDouble(value: doubleRating))"
            }else{
                deliveryPriceLbl.text = "0.0"
            }
        }else{
            deliveryPriceLbl.text = "0.0"
        }
        
        guard let fav = record?.is_fav else {return }
        setHeartImage(isFav: fav)
    }
    
    
    
    func setRestaurantData(restaurant: Vendor?, indepath:IndexPath) {
        
        self.indepath = indepath
        
        if let url = URL(string: "\(BASEURL.imageUrl)\(restaurant?.thumb ?? "")"){
            restuarantImageview.kf.setImage(with: url)
        }
        restuarantNameLbl.text = restaurant?.name ?? ""
//        deliveryTimeLbl.text = record?.timings ?? ""
//        descriptionLbl.text = restaurant?.descriptionField ?? ""
//        deliveryPriceLbl.text = record?.rating ?? ""
        
        if let rating = restaurant?.radius{//rating
            if let doubleRating = Double(rating){
                deliveryPriceLbl.text = "\(doDouble(value: doubleRating))"
            }else{
                deliveryPriceLbl.text = "0.0"
            }
        }else{
            deliveryPriceLbl.text = "0.0"
        }
    }
    
    func setHeartImage(isFav:String){
        print("isFav \(isFav)")
        guard let fav = Int(isFav) else {return }
        if fav == 0{
            heatBtn.tintColor = UIColor(named: "AppDarkGrayColor")
        }else{
            heatBtn.tintColor = UIColor(named: "AppPrimaryBlueColor")
        }
        
    }
    

}



func doDouble(value:Double) -> Double{
    return (value*100).rounded()/100
}


