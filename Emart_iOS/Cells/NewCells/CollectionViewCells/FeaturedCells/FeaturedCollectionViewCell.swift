//
//  FeaturedCollectionViewCell.swift
//  EMart
//
//  Created by Muhammad Yousaf on 05/07/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import Kingfisher
protocol HeatButtonProtocol {
    func heartButtonPressed(indepath:IndexPath)
}

class FeaturedCollectionViewCell: UICollectionViewCell{

    @IBOutlet weak var restuarantImageview: UIImageView!
    @IBOutlet weak var restuarantNameLbl: UILabel!
    @IBOutlet weak var deliveryTimeLbl: UILabel!
    @IBOutlet weak var resturantDescriptionLabel: UILabel!
    @IBOutlet weak var deliveryPriceLbl: UILabel!
    
    @IBOutlet weak var heartBtn: UIButton!
    var heatButtonProtocol:HeatButtonProtocol?
    var indepath:IndexPath!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deliveryTimeLbl.layer.cornerRadius = 4.0
        deliveryTimeLbl.clipsToBounds = true
    }
    
    
    @IBAction func heartBtnTapped(_ sender: Any) {
        heatButtonProtocol?.heartButtonPressed(indepath: indepath)
    }
    
    func setData(record: showRestaurantsRecords?) {
        if let url = URL(string: "\(BASEURL.imageUrl)\(record?.thumb ?? "")"){
            
            restuarantImageview.kf.setImage(with: url)
        }
        restuarantNameLbl.text = record?.name ?? ""
        
        resturantDescriptionLabel.text = record?.description
        
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
    
    func setHeartImage(isFav:String){
        print("isFav \(isFav)")
        guard let fav = Int(isFav) else {return }
        if fav == 0{
            heartBtn.tintColor = UIColor(named: "AppDarkGrayColor")
        }else{
            heartBtn.tintColor = UIColor(named: "AppPrimaryBlueColor")
        }
        
    }

}//bookmark
