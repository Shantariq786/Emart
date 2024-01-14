//
//  MainCollectionViewCell.swift
//  EMart
//
//  Created by Asad Khan on 5/9/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var restuarantImageview: UIImageView!
    @IBOutlet weak var restuarantNameLbl: UILabel!
    @IBOutlet weak var deliveryTimeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var deliveryPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        restuarantImageview.layer.cornerRadius = 8.0;
        restuarantImageview.contentMode = UIView.ContentMode.scaleAspectFill
        restuarantImageview.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        restuarantImageview.layer.shadowOpacity = 0.4
    }
    
    func setupData(record:showRestaurantsRecords?) {
        if let url = URL(string: "\(BASEURL.imageUrl)\(record?.thumb ?? "")"){
            restuarantImageview.load(url: url)
        }

        restuarantNameLbl.text = record?.name ?? ""
        deliveryTimeLbl.text = record?.timings ?? ""
        descriptionLbl.text = record?.description ?? ""
        deliveryPriceLbl.text = record?.rating ?? ""
    }

}
