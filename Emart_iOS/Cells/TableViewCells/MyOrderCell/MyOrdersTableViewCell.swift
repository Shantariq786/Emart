//
//  MyOrdersTableViewCell.swift
//  EMart
//
//  Created by Yousaf Shafiq on 01/08/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
protocol MyOrderProtocol{
    func cancelBtnTapped(indexPath:IndexPath)
    func addReviewTapped(indexPath:IndexPath)
}

class MyOrdersTableViewCell: UITableViewCell {
    
    static let cell_identifier = "MyOrdersTableViewCell"
    
    var myOrderProtocol:MyOrderProtocol!
    var indexPath:IndexPath!
    
    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var resturantName: UILabel!
    @IBOutlet weak var orderStatis: UILabel!
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    
    @IBOutlet weak var bottomBtn: UIButton!
    @IBOutlet weak var bottomBtnHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func bottomBtnTapped(_ sender: Any) {
        if orderStatis.text == "Pending"{
            myOrderProtocol.cancelBtnTapped(indexPath: indexPath)
        }else if orderStatis.text == "Delivered"{
            myOrderProtocol.addReviewTapped(indexPath: indexPath)
        }
            
    }
    
    func setData(records:Order){
        
        orderStatis.text = records.statusName
        orderNumber.text = "Order No: # \(records.orderNumber ?? "")"
        orderPrice.text = "Rs \(records.totalPrice ?? "0")"
        resturantName.text = ""
        
        
        if records.status == "1" || records.status == "2"{
            bottomBtn.setTitle("CANCEL ORDER", for: .normal)
            bottomBtn.backgroundColor = UIColor(named: "AppDarkGrayColor")
            bottomBtnHeight.constant = 44
            bottomBtn.isHidden = false
            
        }else if records.status == "7"{
            bottomBtn.setTitle("ADD A REVIEW", for: .normal)
            bottomBtn.backgroundColor = UIColor(named: "AppPrimaryBlueColor")
            bottomBtnHeight.constant = 44
            bottomBtn.isHidden = false
            
        }else{
            bottomBtn.isHidden = true
            bottomBtnHeight.constant = 0
        }
        
        
//        address.text = records.address
//        gps_address.text = records.gpsAddress
//        date_time.text = records.dateTime
        
        
        
    }
}
