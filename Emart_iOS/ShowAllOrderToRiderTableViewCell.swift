//
//  ShowAllOrderToRiderTableViewCell.swift
//  oye baryani
//
//  Created by Apple on 25/02/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ShowAllOrderToRiderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderAcceptButton: UIButton!
    @IBOutlet weak var orderViewButtonProcessing: UIButton!
    @IBOutlet weak var orderViewButtonDelivring: UIButton!
    @IBOutlet weak var orderDelivered: UIView!
    @IBOutlet weak var orderPendingView: UIView!
    @IBOutlet weak var userdiscription: UILabel!
    @IBOutlet weak var orderItems: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var userOrderNumber: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var userPhoneNumber: UILabel!
    @IBOutlet weak var totalBill: UILabel!
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    func setData(records:UserOrderRequestRecords)
    {
        userdiscription.text = records.description
        orderItems.text  = "\(records.count ?? "") Item(s)"
        orderDate.text = records.date_time
        orderStatus.text = records.status_name
        userOrderNumber.text = records.order_number
        userAddress.text = records.address
        userPhoneNumber.text = records.mobile_number
        totalBill.text = "RS \(records.total_price ?? "")"
        userName.text = records.name
        if records.status == "2"
        {
             orderPendingView.isHidden = false
            orderDelivered.isHidden = true
            
        }
        else{
            orderPendingView.isHidden = true
            orderDelivered.isHidden = false
            
        }
        
        
        
        
    }

}
