//
//  OrderDetailTableViewCell.swift
//  oye baryani
//
//  Created by Apple on 21/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var order_number: UILabel!
    @IBOutlet weak var date_time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var gps_address: UILabel!
    @IBOutlet weak var status_name: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
   // @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
//        itemImageView.layer.cornerRadius = itemImageView.frame.height/9
//        itemImageView.clipsToBounds = true
        
        
    }
    func setData(records:Order){
        itemPrice.text = "Rs \(records.totalPrice ?? "0")"
        //itemName.text = records.name
        itemQuantity.text = "Items:(\(records.count ?? ""))"
        order_number.text = "Order No: # \(records.orderNumber ?? "")"
        address.text = records.address
        gps_address.text = records.gpsAddress
        date_time.text = records.dateTime
        status_name.text = records.statusName
        
        
        
//        if let image = records.image
//        {
//            if let url = URL(string: "https://oyebiryani.com/images/\(image)"){
//                itemImageView.load(url: url)
//            }
//        }
        
        
    }
    
}
