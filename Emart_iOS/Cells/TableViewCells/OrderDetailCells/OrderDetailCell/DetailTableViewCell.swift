//
//  OrderDetailTableViewCell.swift
//  EMart
//
//  Created by Yousaf Shafiq on 08/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static let cell_identifier = "DetailTableViewCell"
    
    @IBOutlet weak var order_number: UILabel!
    @IBOutlet weak var date_time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var gps_address: UILabel!
    @IBOutlet weak var status_name: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setData(records:Order){
        itemPrice.text = "Rs \(records.totalPrice ?? "0")"
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
